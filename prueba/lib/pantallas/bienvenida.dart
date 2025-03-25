import 'package:flutter/material.dart';
import 'package:prueba/pantallas/principal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Otra extends StatefulWidget{
  const Otra({super.key, required this.titulo });

  final String titulo;

  @override
  State<Otra> createState() => _NavegadorState();
}

class _NavegadorState extends State<Otra>{
  String _Nombre = "";


  void _leerDatos() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String?  aux = prefs.getString("Nombre");
    if(aux != null){
      setState(() {
        _Nombre = aux;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _leerDatos();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.error ,
        title: Text(widget.titulo),
      ),
        body: Center(
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: <Widget>[
               Text(
                'Bienvenid@',
                style: TextStyle(
                  fontSize: 40
                ),
              ),
               Text(
                _Nombre,
                style: TextStyle(
                    fontSize: 40
                ),
              ),

            ]
          )
        )
    );
  }
}