import 'package:flutter/material.dart';

class InformacionScreen extends StatelessWidget {
  const InformacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Información")),
      body: Center(
        child: Text(
          "Información del desarrollador.",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
