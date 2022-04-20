import 'package:flutter/material.dart';

import '../../models/articles_model.dart';
import '../custom_cached_network_image.dart';
import '../scroll_controller_windows.dart';
import '../webview/webview_windows.dart';

class HomeArticleListWindows extends StatelessWidget {
  const HomeArticleListWindows({
    Key? key,
    required this.articles,
    required this.selectedCategory,
  }) : super(key: key);

  final List<ArticleListModel> articles;
  final String selectedCategory;

  @override
  Widget build(BuildContext context) => GridView.builder(
        controller: ScrollControllerWindows(),
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 16 / 9,
        ),
        itemCount: articles.length,
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
                  url: articles[index].url,
                  title: selectedCategory,
                ),
              ),
            ),
            child: Stack(
              children: <Widget>[
                CustomCachedNetworkImage(
                  url: articles[index].urlToImage,
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
                      '${articles[index].title}\n',
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
}
