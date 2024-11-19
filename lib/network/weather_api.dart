import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/models/forecast_response.dart';
import 'package:weather_app/models/weather_response.dart';
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

  @GET(Endpoints.getForecast)
  Future<ForecastResponse> getForecast({
    @Query("q") required String city,
    @Query("appid") required String apiKey,
    @Query("units") String units = "metric",
    @Query("lang") required String lang,
  });
}
