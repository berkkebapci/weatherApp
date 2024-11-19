import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/services/endpoint.dart';

part 'weather_api.g.dart';

@RestApi(baseUrl: Endpoints.baseUrl)
abstract class WeatherApi {
  factory WeatherApi(Dio dio, {String baseUrl}) = _WeatherApi;

  @GET(Endpoints.getWeather)
  Future<WeatherResponse> getWeather({
    @Query("q") required String city,
    @Query("appid") required String apiKey,
    @Query("units") String units = "metric",
    @Query("lang") required String lang,
  });
}

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

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

@JsonSerializable()
class Main {
  final double temp;
  final double feels_like;

  Main({
    required this.temp,
    required this.feels_like,
  });

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Weather {
  final String description;
  final String icon;

  Weather({
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

class _WeatherApi implements WeatherApi {
  final Dio _dio;
  String? baseUrl;

  _WeatherApi(this._dio, {this.baseUrl});

  @override
  Future<WeatherResponse> getWeather({
    required String city,
    required String apiKey,
    String units = "metric",
    required String lang,
  }) async {
    final response = await _dio.get(
      'weather',
      queryParameters: {
        'q': city,
        'appid': apiKey,
        'units': units,
        'lang': lang,
      },
    );
    return WeatherResponse.fromJson(response.data);
  }
}
