// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/network/weather_api.dart';
import 'package:weather_app/services/constant.dart';
import 'package:weather_app/services/endpoint.dart';

class WeatherService {
  late WeatherApi _weatherApi;
  final Dio dio = Dio();

  WeatherService() {
    dio.options.baseUrl = Endpoints.baseUrl;
    _weatherApi = WeatherApi(dio);
  }

  Future<WeatherResponse> getWeatherByLocation(String apiKey) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();

      if (!serviceEnabled || permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      final city = await _getCityFromCoordinates(position.latitude, position.longitude);

      final weather = await _weatherApi.getWeather(
        city: city,
        apiKey: apiKey,
        lang: 'tr',
      );

      return weather;
    } catch (e) {
      rethrow;
    }
  }

  Future<WeatherResponse> getWeatherByCity(String city, String apiKey) async {
    try {
      final weather = await _weatherApi.getWeather(
        city: city,
        apiKey: apiKey,
        units: 'metric',
        lang: 'tr',
      );

      return weather;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _getCityFromCoordinates(double latitude, double longitude) async {
    try {
      final response = await dio.get(
        Endpoints.baseUrl + Endpoints.getWeather,
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'appid': ApiKey.weatherApiKey,
        },
      );

      return response.data['name'];
    } catch (e) {
      throw Exception('Failed to get city name');
    }
  }
}
