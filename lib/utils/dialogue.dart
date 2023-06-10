import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Dialogue extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  Dialogue({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 82, 219, 89),
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: "Add a task",
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: onSave,
                  child: const Text("Save"),
                ),
                const SizedBox(
                  width: 70,
                ),
                ElevatedButton(
                  onPressed: onCancel,
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
