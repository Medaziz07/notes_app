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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("add");
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googleSignin = GoogleSignIn();
                googleSignin.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('login', (route) => false);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 150),
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    "images/folder.png",
                    height: 100,
                  ),
                  Text("Company")
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    "images/folder.png",
                    height: 100,
                  ),
                  Text("Home")
                ],
              ),
            ),
          ),
        ],
      ),
      //FirebaseAuth.instance.currentUser!.emailVerified
      //     ? const Text("Welcome")
      //     : MaterialButton(
      //         child: const Text("please verified your email"),
      //         onPressed: () {
      //           FirebaseAuth.instance.currentUser!.sendEmailVerification();
      //         },
      //       ),

      //
    );
  }
}
