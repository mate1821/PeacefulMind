import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double altura;
  final double ancho;

  const Logo({
    super.key,
    required this.altura,
    required this.ancho,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Image.asset(
        'assets/images/peacefulMind.png',
        width: ancho,
        height: altura,
      ),
    );
  }
}
