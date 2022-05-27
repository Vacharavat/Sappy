import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sappyapp/manager/auth.dart';
import 'package:sappyapp/model/emotion_check.dart';
import 'package:sappyapp/services/api_service.dart';

class EmotionScreen extends StatefulWidget {
  const EmotionScreen({Key? key}) : super(key: key);

  @override
  State<EmotionScreen> createState() => _EmotionScreenState();
}

class _EmotionScreenState extends State<EmotionScreen> {
  User? user = AuthManager().getCurrentUser();
  ApiService client = ApiService();
  String emotion = "";

  int age = 21;
  int bmi = 19;
  int diffHeart = 0;
  int heartRate = 0;

  Random rnd = Random();
  int minHeartRate = 60;
  int maxHeartRate = 145;

  void updateUserEmotion(String emotion) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.email)
        .set(
          {"emotion": emotion},
          SetOptions(merge: true),
        )
        .then((value) {})
        .catchError((error) {
          Fluttertoast.showToast(
              msg: error.message.toString(), gravity: ToastGravity.CENTER);
        });
  }

  void randomHeartRate() async {
    int r = minHeartRate + rnd.nextInt(maxHeartRate - minHeartRate);
    diffHeart = (heartRate - r).abs() > 41 ? 50 : (heartRate - r).abs();
    Emotion emotionResult = await client.getEmotion(
      age,
      bmi,
      heartRate,
      diffHeart,
    );
    updateUserEmotion(emotionResult.emotion);
    setState(() {
      emotion = emotionResult.emotion;
      heartRate = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emotionAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            emotion == ""
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text("Emotion: " + emotion),
                  ),
            Text("อัตราการเต้นของหัวใจคุณอยู่ที่: $heartRate bpm. "),
            IconButton(
              onPressed: randomHeartRate,
              icon: Icon(Icons.cached),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    updateUserEmotion("happy");
                  },
                  child: Text("Happy"),
                ),
                ElevatedButton(
                  onPressed: () {
                    updateUserEmotion("neutral");
                  },
                  child: Text("Neutral"),
                ),
                ElevatedButton(
                  onPressed: () {
                    updateUserEmotion("sad");
                  },
                  child: Text("Sad"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AppBar emotionAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF61B3FF),
      title: Text('Emotion'),
    );
  }
}
