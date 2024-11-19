import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/network/weather_api.dart';
import 'package:weather_app/services/constant.dart';
import 'package:weather_app/services/weather_service.dart';

class ControllerHome extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await fetchWeatherByLocation();
  }

  final TextEditingController searchController = TextEditingController();
  RxBool isBusy = false.obs;
  var weatherData = Rxn<WeatherResponse>();

  final WeatherService _weatherService = WeatherService();

  Future<void> fetchWeather(String city) async {
    isBusy.value = true;
    try {
      var weather = await _weatherService.getWeatherByCity(city, ApiKey.weatherApiKey);
      weatherData.value = weather;
    } catch (e) {
      weatherData.value = null;
    }
    isBusy.value = false;
  }

  Future<void> fetchWeatherByLocation() async {
    isBusy.value = true;
    try {
      var weather = await _weatherService.getWeatherByLocation(ApiKey.weatherApiKey);
      weatherData.value = weather;
    } catch (e) {
      weatherData.value = null;
    }
    isBusy.value = false;
  }
}
