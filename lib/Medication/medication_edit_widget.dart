import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:get/get.dart';
import 'package:medication_manager/Login/user_controller.dart';
import 'package:medication_manager/Medication/medication_repository.dart';
import 'package:medication_manager/Utils/medication_names_list.dart';
import 'package:medication_manager/models.dart';

class MedicationEditScreen extends StatelessWidget {
  const MedicationEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Medication Manager';
    return FormPage(title: title);
  }
}

Medication getMedFromArgs(Map<String, dynamic>? getArguments) {
  Medication emptyMed = Medication();
  Dosage emptyDosage = Dosage();
  emptyMed.dosage = emptyDosage;

  if (getArguments == null) {
    emptyMed.id = MedicationRepository.generateId();
    return emptyMed;
  }

  if (getArguments.containsKey('medication')) {
    return getArguments['medication'];
  }

  emptyMed.id = MedicationRepository.generateId();
  return emptyMed;
}

class FormPage extends StatelessWidget {
  FormPage({super.key, required this.title});

  final formKey = GlobalKey<FormState>();
  final String title;
  var currentMedication = getMedFromArgs(Get.arguments);

  var medicationsRepository = MedicationRepository();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 4.0,
        shadowColor: theme.shadowColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FastForm(
                formKey: formKey,
                inputDecorationTheme: InputDecorationTheme(
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[700]!, width: 1),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[500]!, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                children: _buildForm(context, currentMedication),
                onChanged: (value) {
                  updateMedicationFromFormFields(value);
                  print('Form changed: ${value.toString()}');
                },
              ),
              ElevatedButton(
                child: const Text('Reset'),
                onPressed: () => formKey.currentState?.reset(),
              ),
              ElevatedButton(
                child: const Text('Salvar'),
                onPressed: () {
                  var medicationMap = currentMedication.toMap();
                  medicationsRepository.createMedication(
                      userController.getCurrentUserName(),
                      currentMedication.id ?? 0,
                      medicationMap);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildForm(BuildContext context, Medication currentMedication) {
    final bool isEditing = (currentMedication.name != null);

    return [
      FastFormSection(
        padding: const EdgeInsets.all(16.0),
        header: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            isEditing ? 'Editar Receita' : 'Adicionar uma nova receita',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        children: [
          FastAutocomplete<String>(
            name: 'autocomplete',
            labelText: 'Medicamento',
            options: MedicationDatabase.medicamentos,
            onSelected: (selected) {
              currentMedication.updateName(selected);
            },
          ),
          FastDateRangePicker(
            name: 'date_range_picker',
            labelText: 'Período',
            firstDate: DateTime(2023),
            lastDate: DateTime(2040),
            helperText: 'Pressione o ícone para abrir o calendário',
          ),
          FastTimePicker(
            name: 'time_picker',
            labelText: 'Horário inicial',
            initialEntryMode: TimePickerEntryMode.inputOnly,
            initialValue: TimeOfDay.fromDateTime(DateTime.now()),
          ),
          const FastTimePicker(
            name: 'time_picker_end',
            labelText: 'Intervalo entre doses',
            initialEntryMode: TimePickerEntryMode.inputOnly,
            initialValue: TimeOfDay(hour: 0, minute: 0),
          ),
          const FastDropdown<String>(
            name: 'dropdown',
            labelText: 'Unidade',
            items: ['mg', 'mL', 'g', 'comprimido'],
            initialValue: 'mg',
          ),
          FastTextField(
            name: 'text_field',
            labelText: 'Quantidade',
            placeholder: '400',
            keyboardType: TextInputType.phone,
            maxLength: 7,
            prefix: const Icon(Icons.numbers),
            buildCounter: inputCounterWidgetBuilder,
            inputFormatters: const [],
            validator: Validators.compose([
              Validators.required((value) => 'Requerido'),
            ]),
          ),
          FastSlider(
            name: 'slider',
            labelText: 'Urgência',
            helperText:
                'O sistema irá priorizar medicamentos com maior urgência',
            min: 0,
            max: 10,
            prefixBuilder: (field) {
              final enabled = field.widget.enabled;
              return IconButton(
                icon: const Icon(Icons.circle_outlined),
                onPressed:
                    enabled ? () => field.didChange(field.widget.min) : null,
              );
            },
            suffixBuilder: (field) {
              final enabled = field.widget.enabled;
              return IconButton(
                icon: const Icon(Icons.circle_rounded),
                onPressed:
                    enabled ? () => field.didChange(field.widget.max) : null,
              );
            },
            validator: (value) => value! > 9 ? 'Prioridade Maxima' : null,
          ),
        ],
      ),
    ];
  }

  String getNameFromAutocomplete(String search) {
    print("search string: $search");

    final name = MedicationDatabase.medicamentos.firstWhere(
      (element) => element.startsWith(search),
      orElse: () => "",
    );
    print("medication name: $name");
    return name;
  }

  void updateMedicationFromFormFields(
      UnmodifiableMapView<String, dynamic> value) {
    // currentMedication .updateName(getNameFromAutocomplete(value['autocomplete']));
    currentMedication.updateStartTime(value['time_picker']);
    currentMedication.updateInterval(value['time_picker_end']);
    currentMedication.updateUnit(value['dropdown']);
    currentMedication.updateWeight(value['text_field']);

    print("Current medication: $currentMedication");
  }
}

// import 'package:flutter/material.dart';
//
// class MedicationEditScreen extends StatefulWidget {
//   @override
//   _MedicationEditScreenState createState() => _MedicationEditScreenState();
// }
//
// class _MedicationEditScreenState extends State<MedicationEditScreen> {
//   late TextEditingController _nameController;
//   late TextEditingController _startTimeController;
//   late TextEditingController _repeatDelayController;
//   late TextEditingController _colorController;
//   late TextEditingController _dosageValueController;
//   late TextEditingController _dosageUnitController;
//   late TextEditingController _valueController;
//   late TextEditingController _unitController;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//     _startTimeController = TextEditingController();
//     _repeatDelayController = TextEditingController();
//     _colorController = TextEditingController();
//     _dosageValueController = TextEditingController();
//     _dosageUnitController = TextEditingController();
//     _valueController = TextEditingController();
//     _unitController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _startTimeController.dispose();
//     _repeatDelayController.dispose();
//     _colorController.dispose();
//     _dosageValueController.dispose();
//     _dosageUnitController.dispose();
//     _valueController.dispose();
//     _unitController.dispose();
//     super.dispose();
//   }
//
//   void _printFieldsAsMap() {
//     var input = {
//       'id': "teste de ID",
//       'name': _nameController.text,
//       'startTime': _startTimeController.text,
//       'repeatDelay': _repeatDelayController.text,
//       'color': _colorController.text,
//       'dosage': {
//         'value': int.parse(_dosageValueController.text),
//         'unit': _dosageUnitController.text,
//       },
//       'value': int.parse(_valueController.text),
//       'unit': _unitController.text,
//     };
//
//     print(input);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Medication'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextFormField(
//               controller: _startTimeController,
//               decoration: InputDecoration(labelText: 'Start Time'),
//             ),
//             TextFormField(
//               controller: _repeatDelayController,
//               decoration: InputDecoration(labelText: 'Repeat Delay'),
//             ),
//             TextFormField(
//               controller: _colorController,
//               decoration: InputDecoration(labelText: 'Color'),
//             ),
//             TextFormField(
//               controller: _dosageValueController,
//               decoration: InputDecoration(labelText: 'Dosage Value'),
//               keyboardType: TextInputType.number,
//             ),
//             TextFormField(
//               controller: _dosageUnitController,
//               decoration: InputDecoration(labelText: 'Dosage Unit'),
//             ),
//             TextFormField(
//               controller: _valueController,
//               decoration: InputDecoration(labelText: 'Value'),
//               keyboardType: TextInputType.number,
//             ),
//             TextFormField(
//               controller: _unitController,
//               decoration: InputDecoration(labelText: 'Unit'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _printFieldsAsMap,
//               child: Text('Print Fields as Dart Map'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
