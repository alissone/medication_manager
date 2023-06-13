import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medication_manager/medication_repository.dart';

class ColorChooser extends StatefulWidget {
  @override
  _ColorChooserState createState() => _ColorChooserState();
}

class _ColorChooserState extends State<ColorChooser> {
  static const docPath = 'counters/1';

  static const userId = "testuser";
  var medicationId = "1";
  var medicationsRepository = MedicationRepository();

  Future<void> _setCounter(String counter) async {
    FirebaseFirestore.instance.doc(docPath).set({'value': counter});
  }

  // Future<void> _createUser(String userId) async {
  //   FirebaseFirestore.instance.doc("users").set({'username': userId});
  // }
  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  Future<void> setUserMedication(String userId, String medicationId) async {
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                padding: EdgeInsets.all(32.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: colors.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          medicationId = idGenerator();
                          setUserMedication(userId, medicationId);
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
      child: Text('Open Color Chooser'),
    );
  }
}

// void main() {
//   runApp(
// }
