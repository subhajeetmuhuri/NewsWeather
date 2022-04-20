import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/search_articles_model.dart';
import '../../models/trends_model.dart';
import '../../services/search_articles_service.dart';
import '../../services/trends_service.dart';
import '../snack_bar.dart';
import 'search_article_list.dart';

class MySearchDelegate extends SearchDelegate {
  final TrendsRssService _trendsClient = TrendsRssService();
  final SearchApiService _searchClient = SearchApiService();

  @override
  String get searchFieldLabel => 'Search News';

  @override
  List<Widget>? buildActions(BuildContext context) => <Widget>[
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              mySnackBar(context, 'Nothing to clear!');
            } else {
              query = '';
              showSuggestions(context);
            }
          },
          icon: const Icon(Icons.clear),
          tooltip: 'Clear',
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
        tooltip: 'Back',
      );

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<SearchModel>(
        future: _searchClient.fetchArticles(http.Client(), query),
        builder: (context, snapshot) {
          if (query.isEmpty) {
            return const Center(
              child: Text(
                'Enter some query to search!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          } else if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return SearchArticleList(
              articles: snapshot.data!.articles,
              query: query,
            );
          } else {
            return const Center(
              child: Text('An error has occurred!'),
            );
          }
        },
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return FutureBuilder<List<TrendsModel>>(
        future: _trendsClient.fetchTrends(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final String suggestion = snapshot.data![index].title!;
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.trending_up_sharp),
                      title: Text(suggestion),
                      onTap: () {
                        query = suggestion;
                        showResults(context);
                      },
                    ),
                    if (index < snapshot.data!.length - 1) const Divider(),
                  ],
                );
              },
            );
          } else {
            return Container();
          }
        },
      );
    } else {
      return Container();
    }
  }
}
