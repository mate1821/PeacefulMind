import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
  final Color textColor;

  const Titulo({
    super.key,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "PeacefulMind",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontFamily: "Righteous",
        color: textColor,
      ),
    );
  }
}
