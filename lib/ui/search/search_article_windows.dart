import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/search_articles_model.dart';
import '../../services/search_articles_service.dart';
import '../custom_cached_network_image.dart';
import '../scroll_controller_windows.dart';
import '../webview/webview_windows.dart';

class SearchArticlesWindows extends StatelessWidget {
  SearchArticlesWindows({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String query;
  final SearchApiService _searchClient = SearchApiService();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Search results for $query'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: FutureBuilder<SearchModel>(
            future: _searchClient.fetchArticles(http.Client(), query),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return GridView.builder(
                  controller: ScrollControllerWindows(),
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 16 / 9,
                  ),
                  itemCount: snapshot.data!.articles.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                    elevation: 10.0,
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewWindows(
                            url: snapshot.data!.articles[index].link,
                            title: query,
                          ),
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          CustomCachedNetworkImage(
                            url: snapshot.data!.articles[index].media,
                          ),
                          Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            left: 0.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '${snapshot.data!.articles[index].title}\n',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              }
            },
          ),
        ),
      );
}
