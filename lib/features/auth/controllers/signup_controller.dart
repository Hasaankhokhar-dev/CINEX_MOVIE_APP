import 'package:get/get.dart';

class SignupController extends GetxController {
  final isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
