// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteapps/components/textformfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil('homepage', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(70)),
                      child: Image.asset(
                        "images/login.png",
                        width: 40,
                        height: 70,
                        //fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Login To Continue Using The App",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextForm(
                    hinttext: "Enter Your Email",
                    mycontroller: email,
                    validator: ((val) {
                      if (val == "") {
                        return 'can"t be empty';
                      }
                    }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Password",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextForm(
                      hinttext: "Enter Your password",
                      mycontroller: password,
                      validator: ((val) {
                        if (val.toString().isEmpty) {
                          return 'can"t be empty';
                        }
                      })),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        if (email.toString().isEmpty) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'Dialog Title',
                            desc: 'Email can"t be null',
                          ).show();
                        }

                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email.text);
                      } on Exception catch (e) {
                        print("$e");
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forget  Password ?',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () async {
                if (formstate.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                    if (credential.user!.emailVerified) {
                      Navigator.of(context).pushReplacementNamed("homepage");
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'Dialog Title',
                        desc: 'verification',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      ).show();
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'Dialog Title',
                        desc: 'Dialog description here.............',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      ).show();
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                } else {
                  print("not valide");
                }
              },
              color: Colors.orange,
              textColor: Colors.black,
              child: Text("Login"),
              height: 45,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              "OR Login",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      try {
                        signInWithGoogle();
                      } on Exception catch (e) {
                        print("google singin problem");
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "images/google.png",
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (() => print("facebook taped")),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/facebook.png",
                          width: 65,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('signup');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "New account ?",
                          style: TextStyle(fontSize: 25),
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
    );
  }
}
