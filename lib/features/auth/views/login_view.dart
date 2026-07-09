import 'package:cinex_movie_app/core/constants/app_colors.dart';
import 'package:cinex_movie_app/core/constants/app_images.dart';
import 'package:cinex_movie_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../controllers/login_controller.dart';
import '../widgets/app_text_field.dart';
import '../widgets/social_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

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
                  AppStrings.loginTitle,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              // Subtitle
              Text(
                AppStrings.loginSubtitle,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),

              SizedBox(height: 24.h),

              // Email field
              AppTextField(
                hint: AppStrings.emailHint,
                prefixIcon: AppImages.mailIcon,
                keyboardType: TextInputType.emailAddress,
                textController: controller.emailController,
              ),

              SizedBox(height: 16.h),

              // Password field
              Obx(() => AppTextField(
                hint: AppStrings.passwordHint,
                prefixIcon: AppImages.lockIcon,
                isPassword: true,
                isPasswordVisible: controller.isPasswordVisible.value,
                onTogglePassword: controller.togglePasswordVisibility,
                textController: controller.passwordController,
              )),

              SizedBox(height: 12.h),

              // Remember me + Forget Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Remember me checkbox
                  Obx(() => Row(
                    children: [
                      GestureDetector(
                        onTap: controller.toggleRememberMe,
                        child: Container(
                          width: 18.w,
                          height: 18.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.grey,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                            color: controller.isRememberMe.value
                                ? AppColors.grey
                                : Colors.transparent,
                          ),
                          child: controller.isRememberMe.value
                              ? Icon(
                            Icons.check,
                            size: 12.sp,
                            color: AppColors.white,
                          )
                              : null,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        AppStrings.rememberMe,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.white70,
                        ),
                      ),
                    ],
                  )),

                  // Forget Password
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                    child: Text(
                      AppStrings.forgetPassword,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Log in button
             Obx(() =>SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.login,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
             ),
              SizedBox(height: 24.h),

              // OR divider
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.divider,
                      thickness: 1,
                    ),
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
                  Expanded(
                    child: Divider(
                      color: AppColors.divider,
                      thickness: 1,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Social buttons
              SocialButton(
                icon: AppImages.googleIcon,
                label: AppStrings.continueWithGoogle,
                onTap: () => controller.signInWithGoogle(),
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

              SizedBox(height: 24.h),

              // Don't have account
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.white70,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.signup),
                      child: Text(
                        AppStrings.signupTitle,
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
