import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _Sres = "";
  bool _punto = false;
  double _res = 0;
  String _operador = "";
  double _operando1 = 0;

  List<List<dynamic>> _presionBoton = [
    [7, 8, 9, "/"],
    [4, 5, 6, "*"],
    [1, 2, 3, "-"],
    [".", 0, "=", "+"],
  ];

  Widget construirTeclado(BuildContext context) {
    List<Widget> columnas = [];

    for (int i = 0; i < 4; i++) {
      List<Widget> botones = [];

      for (int j = 0; j < 4; j++) {
        botones.add(
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            color: Theme.of(context).colorScheme.inversePrimary,
            onPressed: () {
              _cambiaNumero(_presionBoton[j][i]);
            },
            child: Text(
              "${_presionBoton[j][i]}",
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
          ),
        );
      }
      columnas.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: botones,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: columnas,
    );
  }

  void _cambiaNumero(dynamic n) {
    if (n is int) {
      _Sres += n.toString();
      setState(() {
        _res = double.tryParse(_Sres) ?? 0.0;
      });
    }

    if (n is String) {
      if (n == ".") {
        if (!_punto) {
          _punto = true;
          _Sres += ".";
          setState(() {
            _res = double.tryParse(_Sres) ?? 0.0;
          });
        }
      }

      if (n == "+" || n == "-" || n == "*" || n == "/") {
        setState(() {
          _operando1 = _res;
          _operador = n;
          _Sres = "";
        });
      }

      if (n == "=") {
        setState(() {
          if (_operador == "+") {
            _res = _operando1 + _res;
          } else if (_operador == "-") {
            _res = _operando1 - _res;
          } else if (_operador == "*") {
            _res = _operando1 * _res;
          } else if (_operador == "/") {
            if (_res == 0) {
              _Sres = "Error"; // Previene división por cero
              return;
            }
            _res = _operando1 / _res;
          }
          _Sres = _res.toString();
          _operador = ""; // Resetea el operador después del cálculo
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Calculadora"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.orangeAccent,
              width: 320,
              padding: const EdgeInsets.all(10),
              child: Text(
                _Sres,
                style: const TextStyle(fontSize: 32),
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(height: 7),
            construirTeclado(context),
          ],
        ),
      ),
    );
  }
}
