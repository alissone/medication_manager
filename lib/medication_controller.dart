import 'package:get/get.dart';
import 'package:medication_manager/models.dart'; // Import your Todo model

class MyController extends GetxController {
  var title = 'Medicamentos'.obs;

  void updateTitle(Todo todo) {
    title.value = "TESTE";
    title.value = todo.title;
    update();
  }
}
