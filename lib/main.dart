import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:medication_manager/colors.dart';
import 'package:medication_manager/medication_card_widget.dart';
import 'package:medication_manager/medication_controller.dart';
import 'package:medication_manager/medication_form_widget.dart';
import 'package:medication_manager/models.dart';
import 'package:medication_manager/time_tools.dart';

void main() {
  Get.put(MyController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.appColor,
      ),
      home: MyHomePage(title: 'Medicamentos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  String title;
  final String apiUrl = 'https://jsonplaceholder.typicode.com/todos/1';
  final controller = Get.find<MyController>();

  void fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      final todo = Todo.fromJson(jsonMap);
      updateText(todo.title);
    } else {
      print("Failure...");
    }
  }

  void updateText(String text) {
    print("Updating to $text");
    controller.updateTitle(Todo.fromJson({'title': text}));
  }

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
  late MyController controller;


  @override
  void initState() {
    super.initState();
    controller = Get.find<MyController>(); // Retrieve the registered instance of MyController
    print("Controller:");
    print(controller.toString());
    print("Controller.");
  }

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
    var title = widget.title;

    return GetBuilder<MyController>(
      init: MyController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("teste"),
        ),
        body: Center(
            child: ListView(
          shrinkWrap: true,
          // Ensures the ListView takes only the necessary space
          children: <Widget>[
            Obx(() => Text(controller.title.value)),
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
          // onPressed: _incrementCounter,
          onPressed: widget.fetchData,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
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
