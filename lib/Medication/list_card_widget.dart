import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medication_manager/Login/user_controller.dart';
import 'package:medication_manager/Medication/medication_repository.dart';
import 'package:medication_manager/Utils/colors_list.dart';
import 'package:medication_manager/Utils/text_styles.dart';
import 'package:medication_manager/Utils/time_tools.dart';
import 'package:medication_manager/models.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    Key? key,
    required this.medication,
    required this.cardIcon,
    required this.cardColor,
    required this.medicationTitle,
    required this.medicationDose,
    required this.medicationFrequency,
    required this.medicationNextDose,
  }) : super(key: key);

  final Medication medication;
  final IconData cardIcon;
  final Color cardColor;
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
          // Get.to(() => MedicationEditScreen(), arguments: [
          //   {"medication": medication.toJson()},
          // ]);
          showAlertDialog(context, medication.id);
        },
        child: SizedBox(
          width: 300,
          height: 95,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 4),
                  child: Icon(
                    cardIcon,
                    size: 60,
                    color: cardColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicationTitle,
                      style: AppTextStyles.heading2,
                    ),
                    Text(
                      "${medicationDose.value}${medicationDose.unit}, $medicationFrequency",
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

showAlertDialog(BuildContext context, int? medicationId) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Excluir"),
    onPressed: () {
      var medicationsRepository = MedicationRepository();
      final userController = Get.find<UserController>();
      medicationsRepository.deleteMedication(
          userController.username.value, medicationId.toString());
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Excluir"),
    content: Text("Tem certeza que deseja excluir essa medicação?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
