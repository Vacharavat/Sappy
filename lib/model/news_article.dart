import 'package:sappyapp/model/news_source.dart';

class Article {
  Source source;
  String? author;
  String title;
  String description;
  String? url;
  String urlToImage;
  String publishedAt;
  String? content;

  Article(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] as String?,
      title: json['title'] as String,
      description: json['description'] ??= "ไม่มีเนื้อหาข่าว",
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] ??=
          "https://theherotoys.com/wp-content/uploads/2020/11/no-image-available_1.png",
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String?,
    );
  }
}
