import 'package:demo3/Pages/Home.dart';
import 'package:demo3/Pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // User is logged in, redirect to HomePage
            return HomePage();
          } else {
            // User is not logged in, show LoginPage
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
