import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  final String imagePath;
  const Tiles({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: 40,
    );
  }
}
