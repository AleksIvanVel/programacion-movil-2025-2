import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.titulo});

  final String titulo;

  @override
  State<MyHomePage> createState() => _MyHomePageState();  //estado del widget
}

class _MyHomePageState extends State<MyHomePage> {
  double  _counter = 0;
  String _imagen = "";
  final FirebaseFirestore db = FirebaseFirestore.instance;


  void _leerBase() async {
    try {
      DocumentSnapshot doc = await db.collection("numeros").doc("ElContador").get();

      if (doc.exists) {
        // cast seguro del valor, asegurando que sea numérico
        final dynamic valor = doc.get("contador");
          setState(() {
            _counter = valor.toDouble();
          });
        
      } else {
        print("Documento 'ElContador' no encontrado en la colección 'numeros'");
      }
    } catch (e) {
      print("❌ Error al leer la base: $e");
    }
  }

  void _escribirBase() async {
    Map<String, dynamic> datos = {
      "contador": _counter
    };
    try {
      await db.collection("numeros").doc("ElContador").set(datos);
      print("Se ha escrito $_counter en la base de datos");
    } catch (e) {
      print("Error al escribir la base de datos: $e");
    }
  }


  void _incrementCounter() {
    setState(() {
      _counter+=5;
    });
    _escribirBase();
  }

  void _decrementCounter() {
    setState(() { //actualiza el estado del widget y lo reconstruye
      _counter-=5;
    });
    _escribirBase();
  }

  @override
  initState(){
    super.initState();
    _leerBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //widget principal
      appBar: AppBar( //widget
        backgroundColor: Colors.green,
        title: Text(widget.titulo), //puede tener otro titulo (String)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Numero de clicks en el boton: ',
            ),
            Image.network(
                width:_counter,
                "data:image/jpeg;base64,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"),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            FloatingActionButton(
              onPressed: _decrementCounter,
              child: const Icon(Icons.circle),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreenAccent,
        onPressed: _incrementCounter,
        tooltip: 'Restar',
        child: const Icon(Icons.circle_outlined),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}