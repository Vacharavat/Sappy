import 'package:flutter/material.dart';
import 'package:sappyapp/model/news_article.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key, required this.article}) : super(key: key);

  final Article article;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(article.urlToImage),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(8.0))),
            SizedBox(
              height: 8.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.source.name,
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(article.publishedAt,
                    style: TextStyle(color: Colors.black54))
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(article.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
            SizedBox(
              height: 8.0,
            ),
            Text(article.description, style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
