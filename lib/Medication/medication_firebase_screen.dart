import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medication_manager/Login/user_controller.dart';
import 'package:medication_manager/Medication/medication_edit_widget.dart';
import 'package:medication_manager/Medication/medication_repository.dart';

import '../models.dart';

class MedicationFirebaseScreen extends StatefulWidget {
  const MedicationFirebaseScreen({super.key});

  @override
  _MedicationFirebaseScreenState createState() =>
      _MedicationFirebaseScreenState();
}

class _MedicationFirebaseScreenState extends State<MedicationFirebaseScreen> {
  var medicationsRepository = MedicationRepository();
  final userController = Get.find<UserController>();

  // Future<void> _createUser(String userId) async {
  //   FirebaseFirestore.instance.doc("users").set({'username': userId});
  // }
  Future<void> setUserMedication(String medicationId) async {
    var input = {
      'id': medicationId,
      'name': 'Ibuprofeno',
      'startTime': "2023-05-25T12:00:00Z",
      'repeatDelay': "2023-05-25T12:00:00Z",
      'color': "MaterialAccentColor(primary value: Color(0xffff5252))",
      'dosage': {"value": 400, "unit": "mg"},
      'value': 100,
      'unit': 'mg',
    };

    Medication med = Medication(
        name: "Aspirin",
        startTime: const TimeOfDay(hour: 12, minute: 00),
        repeatDelay: const TimeOfDay(hour: 4, minute: 00),
        color: "16711680",
        dosage: Dosage(value: 400, unit: "mg"));

    var medicationMap = med.toMap();

    // medicationsRepository.createMedication(userId, medicationId, medicationMap);
    medicationsRepository
        .fetchAllMedications(userController.getCurrentUserName());

    // medicationsRepository.createMedication(userId, medicationId, input);
    // medicationsRepository.updateMedication(userId, "1686684269733000", input);
    // medicationsRepository.deleteMedication(userId, "1686683447133000");
  }

  Color selectedColor = Colors.amberAccent;

  List<Color> colors = [
    Colors.pinkAccent,
    Colors.orangeAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.purpleAccent,
    Colors.yellowAccent,
    Colors.tealAccent,
    Colors.redAccent,
    Colors.cyanAccent,
    Colors.amberAccent,
    Colors.lightGreenAccent,
    Colors.deepPurpleAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const MedicationEditScreen();
            return Dialog(
              child: Container(
                padding: const EdgeInsets.all(32.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: colors.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 32.0,
                    crossAxisSpacing: 32.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    Color color = colors[index];
                    bool isSelected = selectedColor == color;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = color;
                          // _setCounter(color.toString());
                          // _createUser(userId);
                          //medicationId = idGenerator();
                          // setUserMedication(userId, medicationId);
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                                  color: colors[index],
                                  width: 8.0,
                                )
                              : null,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(
                                    color: Colors.white,
                                    width: 4.0,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      child: const Text('Open Color Chooser'),
    );
  }
}

// void main() {
//   runApp(
// }
