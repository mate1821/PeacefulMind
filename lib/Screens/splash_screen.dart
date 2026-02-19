import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../widgets/logo.dart';
import '../widgets/titulo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () { // Estado inicial y duracion del splash  Promesa (Proximamente llegara )
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(), // Pasa al HomeScreen 
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Cuadro que compone un panatalla basica 
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color.fromARGB(255, 34, 33, 33),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Titulo(textColor: Colors.white),
            SizedBox(height: 20),
            Logo(ancho: 300, altura: 300),
          ],
        ),
      ),
    );
  }
}
