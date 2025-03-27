import 'package:flutter/material.dart';
import 'ruta.dart'; // Importamos las rutas

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Aplicación',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/', // Ruta inicial
      routes: rutas, // rutas definidas en ruta.dart
    );
  }
}
