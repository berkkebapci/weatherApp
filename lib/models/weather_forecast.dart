import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/models/main.dart';
import 'package:weather_app/models/weather.dart';

part 'weather_forecast.g.dart';

@JsonSerializable()
class WeatherForecast {
  final Main main;
  final List<Weather> weather;
  final String dt_txt;

  WeatherForecast({
    required this.main,
    required this.weather,
    required this.dt_txt,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastToJson(this);
}
