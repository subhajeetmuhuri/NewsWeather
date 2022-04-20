import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/secrets.dart';
import '../models/weather_onecall_model.dart';

class WeatherOneCallApiService {
  Future<WeatherOneCallModel> fetchWeather(
    http.Client client,
    String? latitude,
    String? longitude,
  ) async {
    final Map<String, String> queryParams = {
      'lat': latitude!,
      'lon': longitude!,
      'appid': WEATHER_API_KEY,
      'exclude': 'minutely,alerts',
      'units': 'metric',
    };

    final Uri url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/onecall',
      queryParams,
    );

    final http.Response response = await client.get(url);
    return compute(_parseWeather, response.body);
  }

  WeatherOneCallModel _parseWeather(String responseBody) =>
      WeatherOneCallModel.fromJson(jsonDecode(responseBody));
}
