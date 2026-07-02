import 'package:cinex_movie_app/core/constants/app_colors.dart';
import 'package:cinex_movie_app/core/constants/app_images.dart';
import 'package:cinex_movie_app/core/constants/app_strings.dart';
import 'package:cinex_movie_app/features/auth/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../controllers/signup_controller.dart';
import '../widgets/social_button.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Image.asset(AppImages.logoSmall, width: 80.w, height: 80.h),
              Center(
                child: Text(
                  AppStrings.signupTitle,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                AppStrings.signupSubtitle,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 16.h),
              const AppTextField(
                hint: AppStrings.fullNameHint,
                prefixIcon: AppImages.personIcon,
              ),
              SizedBox(height: 16.h),
              const AppTextField(
                hint: AppStrings.emailHint,
                prefixIcon: AppImages.mailIcon,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              Obx(
                () => AppTextField(
                  hint: AppStrings.passwordHint,
                  prefixIcon: AppImages.lockIcon,
                  isPassword: true,
                  isPasswordVisible: controller.isPasswordVisible.value,
                  onTogglePassword: controller.togglePasswordVisibility,
                ),
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.signup,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: AppColors.divider, thickness: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      AppStrings.or,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: AppColors.divider, thickness: 1),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              SocialButton(
                icon: AppImages.googleIcon,
                label: AppStrings.continueWithGoogle,
                onTap: () {},
              ),
              SizedBox(height: 12.h),
              SocialButton(
                icon: AppImages.facebookIcon,
                label: AppStrings.continueWithFacebook,
                onTap: () {},
              ),
              SizedBox(height: 12.h),
              SocialButton(
                icon: AppImages.appleIcon,
                label: AppStrings.continueWithApple,
                onTap: () {},
              ),
              SizedBox(height: 10.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAccount,
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
            ],
          ),
        ),
      ),
    );
  }
}
