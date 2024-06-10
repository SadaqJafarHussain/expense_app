import 'package:expense_app/log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> handleSignInEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return "done";
    } on FirebaseAuthException catch (e) {
      if (e.code =='user-not-found') {
        print('No user found for that email.');
        return "no email";
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return "wrong pass";
      }
      return "error";
    }
  }

  Future<String> handleSignUp(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return "done";
    } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
        return "mail exist";
      }
    } catch (e) {
      print(e);
    }
    return 'error';

  }
  void signOut() {
    FirebaseAuth.instance.signOut();
    User? user = FirebaseAuth.instance.currentUser;
    //print('$user');
    runApp(
        new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new SignIn(),
        )

    );
  }
}