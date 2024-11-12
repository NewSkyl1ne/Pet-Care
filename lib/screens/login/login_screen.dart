import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/components/text_fields.dart';

import '../../Auth/authentication.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signInGoogle() {
    Authentication().signInGoogle();
  }

  void signIn() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // validate();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void validate() {
    if (emailController.text == " ") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Row(
                children: const [
                  Icon(Icons.error),
                  SizedBox(width: 6),
                  Text(
                    "Please enter your email",
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (passwordController.text == " ") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                child: Row(
                  children: const [
                    Icon(Icons.error),
                    SizedBox(width: 6),
                    Text(
                      "Please enter your password",
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Row(
                children: const [
                  Icon(Icons.error),
                  SizedBox(width: 6),
                  Text(
                    "Please enter your login details",
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Row(
              children: [
                const Icon(Icons.error),
                const SizedBox(width: 6),
                Text(
                  message,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),

              //logo
              const Image(
                image: AssetImage('assets/images/login.png'),
                width: 120,
                height: 120,
              ),

              const SizedBox(height: 25),

              // sub - text
              Text(
                "Welcome back, take care of your pets",
                style: TextStyle(color: Colors.blue[600], fontSize: 18),
              ),

              const SizedBox(height: 20),

              //text-fields username and password
              MyTextField(
                  controller: emailController,
                  hintText: 'Enter email',
                  obscureText: false,
                  icon: const Icon(Icons.person_2_outlined)),
              const SizedBox(height: 10),
              MyTextField(
                  controller: passwordController,
                  hintText: 'Enter password',
                  obscureText: true,
                  icon: const Icon(Icons.password_outlined)),

              const SizedBox(height: 10),

              // forget password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 81, 76, 76),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // signin button
              TextButton(
                onPressed: () {
                  signIn();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //Or Continue with (google + other options)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                            color: Color.fromARGB(255, 143, 141, 135)),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  signInGoogle();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 198, 221, 237),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        image: AssetImage('assets/images/google.png'),
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Log In with Google',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 5),

              // not sign in , register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up Now',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
