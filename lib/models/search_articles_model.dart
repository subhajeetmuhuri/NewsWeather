class SearchModel {
  SearchModel({
    required this.articles,
  });

  final List<SearchListModel> articles;

  factory SearchModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      SearchModel(
        articles: List<SearchListModel>.from(
          json['articles'].map(
            (x) => SearchListModel.fromJson(x),
          ),
        ),
      );
}

class SearchListModel {
  SearchListModel({
    required this.title,
    required this.link,
    required this.media,
  });

  final String title;
  final String link;
  final String? media;

  factory SearchListModel.fromJson(Map<String, dynamic> json) =>
      SearchListModel(
        title: json['title'],
        link: json['link'],
        media: json['media'],
      );
}
