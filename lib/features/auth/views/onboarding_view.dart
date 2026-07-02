import 'package:cinex_movie_app/core/constants/app_colors.dart';
import 'package:cinex_movie_app/core/constants/app_images.dart';
import 'package:cinex_movie_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background movie poster
          Image.asset(
            AppImages.onboarding,
            fit: BoxFit.cover,
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  const Spacer(),

                  // Logo + CINEX text
                  Image.asset(
                    AppImages.logo,
                    width: 209.w,
                    height: 102.h,
                  ),
                  SizedBox(height: 12.h),
                  Image.asset(
                    AppImages.cinex,
                    width: 120.w,
                    height: 41.h,
                  ),

                  SizedBox(height: 40.h),

                  // Watch Movies Anytime Anywhere
                  Text(
                    AppStrings.onboardingTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),

                  const Spacer(),

                  // Log in button (filled)
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.login);
                      },
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

                  SizedBox(height: 16.h),

                  // Sign up button (outlined)
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.signup);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: AppColors.white,
                          width: 1.5,
                        ),
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

                  SizedBox(height: 16.h),

                  // Continue as guest
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.home);
                    },
                    child: Text(
                      AppStrings.continueAsGuest,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.white70,
                        decorationColor: AppColors.white70,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
