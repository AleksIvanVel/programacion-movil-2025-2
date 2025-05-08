import 'package:flutter/material.dart';
import 'package:prueba/widgets/tarjetas.dart';

class Personalizada extends StatefulWidget{
  const Personalizada({super.key, required this.titulo,});

  final String titulo;

  @override
  State<Personalizada> createState() => _PersonalizadaState();
}

class _PersonalizadaState extends State<Personalizada>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.error ,
        title: Text(widget.titulo),
      ),
        body: Center(
          child: Tarjetas(nombre: ["Joaquin"],
            descripcion: ["Hola soy joaquin"],
            rutas: ["assets/images/cocodrilo.jpg"],
            width: 500,
            height: 100,
            color: Colors.pinkAccent,
          )
        )
    );
  }
}