// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as RB;
import 'package:sappyapp/components/message_body.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:sappyapp/screen/home.dart';

import '../manager/auth.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  User? user = AuthManager().getCurrentUser();
  String botDisplayName = "Sappy";
  String userEmotion = "neutral";
  final TextEditingController _controller = TextEditingController();

  late DialogFlowtter dialogFlowtter;
  List<Map<String, dynamic>> messages = [];

  void initialDialogFlowtter() async {
    await fetchUserData();
    // print("user emotion => " + userEmotion);
    String credential = "assets/credentials/dialog_flow_auth_natural.json";
    if (userEmotion == "happy") {
      credential = 'assets/credentials/dialog_flow_auth_happy.json';
    } else if (userEmotion == "sad") {
      credential = 'assets/credentials/dialog_flow_auth_sad.json';
    }

    String credentialsJsonString = await RB.rootBundle.loadString(credential);
    Map<String, dynamic> credentialJson = jsonDecode(credentialsJsonString);
    dialogFlowtter = DialogFlowtter.fromJson(credentialJson);
  }

  Future<void> fetchUserData() async {
    await FirebaseFirestore.instance.collection("users").doc(user?.email).get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        // print(data["emotion"]);
        userEmotion = data["emotion"];
        setState(() {
          botDisplayName = data["botDisplayName"];
        });
      }
    }).catchError((error) {
      throw error;
    });
  }

  @override
  void initState() {
    super.initState();
    initialDialogFlowtter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MessageAppBar(),
      body: Column(children: [
        Expanded(child: MessageBody(messages: messages)),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          color: Colors.blue,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Input message",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.send),
                onPressed: () {
                  sendMessage(_controller.text);
                  _controller.clear();
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void sendMessage(String text) async {
    if (text.isEmpty) return;
    setState(() {
      addMessage(
        Message(text: DialogText(text: [text])),
        true,
      );
    });

    // dialogFlowtter.projectId = "deimos-apps-0905";

    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: text)),
    );

    if (response.message == null) return;
    setState(() {
      addMessage(response.message!);
    });
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }

  @override
  void dispose() {
    dialogFlowtter.dispose();
    super.dispose();
  }

  AppBar MessageAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(children: [
        BackButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        }),
        // CircleAvatar(
        //   backgroundImage: AssetImage("assets/image/Bot.png"),
        // ),
        // SizedBox(
        //   width: 20.0 * 0.75,
        // ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              botDisplayName,
              style: TextStyle(fontSize: 20),
            )
          ],
        )
      ]),
    );
  }
}
