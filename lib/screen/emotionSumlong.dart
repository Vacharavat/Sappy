import 'package:flutter/material.dart';

class EmotionsScreen extends StatefulWidget {
  const EmotionsScreen({Key? key}) : super(key: key);

  @override
  State<EmotionsScreen> createState() => _EmotionsScreenState();
}

class _EmotionsScreenState extends State<EmotionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF61B3FF),
        title: Text('Emotion'),
      ),
    );
  }
}
