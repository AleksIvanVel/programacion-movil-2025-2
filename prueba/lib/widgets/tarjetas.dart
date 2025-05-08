
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tarjetas extends StatefulWidget{
  Tarjetas({super.key,
            required this.nombre,
            required this.descripcion,
            required this.rutas,
            required this.height,
            required this.width,
            required this.color,
  });

  final List<String> nombre;
  final List<String> descripcion;
  final List<String> rutas;
  final double height;
  final double width;
  final Color color;


  State<Tarjetas> createState() => _TarjetasState();
}

class _TarjetasState extends State<Tarjetas>{
  List<Widget> _tarjetas = [];

  void _crearTarjetas(){
    if(widget.nombre.length == 0){
      print("No fueron enviados los datos");
    }else{
      if(widget.nombre.length == widget.descripcion.length && widget.nombre.length == widget.rutas.length){
        for(int i = 0; i < widget.nombre.length; i++){
          _tarjetas.add(
              Column(
                children: [
                  SizedBox(
                      height: widget.height,
                      width: widget.width,
                      child: MaterialButton(
                        onPressed: (){
                          print("hola soy ${widget.nombre[i]}");
                        },
                        child:Card(
                          color: widget.color,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: widget.height-30,
                                    child:  Image.asset(widget.rutas[i])
                                ),
                                SizedBox(
                                  width: widget.width-200,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(widget.nombre[i]),
                                        Text(widget.descripcion[i])
                                      ],
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      )
                  )
                ]
              )
          );
        }
      }
    }
  }

  @override
  void initState(){
    super.initState();
    _crearTarjetas();
  }

  @override
  Widget build(BuildContext context){
    return ListView(
      children: _tarjetas,
    );
  }
}