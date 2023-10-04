import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Note App "),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed("login");
                  GoogleSignIn googleSignin = GoogleSignIn();
                  googleSignin.disconnect();
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: FirebaseAuth.instance.currentUser!.emailVerified
            ? Text("Welcome")
            : MaterialButton(
                child: Text("please verified your email"),
                onPressed: () {
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                },
              ));
  }
}
