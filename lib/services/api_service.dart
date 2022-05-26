import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sappyapp/model/emotion_check.dart';

import 'package:sappyapp/model/news_article.dart';

class ApiService {
  Future<List<Article>> getArticle() async {
    var endPointUrl =
        "https://newsapi.org/v2/top-headlines?country=th&apiKey=fc19923a3e124b95bdae8e3c0df8949c";
    var res = await http.get(Uri.parse(endPointUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json['articles'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ("Can't get the Ariticles");
    }
  }

  Future<Emotion> getEmotion(
      int age, int bmi, int heartRate, int diffHeart) async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/emotion?age=$age&bmi=$bmi&heart_rate=$heartRate&diff_heart=$diffHeart'));

    if (response.statusCode == 200) {
      return Emotion.fromJson(jsonDecode(response.body));
    } else {
      throw ("Can't get Emotion");
    }
  }
}
