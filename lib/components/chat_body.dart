import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sappyapp/screen/message_screen.dart';

import '../manager/auth.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  User? user = AuthManager().getCurrentUser();
  String botDisplayName = "Sappy";

  void fetchUserBotData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.email)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          botDisplayName = data["botDisplayName"];
        });
      }
    }).catchError((error) {
      throw error;
    });
  }

  _ChatBodyState() {
    fetchUserBotData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageScreen(),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 20.0 * 0.75),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage("assets/image/botprofile.jpeg"),
                    ),
                    // Positioned(
                    //   right: 0,
                    //   bottom: 0,
                    //   child: Container(
                    //     height: 20,
                    //     width: 20,
                    //     decoration: BoxDecoration(
                    //         color: Color.fromARGB(255, 250, 107, 96),
                    //         shape: BoxShape.circle,
                    //         border:
                    //             Border.all(color: Color(0xFFFFFFFF), width: 1)),
                    //     child: Text("2",
                    //         style: TextStyle(color: Colors.white),
                    //         textAlign: TextAlign.center),
                    //   ),
                    // )
                  ],
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        botDisplayName,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 6),
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          "เป็นยังไงบ้างวันนี้",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )),
                // Opacity(opacity: 0.5, child: Text("2m ago"))
              ],
            ),
          ),
        )
      ],
    );
  }
}
