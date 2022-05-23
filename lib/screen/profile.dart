// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sappyapp/components/profile_body.dart';
import 'package:sappyapp/manager/auth.dart';
import 'package:sappyapp/model/profile.dart';
import 'package:sappyapp/screen/message_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  User? user = AuthManager().getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 20.0 * 0.75),
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
          ),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 20.0 * 0.75),
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
                          "Levi",
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
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return MessageScreen();
                        }));
                      },
                      icon: Icon(Icons.chat_bubble)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings))
                ],
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
