// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:noteapps/components/textformfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

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
                    "Sign Up",
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Username",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  CustomTextForm(
                      hinttext: "Enter Your Username",
                      mycontroller: username,
                      validator: ((val) {
                        if (val == "") {
                          return 'can"t be empty';
                        }
                      })),
                  Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  CustomTextForm(
                      hinttext: "Enter Your Email",
                      mycontroller: email,
                      validator: ((val) {
                        if (val == "") {
                          return 'can"t be empty';
                        }
                      })),
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
                        if (val == "") {
                          return 'can"t be empty';
                        }
                      })),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forget  Password ?',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      )
                    ],
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
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    Navigator.of(context).pushReplacementNamed("login");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Dialog Title',
                        desc: 'Dialog description here.............',
                      ).show();
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Dialog Title',
                        desc: 'Email exists',
                      ).show();
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                } else {
                  print("not valide");
                }
              },
              color: Colors.orange,
              textColor: Colors.black,
              child: Text("SignUp"),
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
                    onTap: (() => print("google taped")),
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
                      Navigator.of(context).pushReplacementNamed("homepage");
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Have an account ?",
                          style: TextStyle(fontSize: 20),
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
