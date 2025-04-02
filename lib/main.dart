import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:domicilios_uno/screens/common/splashscreen.dart'; // Nueva ruta correcta

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase antes de ejecutar la app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de debug
      title: 'Al Ins App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(), // Pantalla de inicio
    );
  }
}
