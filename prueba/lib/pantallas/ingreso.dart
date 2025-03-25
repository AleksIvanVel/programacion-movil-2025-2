import 'package:flutter/material.dart';
import 'package:prueba/pantallas/principal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ingreso extends StatefulWidget{
  const Ingreso({super.key, required this.titulo, required this.bienvenido });

  final String titulo;
  final Function bienvenido;

  @override
  State<Ingreso> createState() => _NavegadorState();
}

class _NavegadorState extends State<Ingreso>{

  TextEditingController _controller = TextEditingController();

  Future<SharedPreferences> _obtenerPreferencias() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref;
  }

  void _escribirDatos() async {
    SharedPreferences prefs = await _obtenerPreferencias() ;
    prefs.setString("Nombre", _controller.text);
    _controller.text = "";
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
                "Ingresar",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Ingresa tu Nombre',
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.redAccent,
                onPressed: (){
                  _escribirDatos();
                  widget.bienvenido(1);
                },
                child: Text("Enviar"),
              )
            ],


          )
        )
    );
  }
}