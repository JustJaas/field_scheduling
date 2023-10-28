import 'package:dio/dio.dart';
import 'package:field_scheduling/data/services/weather_interceptor.dart';
import 'package:field_scheduling/domain/models/weather_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  final Dio dioWeather;
  final String urlWeather =
      "https://api.openweathermap.org/data/2.5/forecast?lat=";

  WeatherService() : dioWeather = Dio()..interceptors.add(WeatherInterceptor());

  Future<WeatherResponse> getData(String courtId) async {
    String fullUrl = "";
    if (courtId == "A") {
      fullUrl =
          '$urlWeather${dotenv.get('PANAMA_LAT')}&lon=${dotenv.get('PANAMA_LNG')}';
    } else if (courtId == "B") {
      fullUrl =
          '$urlWeather${dotenv.get('INDIA_LAT')}&lon=${dotenv.get('INDIA_LNG')}';
    } else if (courtId == "C") {
      fullUrl =
          '$urlWeather${dotenv.get('ESPANA_LAT')}&lon=${dotenv.get('ESPANA_LNG')}';
    }

    final response = await dioWeather.get(fullUrl);

    if (response.statusCode == 200) {
      final WeatherResponse weatherResponse =
          WeatherResponse.fromJson(response.data);
      return weatherResponse;
    } else {
      throw Exception('Error al cargar los datos meteorológicos');
    }
  }
}
