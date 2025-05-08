import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class Localizacion extends StatefulWidget{
  const Localizacion({super.key, required this.titulo });

  final String titulo;

  @override
  State<Localizacion> createState() => _LocalizacionState();
}

class _LocalizacionState extends State<Localizacion>{

  String _latitud = "";
  String _longitud = "";

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'La localizacion esta permanentemente deshabilitada');
    }
    return await Geolocator.getCurrentPosition();
  }

  void _obtenerCoordenadas() async{
    Position pos =  await _determinePosition();
        setState(() {
          _latitud = pos.latitude.toString();
          _longitud = pos.longitude.toString();
        });
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
                "Localizacion",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              MaterialButton(onPressed: (){
                _obtenerCoordenadas();
              },
                color: Colors.redAccent,
              child: Text("obtener localizacion"),
              ),
              SizedBox(
                width: 500,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Latitud: $_latitud",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ]
                  ),
                  SizedBox(
                    width: 500,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Longitud: $_longitud",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ]
                  )
                ],

              )
            ],
          )
        )
    );
  }
}