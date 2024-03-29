import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/login_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn(BuildContext context) async {
    // Show loading circle
    showDialog(context: context, builder: (context) {
      print('circle shown');
      return  const Center(
      child: CircularProgressIndicator(color:Color(0xff043611),),
    );
      },
    );

    // try sign in
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // pop the loading circle if login is successful
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        print('ERROR HAS OCCURRED: $e');
        Navigator.pop(context);
        // wrong email
        // if (e.code == 'user-not-found') {
        //   //show error to user
        //   wrongEmailMessage(context);
        //   print("wrong email!");
        // }
        // // wrong password
        // else if (e.code == 'wrong-password') {
        //  // show error to user
        //   wrongPasswordMessage(context);
        //   print("wrong password!");
        // }
        // handle invalid credential
         showErrorMessage(e.code);
      }

  }
  // void wrongEmailMessage(BuildContext context){
  //   showDialog(
  //     context: context,
  //     builder:(context) {
  //       return const AlertDialog(
  //           title: Text('Incorrect Email!'),
  //       );
  //       },
  //   );
  // }

  void showErrorMessage(String message){
    showDialog(
      context: context,
      builder:(context) {
        return  AlertDialog(
        backgroundColor: Color(0xFF86D19B),
          title: Center(
        child: Text( message,
        style: const TextStyle(color: Color(0xff043611),),
  ),
        ),
        );
      },
    );
  }
  void wrongEmailFormat(BuildContext context){
    showDialog(
      context: context,
      builder:(context) {
        return const AlertDialog(
          title: Text('Wrong e-mail or password!'),
        );
      },
    );
  }
  void emailNotRegistered(BuildContext context){
    showDialog(
      context: context,
      builder:(context) {
        return const AlertDialog(
          title: Text('Wrong E-mail format!'),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF86D19B),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 50),
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                // sign in button
                sign_in_button(context),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),
                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    google_button(),
                    SizedBox(width: 25),
                    apple_button(),
                  ],
                ),
                const SizedBox(height: 50),
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container apple_button() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        'assets/icons/apple.png',
        height: 40,
      ),
    );
  }

  Container google_button() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        'assets/icons/google.png',
        height: 40,
      ),
    );
  }

  Container sign_in_button(BuildContext context) {
    return Container(
      height: 60,
      width: 370,
      child: ElevatedButton(
        onPressed: () {
          // Add your sign-in logic here
          signUserIn(context);
          print('sign in button pressed!');
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          primary: Color(0xff11b039).withOpacity(0.8),
        ),
        child: Center(
          child: Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}