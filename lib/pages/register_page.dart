import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/buttons.dart';
import '../utils/text_fields.dart';

import '../utils/text_fields2.dart';
import '../utils/tiles.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'nav.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool _isObscured = true;
  final formKey = GlobalKey<FormState>();

  Future signupUser() async {
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
        if (confirmpasswordController.text.trim() !=
            passwordController.text.trim()) {
          Navigator.pop(context);
          showErrorMessage("Passwords do not match");
        } else {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                // Navigate to the NavigationPage after successful registration
                navigatorKey.currentState!.popUntil((route) => route.isFirst);
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/signup.png",
                        height: 300,
                      ),
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFields(
                        controller: emailController,
                        hintText: "Enter your Email",
                        obscureText: false,
                        keyboardtype: TextInputType.emailAddress,
                        prefix: const Icon(Icons.email),
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
                          keyboardtype: TextInputType.visiblePassword,
                          prefix: const Icon(Icons.person_2_outlined),
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
                        height: 15,
                      ),
                      TextFields2(
                          controller: confirmpasswordController,
                          hintText: "Confirm your Password",
                          obscureText: _isObscured,
                          keyboardtype: TextInputType.visiblePassword,
                          prefix: const Icon(Icons.person_2_outlined),
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
                        height: 15,
                      ),
                      Buttons(
                        text: "Sign Up",
                        onTap: signupUser,
                      ),
                      const SizedBox(
                        height: 20,
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
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Have an Account?"),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Log In.",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
