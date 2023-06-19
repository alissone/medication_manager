import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medication_manager/Home/welcome_page.dart';
import 'package:medication_manager/Login/user_controller.dart';
import 'package:medication_manager/Medication/list_card_widget.dart';
import 'package:medication_manager/Medication/medication_controller.dart';
import 'package:medication_manager/Medication/medication_repository.dart';
import 'package:medication_manager/Utils/extensions.dart';
import 'package:medication_manager/Utils/time_tools.dart';
import 'package:medication_manager/firebase_options.dart';
import 'package:medication_manager/medication_form_widget.dart';
import 'package:medication_manager/models.dart';

// Uncomment this to use the local emulator
// Future<void> setupEmulators() async {
// FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // setupEmulators();

  Get.put(MedicamentosController());
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      GetMaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!),
      home: Scaffold(
        body: Center(
          child: WelcomePage(),
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}

class MedicationsListScreen extends StatefulWidget {
  MedicationsListScreen({Key? key, required this.title}) : super(key: key);
  String title;
  final String apiUrl =
      'https://mocki.io/v1/97a93986-a029-409c-bddd-613e59de2084';
  final medicamentosController = Get.find<MedicamentosController>();
  final medicationsRepository = MedicationRepository();
  final userController = Get.find<UserController>();

  void fetchData() async {
    var result = <Medication>[];

    medicationsRepository.fetchAllMedications(userController.getCurrentUserName()).then(
          (list) => {
            list.forEach((Map<String, dynamic> medication) {
              result.add(Medication.fromMap(medication));
            }),
            updateText(result),
          },
        );

    medicamentosController.stopLoading();

    // final response = await http.get(Uri.parse(apiUrl));
    // // updateText("Loading...");
    // medicamentosController.startLoading();
    //
    // if (response.statusCode == 200) {
    //   final jsonMap = json.decode(response.body);
    //   final todo = Medications.fromJson(jsonMap);
    //   updateText(todo.toList());
    //   medicamentosController.stopLoading();
    // } else {
    //   print("Failure...");
    //   medicamentosController.stopLoading();
    // }
  }

  void updateText(List<Medication>? medicationsList) {
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
  State<MedicationsListScreen> createState() => _MedicationsListScreenState();
}

class _MedicationsListScreenState extends State<MedicationsListScreen> {
  late MedicamentosController controller;


  @override
  void initState() {
    super.initState();
    controller = Get.find<MedicamentosController>(); // Retrieve the registered instance of MyController
    widget.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicamentosController>(
      init: MedicamentosController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text("Meus Medicamentos"),
        ),
        body: Center(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.medications.length,
            itemBuilder: (context, index) {
              return

              controller.isLoading ? Container(color: Colors.pink, width: 200, height: 200,) :
                Wrap(
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
          onPressed: () {
            Get.to(MedicationFormScreen());
          },
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
    TimeOfDay emptyTime = const TimeOfDay(hour: 0, minute: 0);
    final Color iconColor = HexColor.fromHex(medication.color ?? "000000");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: ListCard(
          cardColor: iconColor,
          cardIcon: Icons.medication_rounded,
          medicationTitle: medication.name ?? "Desconhecido",
          medicationDose: medication.dosage ?? Dosage(),
          medicationFrequency: "a cada ${formatTimeOfDay(medication.startTime ?? emptyTime)}",
          medicationNextDose: medication.repeatDelay ?? emptyTime,
        ),
      ),
    );
  }
}
