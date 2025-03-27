import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  CalculadoraState createState() => CalculadoraState();
}

class CalculadoraState extends State<Calculadora> {
  String _input = ''; // Entrada de datos del usuario
  String _output = ''; // Resultado de la operación
  bool _esNuevoCalculo = true; // Control de nuevo cálculo

  // Función para agregar valores al input
  void _agregarInput(String valor) {
    setState(() {
      if (_esNuevoCalculo && !_esOperador(valor)) {
        _input = valor; // Si es nuevo cálculo, reemplaza el valor
        _esNuevoCalculo = false; // Desactiva la opción de nuevo cálculo
      } else {
        _input += valor;
      }
    });
  }

  // Función para evaluar la operación
  void _evaluarResultado() {
    setState(() {
      if (_input.isEmpty || _esOperador(_input[_input.length - 1])) {
        return; // Evita evaluar si el último carácter es un operador
      }

      try {
        // Reemplazamos 'x' por '*' y '%' por '/100'
        String expresion = _input.replaceAll('x', '*').replaceAll('%', '/100');
        ShuntingYardParser p =
            ShuntingYardParser(); // Uso de ShuntingYardParser
        Expression exp = p.parse(expresion);
        ContextModel cm = ContextModel();
        double evalResult = exp.evaluate(EvaluationType.REAL, cm);

        // Limitar el resultado a dos decimales, y evitar los decimales si es un número entero
        _output =
            evalResult == evalResult.toInt()
                ? evalResult.toInt().toString()
                : evalResult.toStringAsFixed(2);

        // El resultado se coloca en el input para continuar operando
        _input = _output;
        _esNuevoCalculo =
            true; // Permite que el próximo número sea como nuevo cálculo
      } catch (e) {
        _output = 'Error';
      }
    });
  }

  // Función para borrar un carácter
  void _borrarCaracter() {
    setState(() {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
      }
    });
  }

  // Función para borrar todo
  void _borrarTodo() {
    setState(() {
      _input = '';
      _output = '';
      _esNuevoCalculo = true;
    });
  }

  // Verifica si el carácter es un operador
  bool _esOperador(String valor) {
    return ['+', '-', 'x', '/', '%'].contains(valor);
  }

  // Verifica si ya se ha colocado un punto decimal en el número actual
  bool _esDecimal() {
    return _input.contains('.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculadora', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 75, 42, 133),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.pushNamed(context, '/screen');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Calculadora',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // Recubrimiento de la pantalla de cálculo
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Entrada de la calculadora
                    Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _input,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Resultado
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _output,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Botones
            _filaBotones(['1', '2', '3', 'x']),
            _filaBotones(['4', '5', '6', '+']),
            _filaBotones(['7', '8', '9', '-']),
            _filaBotones([',', '0', '=', '%']),
            const SizedBox(height: 20),
            // Botones de borrar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_crearBotonBorrar('DEL'), _crearBotonBorrar('C')],
            ),
            const SizedBox(height: 40),
            // Texto de Programación III y Hecho por...
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.deepPurple, width: 3),
                ),
              ),
              child: Text(
                'Programación III\nHecho por Gabriely Sonatore y Carmen Crespi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Genera una fila de botones
  Widget _filaBotones(List<String> valores) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: valores.map((valor) => _crearBoton(valor)).toList(),
    );
  }

  // Botón estándar
  Widget _crearBoton(String texto) {
    return ElevatedButton(
      onPressed: () {
        if (texto == '=') {
          _evaluarResultado();
        } else if (texto == ',' && !_esDecimal()) {
          _agregarInput('.');
        } else {
          _agregarInput(texto);
        }
      },
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(25),
        backgroundColor: Color(0xFF34214d), // Color morado #34214d
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 32, color: Colors.white),
      ),
    );
  }

  // Botón para borrar
  Widget _crearBotonBorrar(String texto) {
    return ElevatedButton(
      onPressed: () {
        if (texto == 'C') {
          _borrarTodo();
        } else {
          _borrarCaracter();
        }
      },
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(25),
        backgroundColor: const Color.fromARGB(
          255,
          170,
          47,
          38,
        ), // Color rojo para borrar
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 32, color: Colors.white),
      ),
    );
  }
}
