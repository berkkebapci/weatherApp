import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/models/main.dart';
import 'package:weather_app/models/weather.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  final String name;
  final Main main;
  final List<Weather> weather;

  WeatherResponse({
    required this.name,
    required this.main,
    required this.weather,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}
