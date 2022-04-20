import 'package:flutter/material.dart';

import '../../models/articles_model.dart';
import '../custom_cached_network_image.dart';
import '../webview/webview.dart';

class HomeArticleList extends StatelessWidget {
  const HomeArticleList({
    Key? key,
    required this.articles,
    required this.selectedCategory,
  }) : super(key: key);

  final List<ArticleListModel> articles;
  final String selectedCategory;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight!;

    final double width = MediaQuery.of(context).size.width;

    return ListView(
      children: <Widget>[
        const SizedBox(
          height: 4.0,
        ),
        ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: articles.length,
          itemBuilder: (
            BuildContext context,
            int index,
          ) =>
              _buildArticleCard(
            articles[index],
            context,
            height,
            width,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }

  Widget _buildArticleCard(
    ArticleListModel article,
    BuildContext context,
    double height,
    double width,
  ) =>
      Container(
        height: height / 3,
        width: width,
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 5.0,
        ),
        child: Card(
          elevation: 10.0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebViewApp(
                  url: article.url,
                  title: selectedCategory,
                ),
              ),
            ),
            child: Stack(
              children: <Widget>[
                CustomCachedNetworkImage(
                  url: article.urlToImage,
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
                      '${article.title}\n',
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
