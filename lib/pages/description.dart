import 'package:flutter/material.dart';

// more details on the fetched task.

Widget description(context, title, completed) {
  return Scaffold(
    appBar: AppBar(
      // title: Text(title.toString()),
      title: const Text("Description"),
      titleTextStyle:
          const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      centerTitle: true,
      toolbarHeight: 60.2,
      toolbarOpacity: 0.8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      ),
      elevation: 0.00,
      backgroundColor: const Color.fromARGB(255, 82, 219, 89),
    ),
    body: Padding(
      padding: const EdgeInsets.only(top: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Completed:"),
              Text(completed.toString()),
            ],
          ),
        ],
      ),
    ),
  );
}
