// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sappyapp/components/message_body.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
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
        BackButton(),
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
              "Levi",
              style: TextStyle(fontSize: 20),
            )
          ],
        )
      ]),
    );
  }
}
