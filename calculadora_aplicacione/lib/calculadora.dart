import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _entrada = '';
  String _resultado = '';

  void _agregarValor(String valor) {
    setState(() {
      _entrada += valor;
    });
  }

  void _borrarTodo() {
    setState(() {
      _entrada = '';
      _resultado = '';
    });
  }

  void _borrarUno() {
    setState(() {
      if (_entrada.isNotEmpty) {
        _entrada = _entrada.substring(0, _entrada.length - 1);
      }
    });
  }

  void _calcular() {
    try {
      _resultado = _evaluarExpresion(_entrada);
    } catch (e) {
      _resultado = 'Error';
    }
    setState(() {});
  }

  String _evaluarExpresion(String expresion) {
    try {
      double resultado = double.parse(expresion);
      return resultado.toString();
    } catch (e) {
      return 'Error';
    }
  }

  Widget _crearBoton(String texto, VoidCallback funcion) {
    return ElevatedButton(
      onPressed: funcion,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        textStyle: const TextStyle(fontSize: 20),
      ),
      child: Text(texto),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/info');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(_entrada, style: const TextStyle(fontSize: 30)),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                _resultado,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            padding: const EdgeInsets.all(10),
            children: [
              _crearBoton('7', () => _agregarValor('7')),
              _crearBoton('8', () => _agregarValor('8')),
              _crearBoton('9', () => _agregarValor('9')),
              _crearBoton('/', () => _agregarValor('/')),
              _crearBoton('4', () => _agregarValor('4')),
              _crearBoton('5', () => _agregarValor('5')),
              _crearBoton('6', () => _agregarValor('6')),
              _crearBoton('*', () => _agregarValor('*')),
              _crearBoton('1', () => _agregarValor('1')),
              _crearBoton('2', () => _agregarValor('2')),
              _crearBoton('3', () => _agregarValor('3')),
              _crearBoton('-', () => _agregarValor('-')),
              _crearBoton('0', () => _agregarValor('0')),
              _crearBoton('.', () => _agregarValor('.')),
              _crearBoton('=', _calcular),
              _crearBoton('+', () => _agregarValor('+')),
              _crearBoton('C', _borrarTodo),
              _crearBoton('<', _borrarUno),
              _crearBoton('%', () => _agregarValor('%')),
            ],
          ),
        ],
      ),
    );
  }
}
