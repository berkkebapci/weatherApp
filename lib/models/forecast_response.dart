import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/models/weather_forecast.dart';

part 'forecast_response.g.dart';

@JsonSerializable()
class ForecastResponse {
  final List<WeatherForecast> list;

  ForecastResponse({required this.list});

  factory ForecastResponse.fromJson(Map<String, dynamic> json) =>
      _$ForecastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastResponseToJson(this);
}
