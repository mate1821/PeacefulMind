import 'package:flutter/material.dart';
import '../widgets/logo.dart';
import '../widgets/titulo.dart';

enum EstadoAnimo { neutro, feliz, triste,regular }

class HomeScreen extends StatefulWidget { // la pantalla puede actualizarse segun eventos 
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> { // Se extiende de la pantalla home 
  final TextEditingController nombreCtrl = TextEditingController();
  final TextEditingController diaCtrl = TextEditingController();  // permiten editar 

  EstadoAnimo estado = EstadoAnimo.neutro;  // inicaliamos el estado 
  String resultado = "";

  List<Color> get coloresFondo {
    switch (estado) {
      case EstadoAnimo.feliz:
        return [const Color.fromARGB(255, 197, 194, 2), const Color.fromARGB(255, 186, 189, 12)];
      case EstadoAnimo.triste:
        return [const Color(0xFF1000E9), const Color(0xFF3A22A5)];
      case EstadoAnimo.regular:
        return [const Color.fromARGB(255, 133, 14, 212), const Color(0xFF3A22A5)];
      default:
        return [Colors.black, const Color(0xFF201F1F)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titulo(textColor: Colors.black),
        centerTitle: true,
      ),
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(20),  //  A todo los elementos
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: coloresFondo,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Titulo(textColor: Colors.white),
              Logo(altura: 175, ancho: 175),
              const SizedBox(height: 20),

              TextField(
                controller: nombreCtrl,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Tu nombre",
                ),
              ),

              const SizedBox(height: 20), // spacer en compose 

              TextField(
                controller: diaCtrl,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "¿Cómo estuvo tu día?",
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,  // alineacion en centro horizontal
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      minimumSize: const Size(155, 52),
                    ),
                    onPressed: procesar,
                    child: const Text("Evaluar día"),
                  ),
                  const SizedBox(width: 15), // cambia el width en el row 

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      minimumSize: const Size(155, 52),
                    ),
                    onPressed: limpiar,
                    child: const Text("Nueva entrada"),
                  ),
                ],
              ),

              const SizedBox(height: 20), 

              if (resultado.isNotEmpty)
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SelectableText(
                      resultado,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  // Funciones : Dart 
  void procesar() {
    final texto = diaCtrl.text.toLowerCase();

    List<String> videos_animo = [
      "https://youtube.com/shorts/t1-CnPz6Lv0?si=WWXBIuGLnhWsId7y",
      "https://youtu.be/W6H8OSrm734?si=R96C8_xU3FaxnmHr",
      "https://youtu.be/mtIW8b8qdCw?si=_C4sTBvo0TzMjDa3",
      "https://youtu.be/9kMJohOdRtY?si=nLOzMwuWXi1Qqxg6"
    ];

    String playlist =
        "https://open.spotify.com/playlist/6IKQrtMc4c00YzONcUt7QH?si=T_mDGwdfQBuvEZRv5fNYYQ&pi=cGEmJMDaQ9azA";

    setState(() {
      if (nombreCtrl.text.isEmpty || diaCtrl.text.isEmpty) {
        resultado = "Por favor completa todos los campos";
        estado = EstadoAnimo.neutro;
      } else if (texto.contains("mas o menos") ||
          texto.contains("regular") ||
          texto.contains("bien") && texto.contains("mal") ||
          texto.contains("masomenos") ||
          texto.contains("normal")) {
        resultado =
            "Hola,${nombreCtrl.text} los días neutros también son parte del camino. Mañana puede traer algo distinto.\n para que tu dia sea un poco mejor escucha una cancion de esta playlist:\n$playlist";
        estado = EstadoAnimo.regular;
      } else if (texto.contains("mal") ||
          texto.contains("triste") ||
          texto.contains("desanimado") ||
          texto.contains("terrible")) {
        videos_animo.shuffle();
        String link = videos_animo.first;
        resultado =
            "Hola ${nombreCtrl.text},Aunque hoy fue difícil, no define quién eres ni lo que viene después no estas sol@\n Consejo : Ve este video $link";
        estado = EstadoAnimo.triste;
      } else if (texto.contains("bien") || texto.contains("feliz")) {
        resultado =
            "Hola ${nombreCtrl.text}, Me alegra saber que tu día fue bueno, esos momentos valen oro, disfrútalos como consejo debrias  subir una historia o una nota ";
        estado = EstadoAnimo.feliz;
      } else {
        resultado = "Gracias por compartir tu día ";
        estado = EstadoAnimo.neutro;
      }
    });
  }

  void limpiar() {
    setState(() {
      diaCtrl.clear();
      resultado = "";
      estado = EstadoAnimo.neutro;
    });
  }
}
