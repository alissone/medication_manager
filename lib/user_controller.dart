import 'package:get/get.dart';

class UserController extends GetxController {
  var username = 'guest'.obs;
  var isLoading = false;

  void startLoading() {
    isLoading = true;
  }

  void stopLoading() {
    isLoading = false;
  }

  String getCurrentUserName() {
    return username.value;
  }

  void updateUsername(String newUsername) {
    username.value = newUsername;
    update();
    print(username.value);
  }
}
