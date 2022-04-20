import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/articles_model.dart';

class ArticlesApiService {
  Future<ArticlesModel> fetchArticles(
      http.Client client, String? selectedCategory) async {
    String path;

    if (selectedCategory == 'business' ||
        selectedCategory == 'entertainment' ||
        selectedCategory == 'health' ||
        selectedCategory == 'science' ||
        selectedCategory == 'sports' ||
        selectedCategory == 'technology') {
      path = '/subhajeetmuhuri/newsapi/main/categories/$selectedCategory.json';
    } else {
      path = '/subhajeetmuhuri/newsapi/main/sources/$selectedCategory.json';
    }

    final Uri url = Uri.https('raw.githubusercontent.com', path);

    final http.Response response = await client.get(url);
    return compute(_parseArticles, response.body);
  }

  ArticlesModel _parseArticles(String responseBody) =>
      ArticlesModel.fromJson(jsonDecode(responseBody));
}
