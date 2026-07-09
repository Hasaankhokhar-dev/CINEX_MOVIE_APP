import 'package:cinex_movie_app/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isRememberMe = false.obs;
  final isLoading = false.obs;
  final emailError = RxnString();
  final passwordError = RxnString();

  @override
  void onInit() {
    super.onInit();

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

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();


    try {
      isLoading.value = true;

      final user = await AuthService.signIn(email, password,isRememberMe.value);

      if (user != null) {
        Get.offAllNamed(AppRoutes.home);
      }

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
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}