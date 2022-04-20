import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_feed.dart';

import '../models/trends_model.dart';

class TrendsRssService {
  Future<List<TrendsModel>> fetchTrends(http.Client client) async {
    const Map<String, String> queryParams = {
      'geo': 'IN',
    };

    final Uri url = Uri.https(
      'trends.google.com',
      '/trends/trendingsearches/daily/rss',
      queryParams,
    );

    final http.Response response = await client.get(url);
    return compute(_parseTrends, response.body);
  }

  List<TrendsModel> _parseTrends(String responseBody) =>
      RssFeed.parse(responseBody)
          .items!
          .map((item) => TrendsModel(
                title: item.title,
              ))
          .toList();
}
