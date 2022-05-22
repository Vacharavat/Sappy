import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sappyapp/model/profile.dart';
import 'package:sappyapp/screen/home.dart';
import 'package:sappyapp/screen/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                            height: 687,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  width: 350,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return LoginScreen();
                                                }));
                                              }),
                                        ],
                                      ),
                                      Text(
                                        "Sign up",
                                        style: TextStyle(
                                            fontSize: 56,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 40),
                                      Text("Username",
                                          style: TextStyle(fontSize: 20)),
                                      TextFormField(
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "กรุณาป้อนอีเมล")
                                        ]),
                                        keyboardType: TextInputType.text,
                                        onSaved: (String? username) {
                                          profile.username = username!;
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      Text("Email",
                                          style: TextStyle(fontSize: 20)),
                                      TextFormField(
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "กรุณาป้อนอีเมล"),
                                          EmailValidator(
                                              errorText:
                                                  "รูปแบบอีเมลไม่ถูกต้อง")
                                        ]),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onSaved: (String? email) {
                                          profile.email = email!;
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Password",
                                          style: TextStyle(fontSize: 20)),
                                      TextFormField(
                                        validator: RequiredValidator(
                                            errorText: "กรุณาป้อนรหัสผ่าน"),
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
                                      //       errorText: "กรุณาป้อนรหัสผ่าน"),
                                      //   obscureText: true,
                                      // ),
                                      SizedBox(height: 20),
                                      // Text("Date of Birth",
                                      //     style: TextStyle(fontSize: 20)),
                                      // TextFormField(
                                      //   validator: MultiValidator([
                                      //     RequiredValidator(
                                      //         errorText: "กรุณาป้อนอีเมล"),
                                      //     EmailValidator(
                                      //         errorText:
                                      //             "รูปแบบอีเมลไม่ถูกต้อง")
                                      //   ]),
                                      //   keyboardType:
                                      //       TextInputType.emailAddress,
                                      //   onSaved: (String? email) {
                                      //     profile.email = email!;
                                      //   },
                                      // ),
                                      SizedBox(height: 40),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                primary: Color(0xFF0078E8),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 40)),
                                            child: Text("Continue",
                                                style: TextStyle(fontSize: 20)),
                                            onPressed: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                formKey.currentState!.save();
                                                try {
                                                  await FirebaseAuth.instance
                                                      .createUserWithEmailAndPassword(
                                                          email: profile.email,
                                                          password:
                                                              profile.password)
                                                      .then((value) {
                                                    formKey.currentState!
                                                        .reset();
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "สร้างบัญชีผู้ใช้แล้ว",
                                                        gravity:
                                                            ToastGravity.TOP);
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return HomeScreen();
                                                    }));
                                                  });
                                                } on FirebaseAuthException catch (e) {
                                                  print(e.code);
                                                  //print(e.message);

                                                  Fluttertoast.showToast(
                                                      msg: e.message.toString(),
                                                      gravity:
                                                          ToastGravity.CENTER);
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
