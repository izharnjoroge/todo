import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon prefix;
  final TextInputType keyboardtype;
  final IconButton suffix;

  const TextFields({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefix,
    required this.keyboardtype,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardtype,
      controller: controller,
      obscureText: obscureText,
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? "Enter valid email"
          : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 12, 179, 18),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.green),
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
    );
  }
}
