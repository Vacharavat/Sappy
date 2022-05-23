import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sappyapp/manager/auth.dart';
import 'package:sappyapp/model/profile.dart';
import 'package:sappyapp/screen/profile_signup.dart';
import 'package:sappyapp/screen/register.dart';
import 'package:sappyapp/screen/welcome.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
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
            User? user = AuthManager().getCurrentUser();
            if (user != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              });
            }
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/image/Logo1.png"),
                          TextFormField(
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: Colors.white, width: 2.0)),
                                hintText: 'name@example.com',
                                prefixIcon: Icon(Icons.person)),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
                              EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? email) {
                              profile.email = email!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.white, width: 2.0)),
                              hintText: 'password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            validator: RequiredValidator(errorText: "กรุณาป้อนรหัสผ่าน"),
                            onSaved: (String? password) {
                              profile.password = password!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    primary: Color(0xFF0078E8),
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                                child: Text("login", style: TextStyle(fontSize: 20)),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(email: profile.email, password: profile.password)
                                          .then((value) {
                                        formKey.currentState!.reset();
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                          return HomeScreen();
                                        }));
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      Fluttertoast.showToast(msg: e.message.toString(), gravity: ToastGravity.CENTER);
                                    }
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an Account yet ? ",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                      return RegisterScreen();
                                    }));
                                  }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Profile for Sign Up ? ",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                  child: Text(
                                    "Tap Here",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                      return ProfileSign();
                                    }));
                                  }),
                            ],
                          )
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
