import 'package:flutter/material.dart';
import 'package:sappyapp/model/emotion_check.dart';
import 'package:sappyapp/services/api_service.dart';

class EmotionScreen extends StatefulWidget {
  const EmotionScreen({Key? key}) : super(key: key);

  @override
  State<EmotionScreen> createState() => _EmotionScreenState();
}

class _EmotionScreenState extends State<EmotionScreen> {
  ApiService client = ApiService();

  int get age => 0;
  int get bmi => 0;
  int get diffHeart => 0;
  int get heartRate => 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EmotionAppBar(),
        body: FutureBuilder(
          future: client.getEmotion(age, bmi, heartRate, diffHeart),
          builder: (BuildContext context, AsyncSnapshot<Emotion> snapshot) {
            if (snapshot.hasData) {
              Emotion? emotion = snapshot.data;
              return Column(
                children: [],
                mainAxisAlignment: MainAxisAlignment.center,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  AppBar EmotionAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF61B3FF),
      title: Text('Emotion'),
    );
  }
}
