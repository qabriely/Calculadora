import 'package:flutter/material.dart';
import 'calculadora.dart'; // Asegúrate de tener esta ruta correcta para importar la clase Calculadora
import 'screen.dart'; // Asegúrate de tener esta ruta correcta para importar la clase Screen

// Definimos las rutas
final Map<String, WidgetBuilder> rutas = {
  '/': (context) => const Calculadora(), // Ruta inicial a la Calculadora
  '/screen':
      (context) =>
          const InformacionScreen(), // Ruta a la pantalla de información
};
