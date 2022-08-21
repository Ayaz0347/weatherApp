import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weatherapp/services/api_services.dart';

class MainController extends GetxController {
  @override
  void onInit() async{
    // TODO: implement onInit
    await getUserLocation();
    currentWeatherData = getCurrentWeather(latitude.value,longitude.value);
    hourlyWeatherData = getHourlyWeather(latitude.value,longitude.value);

    super.onInit();
  }

  var isDark = false.obs;
  var currentWeatherData;
  var hourlyWeatherData;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  // ignore: prefer_typing_uninitialized_variables
  getUserLocation() async {
    bool isLocationenabled;
    LocationPermission userPersmission;
    isLocationenabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationenabled) {
      return Future.error("Location is not enabled");
    }
    userPersmission = await Geolocator.checkPermission();
    if (userPersmission == LocationPermission.deniedForever) {
      return Future.error("Permission is Denied forever");
    } else if (userPersmission == LocationPermission.denied) {
      userPersmission = await Geolocator.requestPermission();
      if (userPersmission == LocationPermission.denied) {
        return Future.error("Permission is denied");
      }
    }
   return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value){
      latitude.value = value.latitude;
      longitude.value = value.longitude;
      print("all Set");

   });
  }

  changeTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
