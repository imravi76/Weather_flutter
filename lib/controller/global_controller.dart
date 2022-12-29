import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather/model/weather_data.dart';

import '../databasehelper.dart';
import '../fetch_weather.dart';

class GlobalController extends GetxController {

  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;
  final RxInt tabIndex = 0.obs;
  bool connection = false;

  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  WeatherData getData(){
    return weatherData.value;
  }

  changeTabIndex() {
    return tabIndex.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else{
      getIndex();
    }
    super.onInit();
    checkConnection();
  }

  checkConnection() async{
    await InternetConnectionChecker().hasConnection.then(
            (value) => connection = value);
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("Location Disabled!");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        exit(0);
        return Future.error('Location permissions are denied');
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;

      return FetchWeatherAPI().processData(value.latitude, value.longitude)
        .then((value) {
          weatherData.value = value;
          _isLoading.value = false;
          //print(weatherData.value.toString());
      });

    });
  }

  getRefresh() async{
    return FetchWeatherAPI().processData(_latitude, _longitude)
        .then((value) {
      weatherData.value = value;
      _isLoading.value = false;
      //print(weatherData.value.toString());
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }

}


