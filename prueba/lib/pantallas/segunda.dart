import 'package:flutter/material.dart';
import 'package:prueba/pantallas/principal.dart';

class Otra extends StatefulWidget{
  const Otra({super.key, required this.titulo });

  final String titulo;

  @override
  State<Otra> createState() => _NavegadorState();
}

class _NavegadorState extends State<Otra>{
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
              const Text(
                'Texto de segunda pagina',
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