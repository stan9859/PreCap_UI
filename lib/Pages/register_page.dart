import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/login_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  // sign user in method
  void signUserup(BuildContext context) async {
    // Show loading circle
    showDialog(context: context, builder: (context) {
      print('circle shown');
      return  const Center(
        child: CircularProgressIndicator(color:Color(0xff043611),),
      );
    },
    );

    if( passwordController.text != confirmPasswordController.text){
      Navigator.pop(context);
      showErrorMessage("Passwords do not match!");
      return;
    }

    // try sign up
    try {
     // make sure password and confirm password is same!
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                  size: 50,
                ),
                const SizedBox(height: 50),
                Text(
                  'Let\'s create an account for you!',
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
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                // sign in button
                sign_up_button(context),

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
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
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

  Container sign_up_button(BuildContext context) {
    return Container(
      height: 60,
      width: 370,
      child: ElevatedButton(
        onPressed: () {
          // Add your sign-in logic here
          signUserup(context);
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
            "Sign Up",
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