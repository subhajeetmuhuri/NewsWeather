class ArticlesModel {
  ArticlesModel({
    required this.articles,
  });

  final List<ArticleListModel> articles;

  factory ArticlesModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      ArticlesModel(
        articles: List<ArticleListModel>.from(
          json['articles'].map(
            (x) => ArticleListModel.fromJson(x),
          ),
        ),
      );
}

class ArticleListModel {
  ArticleListModel({
    required this.title,
    required this.url,
    required this.urlToImage,
  });

  final String title;
  final String url;
  final String? urlToImage;

  factory ArticleListModel.fromJson(Map<String, dynamic> json) =>
      ArticleListModel(
        title: json['title'],
        url: json['url'],
        urlToImage: json['urlToImage'],
      );
}
