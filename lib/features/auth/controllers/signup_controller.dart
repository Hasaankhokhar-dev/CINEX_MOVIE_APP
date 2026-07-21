import 'package:cinex_movie_app/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final nameError = RxnString();
  final emailError = RxnString();
  final passwordError = RxnString();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(() {
      if (nameError.value != null) nameError.value = null;
    });
    emailController.addListener(() {
      if (emailError.value != null) emailError.value = null;
    });
    passwordController.addListener(() {
      if (passwordError.value != null) passwordError.value = null;
    });
  }
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String? _validateName(String name) {
    if (name.isEmpty) return 'Enter name';
    if (name.length < 3) return 'Name must be at least 3 characters';
    return null;
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return 'Enter Email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email))
      return 'Enter Valid email (example@gmail.com)';
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'Enter Password';
    if (password.length < 8) return 'Password must be at least 8 characters';
    if (!password.contains(RegExp(r'[A-Z]')))
      return 'Password must contain at least one uppercase letter';
    if (!password.contains(RegExp(r'[0-9]')))
      return 'Password must contain at least one number';
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')))
      return 'Password must contain at least one special character (!@#\$%)';
    return null;
  }

  Future<void> signUp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    nameError.value = _validateName(name);
    emailError.value = _validateEmail(email);
    passwordError.value = _validatePassword(password);

    if (nameError.value != null ||
        emailError.value != null ||
        passwordError.value != null) return;

    try {
      isLoading.value = true;
      final user = await AuthService.signUp(email, password);
      if (user != null) {
        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.TOP,
        );
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }
  // ============ GOOGLE SIGN IN ============
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      final user = await AuthService.signInWithGoogle();

      if (user != null) {
        Get.offAllNamed(AppRoutes.home);
      }

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
