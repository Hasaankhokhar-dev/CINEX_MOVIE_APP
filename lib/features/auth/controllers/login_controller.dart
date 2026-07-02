import 'package:get/get.dart';

class LoginController extends GetxController {
  final isPasswordVisible = false.obs;
  final isRememberMe = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }
}