import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/buttons.dart';
import '../utils/text_fields.dart';
import 'login_page.dart';

// forgot password

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future forgotPassword() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
        showSuccessDialog("Reset link has been sent to your email.");
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
            backgroundColor: Colors.amber,
            title: Text(
              message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        });
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
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
                dispose();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
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
      body: Form(
        key: formKey,
        child: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/forgot.jpg"),
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
                height: 20,
              ),
              Buttons(
                text: "Send Request",
                onTap: forgotPassword,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Alread have account?"),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Log in.",
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
        )),
      ),
    );
  }
}
