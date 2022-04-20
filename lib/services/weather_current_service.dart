import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/secrets.dart';
import '../models/weather_current_model.dart';

class WeatherCurrentApiService {
  Future<WeatherCurrentModel> fetchWeather(
    http.Client client,
    String? latitude,
    String? longitude,
  ) async {
    final Map<String, String> queryParams = {
      'lat': latitude!,
      'lon': longitude!,
      'appid': WEATHER_API_KEY,
      'units': 'metric',
    };

    final Uri url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      queryParams,
    );

    final http.Response response = await client.get(url);
    return compute(_parseWeather, response.body);
  }

  WeatherCurrentModel _parseWeather(String responseBody) =>
      WeatherCurrentModel.fromJson(jsonDecode(responseBody));
}
