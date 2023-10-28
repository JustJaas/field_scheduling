import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherInterceptor extends Interceptor {
  final apiKey = dotenv.get('KEY');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'appid': apiKey,
      'units': 'metric',
      'lang': 'es',
    });

    super.onRequest(options, handler);
  }
}
