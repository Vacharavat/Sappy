// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sappyapp/components/profile_body.dart';
import 'package:sappyapp/manager/auth.dart';
import 'package:sappyapp/model/profile.dart';
import 'package:sappyapp/screen/message_screen.dart';

import 'bot_profile_signup.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  User? user = AuthManager().getCurrentUser();
  String botDisplayName = "Sappy";

  void fetchUserBotData() async {
    await FirebaseFirestore.instance.collection("users").doc(user?.email).get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        print(data["botDisplayName"]);
        setState(() {
          botDisplayName = data["botDisplayName"];
        });
      }
    }).catchError((error) {
      print(2);
      print(error);
    });
  }

  _ProfileState() {
    fetchUserBotData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0 * 0.75),
              child: Row(
                children: [
                  user?.photoURL != null
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.network(user!.photoURL!).image,
                        )
                      : Container(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.logout,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.displayName ?? "",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "bio",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  )),
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings))
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0 * 0.75),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return MessageScreen();
                  }));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/image/botprofile.jpeg"),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            botDisplayName,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "bio",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    )),
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return MessageScreen();
                          }));
                        },
                        icon: Icon(Icons.chat_bubble)),
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return FirstBotProfile();
                          }));
                        },
                        icon: Icon(Icons.settings))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar ProfileAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF61B3FF),
      title: Text('Profile'),
    );
  }
}
