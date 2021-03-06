import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sappyapp/model/profile.dart';
import 'package:sappyapp/screen/home.dart';
import 'package:sappyapp/screen/login.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sappyapp/utils/storage.dart';
import 'package:path/path.dart' as p;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final formKey = GlobalKey<FormState>();

  Profile profile = Profile();
  File? userProfile;
  XFile? image;

  Future<void> getImage() async {
    final picker = ImagePicker();
    try {
      XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      // print("--");
      // print(image);
      // print("--");
      setState(() {
        userProfile = File(image?.path ?? "");
      });
    } catch (e) {
      print(e);
    }
  }

  Future<String> uploadFile(String email) async {
    String refPath = 'userImage/$email/${p.basename(image?.path ?? "")}';
    Reference? ref = await StroageUtils.uploadFile(userProfile!, refPath);
    String? _uploadedFileURL = await ref?.getDownloadURL();
    return _uploadedFileURL ?? "";
  }

  @override
  Widget build(BuildContext context) {
    print(userProfile);
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(color: Color(0xFF61B3FF)),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 40),
                          Container(
                            width: 370,
                            // height: 687,
                            padding: EdgeInsets.only(bottom: 20),
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
                                                "Go back to login",
                                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                              ),
                                              onPressed: () {
                                                Navigator.pushReplacement(context,
                                                    MaterialPageRoute(builder: (context) {
                                                  return LoginScreen();
                                                }));
                                              }),
                                        ],
                                      ),
                                      Text(
                                        "Sign up",
                                        style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: getImage,
                                            child: Stack(
                                              alignment: AlignmentDirectional.bottomEnd,
                                              children: [
                                                userProfile == null
                                                    ? Icon(
                                                        Icons.account_circle,
                                                        color: Colors.blue[600],
                                                        size: 100.0,
                                                      )
                                                    : Container(
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Colors.white,
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            alignment: FractionalOffset.topCenter,
                                                            image: Image.file(userProfile!).image,
                                                          ),
                                                        ),
                                                      ),
                                                Container(
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: Icon(
                                                    Icons.photo_camera,
                                                    color: Colors.white,
                                                    size: 30.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text("Username", style: TextStyle(fontSize: 16)),
                                      TextFormField(
                                        validator: MultiValidator([RequiredValidator(errorText: "??????????????????????????????????????????")]),
                                        keyboardType: TextInputType.text,
                                        onSaved: (String? username) {
                                          profile.username = username!;
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      Text("Email", style: TextStyle(fontSize: 16)),
                                      TextFormField(
                                        validator: MultiValidator([
                                          RequiredValidator(errorText: "??????????????????????????????????????????"),
                                          EmailValidator(errorText: "???????????????????????????????????????????????????????????????")
                                        ]),
                                        keyboardType: TextInputType.emailAddress,
                                        onSaved: (String? email) {
                                          profile.email = email!;
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Password", style: TextStyle(fontSize: 16)),
                                      TextFormField(
                                        validator: RequiredValidator(errorText: "???????????????????????????????????????????????????"),
                                        obscureText: true,
                                        onSaved: (String? password) {
                                          profile.password = password!;
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      // Text("Confirm Password",
                                      //     style: TextStyle(fontSize: 20)),
                                      // TextFormField(
                                      //   validator: RequiredValidator(
                                      //       errorText: "???????????????????????????????????????????????????"),
                                      //   obscureText: true,
                                      // ),
                                      SizedBox(height: 20),
                                      // Text("Date of Birth",
                                      //     style: TextStyle(fontSize: 20)),
                                      // TextFormField(
                                      //   validator: MultiValidator([
                                      //     RequiredValidator(
                                      //         errorText: "??????????????????????????????????????????"),
                                      //     EmailValidator(
                                      //         errorText:
                                      //             "???????????????????????????????????????????????????????????????")
                                      //   ]),
                                      //   keyboardType:
                                      //       TextInputType.emailAddress,
                                      //   onSaved: (String? email) {
                                      //     profile.email = email!;
                                      //   },
                                      // ),
                                      // SizedBox(height: 40),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30.0),
                                                ),
                                                primary: Color(0xFF0078E8),
                                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40)),
                                            child: Text("Continue", style: TextStyle(fontSize: 20)),
                                            onPressed: () async {
                                              if (formKey.currentState!.validate()) {
                                                formKey.currentState!.save();
                                                try {
                                                  UserCredential userCredential = await FirebaseAuth.instance
                                                      .createUserWithEmailAndPassword(
                                                          email: profile.email, password: profile.password);
                                                  // update user display name
                                                  userCredential.user?.updateDisplayName(profile.username);
                                                  // update user picture profile
                                                  String userProfileURL = await uploadFile(profile.email);
                                                  print(userProfileURL);
                                                  userCredential.user?.updatePhotoURL(userProfileURL);

                                                  formKey.currentState!.reset();
                                                  Fluttertoast.showToast(
                                                      msg: "????????????????????????????????????????????????????????????", gravity: ToastGravity.TOP);
                                                  Navigator.pushReplacement(context,
                                                      MaterialPageRoute(builder: (context) {
                                                    return HomeScreen();
                                                  }));
                                                } on FirebaseAuthException catch (e) {
                                                  // print(e.code);
                                                  //print(e.message);
                                                  Fluttertoast.showToast(
                                                      msg: e.message.toString(), gravity: ToastGravity.CENTER);
                                                }
                                              }
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
