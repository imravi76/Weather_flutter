import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:open_settings/open_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/model/cities.dart';
import 'package:weather/model/weather_data.dart';

import '../databasehelper.dart';
import '../fetch_weather.dart';

class GlobalController extends GetxController {

  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;
  final RxInt tabIndex = 0.obs;
  RxBool connection = false.obs;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  RxBool checkConnection() => connection;

  final weatherData = WeatherData().obs;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  WeatherData getData(){
    return weatherData.value;
  }

  changeTabIndex() {
    return tabIndex.value;
  }

  @override
  void onInit() async {
    super.onInit();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionState);

    checkConnection();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey('lat') == false){
      getLocation(prefs);
    } else{
      getIndex();
      getAlreadyData();
      getRefresh();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  getLocation(prefs) async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return OpenSettings.openLocationSourceSetting();
    } else {

      locationPermission = await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          exit(0);
          
        }
      }

      if (locationPermission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are permanently denied.');
      }

      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .then((value) async {
        _latitude.value = value.latitude;
        _longitude.value = value.longitude;

        prefs.setInt('c_id', 1);
        prefs.setDouble('lat', _latitude.value);
        prefs.setDouble('lon', _longitude.value);
        prefs.setString('units', 'metric');

        List<Placemark> placemark = await placemarkFromCoordinates(
            _latitude.value, _longitude.value);
        Placemark place = placemark[0];

        Cities cities = Cities(c_id: 1,
            country: place.country!,
            name: place.locality!,
            lat: _latitude.value,
            lon: _longitude.value,
            defaults: "true",
            sets: "true");
        _dbHelper.insertCities(cities);

        return FetchWeatherAPI().processData(value.latitude, value.longitude)
            .then((value) {
          weatherData.value = value;
          _isLoading.value = false;
        });
      });
    }
  }

  getAlreadyData() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return FetchWeatherAPI().processData(prefs.getDouble('lat'), prefs.getDouble('lon'))
        .then((value) {
      weatherData.value = value;
      _isLoading.value = false;
    });
  }

  getRefresh() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    return FetchWeatherAPI().getDataFromAPI(prefs.getDouble('lat'), prefs.getDouble('lon'))
        .then((value) {
      weatherData.value = value;
      _isLoading.value = false;
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }

  Future< void > updateConnectionState(ConnectivityResult result) async {
    
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      connection = true.obs;
    }else{
      connection = false.obs;
    }
  }

}
