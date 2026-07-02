import 'package:cinex_movie_app/core/constants/app_colors.dart';
import 'package:cinex_movie_app/core/constants/app_images.dart';
import 'package:cinex_movie_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../controllers/create_new_password_controller.dart';
import '../widgets/app_text_field.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateNewPasswordController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Logo
              Image.asset(AppImages.logoSmall, width: 80.w),

              SizedBox(height: 24.h),

              // Title
              Center(
                child: Text(
                  AppStrings.createNewPasswordTitle,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Subtitle
              Text(
                AppStrings.createNewPasswordSubtitle,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),

              SizedBox(height: 32.h),

              // New Password field
              Obx(() => AppTextField(
                hint: AppStrings.passwordHint,
                prefixIcon: AppImages.lockIcon,
                isPassword: true,
                isPasswordVisible: controller.isNewPasswordVisible.value,
                onTogglePassword: controller.toggleNewPassword,
              )),

              SizedBox(height: 16.h),

              // Confirm Password field
              Obx(() => AppTextField(
                hint: AppStrings.passwordHint,
                prefixIcon: AppImages.lockIcon,
                isPassword: true,
                isPasswordVisible: controller.isConfirmPasswordVisible.value,
                onTogglePassword: controller.toggleConfirmPassword,
              )),

              SizedBox(height: 32.h),

              // Reset Password button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.passwordChanged);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.resetPassword,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
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
