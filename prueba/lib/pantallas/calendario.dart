import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class Calendario extends StatefulWidget {
  const Calendario({super.key, required this.titulo});

  final String titulo;

  @override
  State<Calendario> createState() => _CalendarioState();  //estado del widget
}

class _CalendarioState extends State<Calendario> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> _nombreEvento = [];
  List<Map<String, dynamic>> _eventos = [];
  bool _datosCargados = false;
  TextEditingController _textController = TextEditingController(); // Controlador de nombre de evento
  TextEditingController _fInicioController = TextEditingController(); // Controlador de fecha de inicio de evento
  TextEditingController _fFinalController = TextEditingController(); // Controlador de fecha final de evento
  TextEditingController _colorController = TextEditingController(); // Controlador de fecha final de evento

  DateTime? _fechaInicial;
  DateTime? _fechaFinal;

  Color _colorSeleccionado = Colors.blue;

  Future<void> _leerBase() async {
    _nombreEvento = [];
    _eventos = [];
    try {
      QuerySnapshot eventos = await db.collection("eventos").get();
      if (eventos.docs.isNotEmpty) {
        for (DocumentSnapshot evento in eventos.docs) {
          setState(() {
            _nombreEvento.add(evento.id);
            _eventos.add(evento.data() as Map<String, dynamic>);
          });
        }
        print("Nombre del Evento: $_nombreEvento");
        print("Evento: $_eventos");
      } else {
        print("No existe el documento");
      }
    } catch (e) {
      print("Error al leer la base de datos: $e");
    } finally {
      setState(() {
        _datosCargados = true;
      });
    }
  }


  void _mostrarPopup(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          title: "Mensaje Importante",
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: "Nombre del evento",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height:20),
              TextField(
                controller: _fInicioController,
                decoration: const InputDecoration(
                  labelText: "Fecha inicial",
                  border: OutlineInputBorder(),
                ),
                onTap: () => _seleccionarFecha(context, true),
              ),
              SizedBox(height:20),
              TextField(
                controller: _fFinalController,
                decoration: const InputDecoration(
                  labelText: "Fecha Final",
                  border: OutlineInputBorder(),
                ),
                onTap: () => _seleccionarFecha(context, false),
              ),
              SizedBox(height:20),
              TextField(
                controller: _colorController,
                decoration: const InputDecoration(
                  labelText: "Color",
                  border: OutlineInputBorder(),
                ),
                onTap: () => _seleccionarColor(context),
              ),
              SizedBox(height: 35),
              ElevatedButton(
                child:
                  Text("Agendar"),
                onPressed: (){
                  _agendar(_textController.text);
                },
              ),
            ],
          ),

          onClose: () {
            Navigator.of(context).pop(); // Cierra el popup
          },
        );
      },
    );
  }

  void _agendar(String nombreEvento){
    //Aqui vamos a agendar los eventos o citas
    print("Nombre del evento: $nombreEvento");
    _textController.text = "";
  }

  void _seleccionarFecha(BuildContext context, bool inicial) async {
    DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Fecha inicial
      firstDate: DateTime(2000),   // Fecha mínima
      lastDate: DateTime(2100),    // Fecha máxima
    );

    final TimeOfDay? horaSeleccionada = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (inicial){ //fecha incial
        _fechaInicial = fechaSeleccionada!.add(Duration(hours: horaSeleccionada!.hour, minutes: horaSeleccionada.minute));
        _fInicioController.text = _fechaInicial.toString();
    }
    else{// fecha final
      _fechaFinal = fechaSeleccionada!.add(Duration(hours: horaSeleccionada!.hour, minutes: horaSeleccionada.minute));
      _fFinalController.text = _fechaFinal.toString();
    }
  }

  void _seleccionarColor(BuildContext context) async {
    Color tempColor = _colorSeleccionado;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona un color'),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (Color color) {
                tempColor = color;
              },
              enableAlpha: false,
              displayThumbColor: true,
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Aceptar'),
              onPressed: () {
                setState(() {
                  _colorSeleccionado = tempColor;
                  print(_colorSeleccionado);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      body: _datosCargados ? SfCalendar(
        dataSource: MeetingDataSource(_getDataSource(_nombreEvento, _eventos)),
        view: CalendarView.month,
        monthViewSettings: MonthViewSettings(
          showAgenda: true,
        ),
      ): const Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreenAccent,
        onPressed: (){
          //Aqui vamos a agendar los eventos o citas
          _mostrarPopup(context);
        },
        tooltip: 'Agendar evento',
        child: const Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Meeting> _getDataSource(List<String> nombreEvento,List<Map<String, dynamic>> eventos ) {
    final List<Meeting> meetings = <Meeting>[];

    for(int i = 0; i < nombreEvento.length; i++){
      DateTime fechaInicial = (eventos[i]["fechaInicial"] as Timestamp).toDate();
      DateTime fechaFinal = (eventos[i]["fechaFinal"] as Timestamp).toDate();
      Color color = Color(eventos[i]["color"]);

      meetings.add(
          Meeting(nombreEvento[i], fechaInicial, fechaFinal, color, eventos[i]["todoDia"])
      );
    }
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}


class CustomPopup extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback onClose;

  const CustomPopup({
    super.key,
    required this.title,
    required this.content,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Aquí se coloca cualquier widget pasado como argumento
            content,
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onClose,
              child: const Text('Cerrar'),
            ),
          ],
        ),
      ),
    );
  }
}
