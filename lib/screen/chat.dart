import 'package:flutter/material.dart';
import 'package:sappyapp/components/chat_body.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(),
      body: ChatBody(),
    );
  }

  // ignore: non_constant_identifier_names
  AppBar ChatAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF61B3FF),
      title: Text('Chat'),
    );
  }
}
