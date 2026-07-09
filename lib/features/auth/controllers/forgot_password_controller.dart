import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../services/auth_service.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final emailError = RxnString();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    emailController.addListener(() {
      if (emailError.value != null) emailError.value = null;
    });
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return 'Enter Email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) return 'Enter Valid Email (example@gmail.com)';
    return null;
  }

  Future<void> sendResetEmail() async {
    final email = emailController.text.trim();

    // Validation
    emailError.value = _validateEmail(email);
    if (emailError.value != null) return;

    try {
      isLoading.value = true;

      await AuthService.forgotPassword(email);
      Get.snackbar(
        'Success',
        'Password reset email sent successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.toNamed(AppRoutes.login);

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}