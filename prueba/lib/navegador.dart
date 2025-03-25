import 'package:flutter/material.dart';
import 'package:prueba/pantallas/calculadora.dart';
import 'package:prueba/pantallas/ingreso.dart';
import 'package:prueba/pantallas/principal.dart';
import 'package:prueba/pantallas/bienvenida.dart';

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

  void _cambiaPantalla(int v){
    _p = v;
    setState(() {
      _cuerpo = _pantallas[_p];
    });
  }


  @override
  void initState(){
    super.initState();
    _pantallas.add(const MyHomePage(titulo: "Pantalla 1"));
    _pantallas.add(const Otra(titulo: "Bienvenid@"));
    _pantallas.add(const Calculadora());
    _pantallas.add(Ingreso(titulo: "Ingresar", bienvenido: _cambiaPantalla,));

    _cuerpo = _pantallas[_p];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cuerpo,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value){
            _cambiaPantalla(value);
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: _p,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
              label: 'Principal'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.android),
                label: 'Bienvenid@'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.calculate),
                label: 'Calculadora'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout_outlined),
                label: 'Ingresar'
            ),
          ]
      ),
    );
  }
}