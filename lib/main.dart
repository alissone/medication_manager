import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static MaterialColor appColor = Colors.purple;
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  );

  static const TextStyle smallLight = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Colors.black26,
  );
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  int hours = timeOfDay.hour;
  int minutes = timeOfDay.minute;

  if (hours == 0 && minutes == 0) {
    return '0min';
  }

  String formattedTime = '';
  if (hours > 0) {
    formattedTime += '${hours}h';
  }
  if (minutes > 0) {
    formattedTime += '${minutes}min';
  }

  return formattedTime;
}

class Dosage {
  double quantity;
  String unit;

  Dosage(this.quantity, this.unit);
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
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

  TimeOfDay selectedTime24Hour = TimeOfDay(hour: 0, minute: 0);


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
              Text("Intervalo"),
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
                  // Perform the desired action when "Cancelar" is pressed
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Perform the desired action when "OK" is pressed
                  // You can access the form values here (e.g., nome, frequencia, cor, iniciarAutomaticamente)
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
          // Text("Hello"),
          MyForm(),
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
            cardIcon: cardIcon,
            medicationTitle: "Paracetamol",
            medicationDose: Dosage(750, 'mg'),
            medicationFrequency: 'a cada 8 horas',
            medicationNextDose: TimeOfDay(hour:0, minute: 26),
          ),
          MedicationCard(
            cardIcon: cardIcon,
            medicationTitle: "Ibuprofeno",
            medicationDose: Dosage(400, 'mg'),
            medicationFrequency: 'a cada 12 horas',
            medicationNextDose: TimeOfDay(hour: 1, minute: 5),
          ),
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
  const MedicationCard({
    Key? key,
    required this.cardIcon,
    required this.medicationTitle,
    required this.medicationDose,
    required this.medicationFrequency,
    required this.medicationNextDose,
  }) : super(key: key);

  final IconData cardIcon;
  final String medicationTitle;
  final String medicationFrequency;
  final Dosage medicationDose;
  final TimeOfDay medicationNextDose;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: AppColors.appColor.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: SizedBox(
          width: 300,
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Icon(
                    cardIcon,
                    size: 60,
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicationTitle,
                      style: AppTextStyles.heading2,
                    ),
                    Text("${medicationDose.quantity}${medicationDose.unit}, $medicationFrequency",
                      style: AppTextStyles.body,
                    ),
                    Container(
                      height: 6,
                    ),
                    Text(
                      "Proximo em ${formatTimeOfDay(medicationNextDose)}",
                      style: AppTextStyles.smallLight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
