import 'package:demo3/Pages/Home.dart';
import 'package:demo3/Pages/auth_page.dart';
import 'package:demo3/Pages/login_page.dart';
import 'package:demo3/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => CartModel(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home:  AuthPage()
        ),

    );
  }
}

