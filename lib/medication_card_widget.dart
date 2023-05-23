import 'package:flutter/material.dart';
import 'package:medication_manager/colors.dart';
import 'package:medication_manager/main.dart';
import 'package:medication_manager/text_styles.dart';
import 'package:medication_manager/time_tools.dart';

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
