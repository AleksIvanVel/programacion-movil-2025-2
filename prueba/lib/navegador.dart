import 'package:flutter/material.dart';
import 'package:prueba/pantallas/calculadora.dart';
import 'package:prueba/pantallas/principal.dart';
import 'package:prueba/pantallas/segunda.dart';

class Navegador extends StatefulWidget{
  const Navegador({super.key});

  @override
  State<Navegador> createState() => _NavegadorState();
}

class _NavegadorState extends State<Navegador>{

  int _p = 0;
  List<Widget> _pantallas  = [];
  Widget _cuerpo =Text(
    "Soy el cuerpo",
    style: TextStyle(
      fontSize: 40,
    ),
  );


  @override
  void initState(){
    super.initState();
    _pantallas.add(const MyHomePage(titulo: "Pantalla 1"));
    _pantallas.add(const Otra(titulo: "Pantalla 2"));
    _pantallas.add(const Calculadora());

    _cuerpo = _pantallas[_p];
  }

  void _cambiaPantalla(int v){
    setState(() {
      if (v == 0 && _p > 0) {
        _p--; // Retrocede si no está en la primera pantalla
      } else if (v == 1 && _p < _pantallas.length - 1) {
        _p++; // Avanza si no está en la última pantalla
      }
      _cuerpo = _pantallas[_p];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cuerpo,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value){
            _cambiaPantalla(value);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_back),
              label: 'Atras'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_forward),
                label: 'Adelante'
            ),
          ]
      ),
    );
  }
}