class ListArticles {
  final List<ArticleModel>? articles;

  ListArticles({this.articles});

  factory ListArticles.fromJson(Map<dynamic, dynamic> json) {
    return ListArticles(
      articles: List<ArticleModel>.from(
          (json['articles'] as List).map((e) => ArticleModel.fromJson(e))),
    );
  }
}

class ArticleModel {
  final String? title;
  final String? content;
  final String? image;
  final Map<String, dynamic>? created;

  ArticleModel({this.title, this.content, this.image, this.created});

  factory ArticleModel.fromJson(json) {
    return ArticleModel(
      title: json['title'],
      content: json['content'],
      image: json['image'],
      created: json['created'],
    );
  }
}
