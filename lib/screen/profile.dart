// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sappyapp/components/profile_body.dart';
import 'package:sappyapp/model/profile.dart';
import 'package:sappyapp/screen/message_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  // FirebaseAuth auth = FirebaseAuth.instance;
  Profile? currentUser;
  // User? user = auth.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: Column(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 20.0 * 0.75),
              child: Row(
                children: [
                  // CircleAvatar(
                  //   radius: 30,
                  //   backgroundImage: AssetImage(chat.image),
                  // ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUser?.email ?? "",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
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
          ))
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
