import 'package:flutter/material.dart';
import 'package:medication_manager/colors.dart';
import 'package:medication_manager/medication_card_widget.dart';
import 'package:medication_manager/models.dart';
import 'package:medication_manager/time_tools.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.appColor,
      ),
      home: const MyHomePage(title: 'Medicamentos'),
    );
  }
}

class MedicationForm extends StatefulWidget {
  @override
  _MedicationFormState createState() => _MedicationFormState();
}

class _MedicationFormState extends State<MedicationForm> {
  String nome = "";
  String frequencia = "";
  String cor = "";
  bool iniciarAutomaticamente = true;

  List<String> frequenciaOptions = [
    "diariamente",
    "semanalmente",
    "intervalo personalizado"
  ];

  Map<int, String> corOptions = {
    0: "vermelho",
    1: "verde",
    2: "azul",
    3: "laranja",
  };

  TimeOfDay selectedTime24Hour = const TimeOfDay(hour: 0, minute: 0);


  @override
  Widget build(BuildContext context) {
    String intervalString = "Escolher";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: "Nome"),
            onChanged: (value) {
              setState(() {
                nome = value;
              });
            },
          ),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(labelText: "Cor"),
            value: cor != null
                ? corOptions.keys.firstWhere(
                    (key) => corOptions[key] == cor,
                    orElse: () => corOptions.keys.first,
                  )
                : null,
            items: corOptions.keys.map((index) {
              return DropdownMenuItem<int>(
                value: index,
                child: Text(corOptions[index] ?? ""),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                cor = corOptions[value] ?? "";
              });
            },
          ),
          const SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Intervalo"),
              TextButton(
                onPressed: () {
                  // Perform the desired action when "Cancelar" is pressed
                  showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 0, minute: 0),
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      );
                    },
                  ).then((TimeOfDay? result){
                    setState(() {
                      selectedTime24Hour = result!;
                      intervalString = "${selectedTime24Hour.hour}:${selectedTime24Hour.minute}";
                    });
                    print(intervalString);
                  });;
                },
                child: Text('$intervalString'),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          CheckboxListTile(
            title: const Text("Ativo"),
            value: iniciarAutomaticamente,
            onChanged: (value) {
              setState(() {
                iniciarAutomaticamente = value ?? false;
              });
            },
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: () {
                },
                child: const Text("Adicionar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Medicamento'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // TODO: MedicationForm should take a Medication as parameter. To create a new one, give an empty medication. You should have an ID field as well.
          MedicationForm(),
        ],
      ),
    );
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) => widget._buildPopupDialog(context),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var cardIcon = Icons.medication_rounded;


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView(
        shrinkWrap: true,
        // Ensures the ListView takes only the necessary space
        children: <Widget>[
          MedicationCard(
              medication: Medication(
                name: 'Paracetamol',
                startTime: const TimeOfDay(hour: 12, minute: 0),
                repeatDelay: const TimeOfDay(hour: 2, minute: 30),
                color: Colors.blue,
                dosage: Dosage(750, 'mg'),
              )),
          MedicationCard(
            medication: Medication(
            name: 'Ibuprofeno',
            startTime: const TimeOfDay(hour: 8, minute: 0),
            repeatDelay: const TimeOfDay(hour: 0, minute: 30),
            color: Colors.green,
            dosage: Dosage(400, 'mg'),
          )),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MedicationCard extends StatelessWidget {
  final Medication medication;

  MedicationCard({required this.medication});

  @override
  Widget build(BuildContext context) {
    return ListCard(
      cardColor: medication.color,
      cardIcon: Icons.medication_rounded,
      medicationTitle: medication.name,
      medicationDose: medication.dosage,
      medicationFrequency: "a cada ${formatTimeOfDay(medication.startTime)}",
      medicationNextDose: medication.repeatDelay,
    );
  }
}
