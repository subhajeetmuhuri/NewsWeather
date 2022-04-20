import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/secrets.dart';
import '../models/search_articles_model.dart';

class SearchApiService {
  Future<SearchModel> fetchArticles(
    http.Client client,
    String? query,
  ) async {
    final Map<String, String> queryParams = {
      'q': query!,
      'lang': 'en',
      'media': 'True',
    };

    final Uri url = Uri.https(
      'newscatcher.p.rapidapi.com',
      '/v1/search_free',
      queryParams,
    );

    const Map<String, String> headers = {
      'X-RapidAPI-Host': 'newscatcher.p.rapidapi.com',
      'X-RapidAPI-Key': NEWS_CATCHER_API_KEY,
    };

    final http.Response response = await client.get(
      url,
      headers: headers,
    );

    return compute(_parseArticles, response.body);
  }

  SearchModel _parseArticles(String responseBody) =>
      SearchModel.fromJson(jsonDecode(responseBody));
}
