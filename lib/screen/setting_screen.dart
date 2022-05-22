// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

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
    );
  }

  AppBar SettingAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF61B3FF),
      title: Text('Setting'),
    );
  }
}
