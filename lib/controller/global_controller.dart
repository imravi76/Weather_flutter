import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
  void onInit() async {
   /* if (_isLoading.isTrue) {
      getLocation();
    } else{
      getIndex();
    }*/
    super.onInit();
    checkConnection();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey('lat') == false){
      getLocation();
      //_isLoading.isFalse;
      
    } else{
      getIndex();
      getRefresh();
    }
  }

  checkConnection() async{
    await InternetConnectionChecker().hasConnection.then(
            (value) => connection = value);
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    /*Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File('${appDocPath}/1.txt');*/

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
        .then((value) async {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;

      prefs.setInt('c_id', 1);
      prefs.setDouble('lat', _latitude.value);
      prefs.setDouble('lon', _longitude.value);

      List<Placemark> placemark = await placemarkFromCoordinates(_latitude.value, _longitude.value);
      Placemark place = placemark[0];

      Cities cities = Cities(c_id: 1, country: place.country!, name: place.locality!, lat: _latitude.value, lon: _longitude.value, defaults: "true", sets: "true");
      _dbHelper.insertCities(cities);

      return FetchWeatherAPI().processData(value.latitude, value.longitude)
        .then((value) {
          weatherData.value = value;
          _isLoading.value = false;
          //file.writeAsStringSync(getData().toString());
          //print("Write Successful");
      });

    });
  }

  getRefresh() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return FetchWeatherAPI().processData(prefs.getDouble('lat'), prefs.getDouble('lon'))
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


