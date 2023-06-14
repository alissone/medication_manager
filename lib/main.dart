import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:medication_manager/color_picker_widget.dart';
import 'package:medication_manager/colors_list.dart';
import 'package:medication_manager/extensions.dart';
import 'package:medication_manager/medication_card_widget.dart';
import 'package:medication_manager/medication_controller.dart';
import 'package:medication_manager/medication_form_widget.dart';
import 'package:medication_manager/models.dart';
import 'package:medication_manager/time_tools.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:medication_manager/firebase_options.dart';
import 'package:medication_manager/welcome_page.dart';

Future<void> setupEmulators() async {
  // Uncomment this to use the local emulator
  // FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupEmulators();

  Get.put(MedicamentosController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
          builder: (context, child) =>
              MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
          home: Scaffold(
          body: Center(
            child: LoginPage(),
          ),
        ),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
    );
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.appColor,
      ),
      // home: MyHomePage(title: 'Medicamentos'),
      home: Text("Hello world!"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  String title;
  final String apiUrl = 'https://mocki.io/v1/97a93986-a029-409c-bddd-613e59de2084';
  final medicamentosController = Get.find<MedicamentosController>();

  void fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));
    // updateText("Loading...");
    medicamentosController.startLoading();

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      final todo = Medications.fromJson(jsonMap);
      updateText(todo.toList());
      medicamentosController.stopLoading();
    } else {
      print("Failure...");
      medicamentosController.stopLoading();
    }
  }

  void updateText(List<Medication>? medicationsList) {
    print("Updating to $medicationsList");
    medicamentosController.updateTitle(medicationsList ?? <Medication>[]);
    medicamentosController.updateMedications(medicationsList ?? <Medication>[]);
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
  late MedicamentosController controller;


  @override
  void initState() {
    super.initState();
    controller = Get.find<MedicamentosController>(); // Retrieve the registered instance of MyController
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

    return GetBuilder<MedicamentosController>(
      init: MedicamentosController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("Meus Medicamentos"),
        ),
        body: Center(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.medications.length,
            itemBuilder: (context, index) {
              return

              controller.isLoading ? Container(color: Colors.pink, width: 200, height: 200,) :
                Column(
                children: [
                  MedicationCard(medication: controller.medications[index]),
                  Obx(() =>
                      Text(controller.title.value)
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: widget.fetchData,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final Medication medication;

  const MedicationCard({Key? key, required this.medication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimeOfDay emptyTime = TimeOfDay(hour: 0, minute: 0);
    final Color iconColor = HexColor.fromHex(medication.color ?? "000000");

    return ListCard(
      cardColor: iconColor,
      cardIcon: Icons.medication_rounded,
      medicationTitle: medication.name ?? "Desconhecido",
      medicationDose: medication.dosage ?? Dosage(),
      medicationFrequency: "a cada ${formatTimeOfDay(medication.startTime ?? emptyTime)}",
      medicationNextDose: medication.repeatDelay ?? emptyTime,
    );
  }
}
