import 'package:flutter/material.dart';
import 'calculadora.dart';
import 'screen.dart';

Map<String, WidgetBuilder> rutas = {
  '/': (context) => const Calculadora(),
  '/info': (context) => const Screen(),
};
