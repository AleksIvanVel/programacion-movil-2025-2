import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget{
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}


class _CalculadoraState extends State<Calculadora>{

  String _display = "";
  String _operacion = "";
  bool _isdouble = false;
  double? _ope1 = null;
  double? _ope2 = null;
  double _res = 0;

  void _presionaNumero(String number){
    setState(() {
      _display += number;
    });
  }

  void _presionaOperacion (String operacion){
    switch (operacion){
      case "/":
        _isdouble = false;
        _operacion = "/";

        if(_ope1 == null){
          _res = double.tryParse(_display)!;
          _ope1 = _res;

          //limpia display
          setState(() {
            _display="";
          });
        }else{
          _res = double.tryParse(_display)!;
          _ope2 = _res;
          _res = (_ope1! / _ope2!);
          setState(() {
            _display=_res.toString();
          });
        }
        break;
    }
  }

  void _presionaSimbolo(String simbolo){
    if(simbolo == "."){
      if(_isdouble == false){
        _isdouble = true;
        _display += ".";
        setState(() {
          _display = _display;
        });
      }
      setState(() {
        _display = _display;
      });
    }
    if(simbolo == "=") {

      // aplicar logica para realizar operacion con solo dos operandos
      if(_res == null){
        setState(() {
          _display = _display;
        });
      }else{
        setState(() {
          _display = _res.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Calculadora"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.orangeAccent,
                    width: 320,
                    child: Text(
                      _display,
                      style: TextStyle(
                        fontSize: 32
                      ),
                      textAlign:  TextAlign.end,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              child: Text(
                                "7",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaNumero("7");
                              }
                          ),
                          MaterialButton(
                              child: Text(
                                "4",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaNumero("4");
                              }
                          ),
                          MaterialButton(
                              child: Text(
                                "1",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaNumero("1");
                              }
                          ),
                          MaterialButton(
                              child: Text(
                                ".",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaSimbolo(".");
                              }
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              child: Text(
                                "8",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaNumero("8");
                              }
                          ),
                          MaterialButton(
                              child: Text(
                                "5",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaNumero("5");
                              }
                          ),
                          MaterialButton(
                              child: Text(
                                "2",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaNumero("2");
                              }
                          ),
                          MaterialButton(
                              child: Text(
                                "0",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaNumero("0");
                              }
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              child: Text(
                                "9",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaNumero("9");
                              }
                          ),
                          MaterialButton(
                              child: Text(
                                "6",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaNumero("6");
                              }
                          ),
                          MaterialButton(
                              child: Text(
                                "3",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaNumero("3");
                              }
                          ),
                          MaterialButton(
                              child: Text(
                                "=",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaSimbolo("=");
                              }
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              child: Text(
                                "/",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaOperacion("/");
                              }
                          ),
                          MaterialButton(
                              child: Text(
                                "*",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaOperacion("*");
                              }
                          ),
                          MaterialButton(
                              child: Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaOperacion("-");
                              }
                          ),
                          MaterialButton(
                              child: Text(
                                "+",
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              onPressed:(){
                                _presionaOperacion("+");
                              }
                          ),
                        ],
                      )
                    ],
                  )
                ]
            )
        )
    );
  }
}