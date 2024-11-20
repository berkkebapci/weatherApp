import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/forecast_response.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/services/weather_service.dart';

class ControllerHome extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await fetchWeatherByLocation();
    await fetchForecastByLocation();
  }

  final TextEditingController searchController = TextEditingController();
  RxBool isBusy = false.obs;
  var weatherData = Rxn<WeatherResponse>();
  var forecastData = Rxn<ForecastResponse>();
  RxList<WeatherForecast> forecastList = <WeatherForecast>[].obs;
  final WeatherService _weatherService = WeatherService();

  Future<void> fetchWeather(String city) async {
    isBusy.value = true;
    try {
      var weather = await _weatherService.getWeatherByCity(city);
      weatherData.value = weather;
    } catch (e) {
      weatherData.value = null;
    }
    isBusy.value = false;
  }

  Future<void> fetchWeatherByLocation() async {
    isBusy.value = true;
    try {
      var weather = await _weatherService.getWeatherByLocation();
      weatherData.value = weather;
    } catch (e) {
      weatherData.value = null;
    }
    isBusy.value = false;
  }

  Future<void> fetchForecastByLocation() async {
    isBusy.value = true;
    forecastList.clear();
    try {
      var forecast = await _weatherService.fetchForecastByLocation();
      forecastData.value = forecast;
      forecastList.value = filterDailyForecasts(forecast.list);
    } catch (e) {
      weatherData.value = null;
    }
    isBusy.value = false;
  }

  Future<void> fetchForecast(String city) async {
    isBusy.value = true;
    forecastList.clear();
    try {
      var forecast = await _weatherService.fetchForecastByCity(city);
      forecastData.value = forecast;
      forecastList.value = filterDailyForecasts(forecast.list);
    } catch (e) {
      weatherData.value = null;
    }
    isBusy.value = false;
  }

  List<WeatherForecast> filterDailyForecasts(List<WeatherForecast> forecasts) {
    final Map<String, WeatherForecast> dailyForecasts = {};

    for (var forecast in forecasts) {
      final date = forecast.dt_txt.split(" ")[0];

      if (!dailyForecasts.containsKey(date)) {
        dailyForecasts[date] = forecast;
      } else {
        if (forecast.main.temp > dailyForecasts[date]!.main.temp) {
          dailyForecasts[date] = forecast;
        }
      }
    }

    return dailyForecasts.values.toList();
  }
}
