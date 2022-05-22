// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sappyapp/manager/auth.dart';
import 'package:sappyapp/screen/login.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingAppBar(),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 17),
        child: Column(children: [
          // Logout menu
          InkWell(
            onTap: (() {
              AuthManager().logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            }),
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 24.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text("Logout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  AppBar SettingAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF61B3FF),
      title: Text('Setting'),
    );
  }
}
