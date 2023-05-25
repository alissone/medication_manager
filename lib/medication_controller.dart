import 'package:get/get.dart';
import 'package:medication_manager/models.dart'; // Import your Todo model

class MedicamentosController extends GetxController {
  var title = 'Medicamentos'.obs;
  var medications = <Medication>[];
  var isLoading = false;

  void startLoading() {
    isLoading = true;
  }

  void stopLoading() {
    isLoading = false;
  }

  void updateTitle(List<Medication> medicationsList) {
    title.value = "";
    update();
  }

  void updateMedications(List<Medication> medicationsList) {
    medications = medicationsList;
    update();
  }
}
