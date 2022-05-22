import 'package:flutter/material.dart';
import 'package:sappyapp/screen/home.dart';

import 'package:sappyapp/screen/profile_signup.dart';

class FirstBotProfile extends StatefulWidget {
  const FirstBotProfile({Key? key}) : super(key: key);

  @override
  _FirstBotProfileState createState() => _FirstBotProfileState();
}

class _FirstBotProfileState extends State<FirstBotProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF61B3FF)),
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Container(
                    width: 370,
                    height: 687,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          width: 350,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.blue,
                                    size: 15,
                                  ),
                                  TextButton(
                                      child: Text(
                                        "Go back to profile",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ProfileSign();
                                        }));
                                      }),
                                ],
                              ),
                              Text(
                                "Bot profile",
                                style: TextStyle(
                                    fontSize: 56, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15),
                              Text("Display Name",
                                  style: TextStyle(fontSize: 20)),
                              TextFormField(),
                              SizedBox(height: 400),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        primary: Color(0xFF0078E8),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 40)),
                                    onPressed: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HomeScreen();
                                      }));
                                    },
                                    child: Text("Finish",
                                        style: TextStyle(fontSize: 20))),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
