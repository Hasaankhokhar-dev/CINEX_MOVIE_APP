import 'package:cinex_movie_app/core/constants/app_colors.dart';
import 'package:cinex_movie_app/core/constants/app_images.dart';
import 'package:cinex_movie_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../controllers/forgot_password_controller.dart';
import '../widgets/app_text_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Image.asset(AppImages.logoSmall, width: 80.w),
              SizedBox(height: 24.h),
              Center(
                child: Text(
                  AppStrings.forgotPasswordTitle,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                AppStrings.forgotPasswordSubtitle,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 24.h),
             Obx( () => AppTextField(
                hint: AppStrings.emailHint,
                prefixIcon: AppImages.mailIcon,
                keyboardType: TextInputType.emailAddress,
                textController: controller.emailController,
                errorText: controller.emailError.value,
              ),
             ),
              SizedBox(height: 22.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.sendResetEmail(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.sendCode,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 304.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.rememberPassword,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.white70,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.login),
                      child: Text(
                        AppStrings.login,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
