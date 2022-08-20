import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/services/api_services.dart';

class MainController extends GetxController {
  var currentWeatherData;
  @override
  void onInit() {
    // TODO: implement onInit
    currentWeatherData = getCurrentWeather();
    super.onInit();

  }
  var isDark = false.obs;

  // ignore: prefer_typing_uninitialized_variables

  changeTheme(){
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

}
