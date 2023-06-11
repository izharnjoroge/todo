import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasks/pages/register_page.dart';
import 'package:tasks/services/auth_service.dart';

import '../main.dart';
import '../utils/buttons.dart';
import '../utils/text_fields.dart';
import '../utils/text_fields2.dart';
import '../utils/tiles.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  bool _isObscured = true;
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future signUser() async {
    final form = formKey.currentState;
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (form!.validate()) {
      try {
        if (passwordController.text.isEmpty) {
          Navigator.pop(context);
          showErrorMessage("Password is required");
        } else {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
          showSuccessDialog("Success.");
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showErrorMessage(e.code);
      } on Exception catch (e) {
        Navigator.pop(context);
        showErrorMessage(e.toString());
      }
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        });
  }

  void showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Text(
            message,
            style: const TextStyle(color: Colors.green),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            //for validation from the TextFields class
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/login.jpg",
                      height: 300,
                    ),
                    const Text(
                      "Welcome",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFields(
                      controller: emailController,
                      hintText: "Enter your Email",
                      obscureText: false,
                      prefix: const Icon(Icons.mail),
                      keyboardtype: TextInputType.emailAddress,
                      suffix: IconButton(
                        padding: const EdgeInsets.only(right: 12),
                        icon: const Icon(Icons.person),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFields2(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: _isObscured,
                        prefix: const Icon(Icons.person_2_outlined),
                        keyboardtype: TextInputType.visiblePassword,
                        suffix: IconButton(
                          padding: const EdgeInsets.only(right: 12),
                          icon: _isObscured
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Buttons(
                      text: "Log In",
                      onTap: signUser,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => AuthService().signInWithGoogle(),
                          child: const Tiles(
                            imagePath: "assets/images/search.png",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Not registered?"),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Sign Up.",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
