// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sappyapp/components/news_body.dart';
import 'package:sappyapp/model/news_article.dart';
import 'package:sappyapp/services/api_service.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ApiService client = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewsAppBar(),
        body: FutureBuilder(
          future: client.getArticle(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article>? articles = snapshot.data;
              return ListView.builder(
                itemCount: articles?.length,
                itemBuilder: (context, index) =>
                    NewsBody(articles![index], context),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  AppBar NewsAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF61B3FF),
      title: Text('News'),
    );
  }
}
