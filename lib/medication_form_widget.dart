import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
                  ).then((TimeOfDay? result) {
                    setState(() {
                      selectedTime24Hour = result!;
                      intervalString =
                          "${selectedTime24Hour.hour}:${selectedTime24Hour.minute}";
                    });
                    print(intervalString);
                  });
                  ;
                },
                child: Text('$intervalString'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Cor"),
              TextButton(
                onPressed: () {
                  print("Pressed");
                  Color mycolor = Colors.white;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Escolha uma cor para o icone'),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: mycolor, //default color
                              onColorChanged: (Color color) {
                                //on color picked
                                setState(() {
                                  mycolor = color;
                                  print(color);
                                });
                              },
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('DONE'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); //dismiss the color picker
                              },
                            ),
                          ],
                        );
                      });
                },
                child: const Text("Escolher"),
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
