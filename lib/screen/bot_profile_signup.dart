import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sappyapp/manager/auth.dart';
import 'package:sappyapp/model/profile.dart';
import 'package:sappyapp/screen/home.dart';

import 'package:sappyapp/screen/profile_signup.dart';

class FirstBotProfile extends StatefulWidget {
  const FirstBotProfile({Key? key}) : super(key: key);

  @override
  _FirstBotProfileState createState() => _FirstBotProfileState();
}

class _FirstBotProfileState extends State<FirstBotProfile> {
  final formKey = GlobalKey<FormState>();
  User? user = AuthManager().getCurrentUser();
  String? botDisplayName;
  final textController = TextEditingController();

  Future<String> fetchUserBotData() async {
    String name = await FirebaseFirestore.instance.collection("users").doc(user?.email).get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        return data["botDisplayName"];
      }
    }).catchError((error) {
      return null;
    });
    return name;
  }

  void updateBotDisplayName() async {
    await FirebaseFirestore.instance.collection("users").doc(user?.email).set(
      {"botDisplayName": botDisplayName},
      SetOptions(merge: true),
    ).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.message.toString(), gravity: ToastGravity.CENTER);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserBotData().then((value) {
      textController.text = value;
      setState(() {});
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(botDisplayName);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF61B3FF)),
        alignment: Alignment.center,
        child: Form(
          key: formKey,
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: 370,
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15),
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
                                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                          return HomeScreen();
                                        }));
                                      }),
                                ],
                              ),
                              Text(
                                "Bot profile",
                                style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15),
                              Text("Display Name", style: TextStyle(fontSize: 20)),
                              TextFormField(
                                // initialValue: botDisplayName,
                                controller: textController,
                                validator: MultiValidator([RequiredValidator(errorText: "กรุณาชื่อบอต")]),
                                keyboardType: TextInputType.text,
                                onSaved: (String? displayName) {
                                  botDisplayName = displayName!;
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        primary: Color(0xFF0078E8),
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40)),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        updateBotDisplayName();
                                      }
                                    },
                                    child: Text("Finish", style: TextStyle(fontSize: 20))),
                              ),
                              SizedBox(height: 15),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
