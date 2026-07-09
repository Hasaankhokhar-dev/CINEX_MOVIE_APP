import 'package:cinex_movie_app/core/constants/app_colors.dart';
import 'package:cinex_movie_app/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final String prefixIcon;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onTogglePassword;
  final TextInputType keyboardType;
  final String? errorText;
  final TextEditingController? textController;
  const AppTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onTogglePassword,
    this.keyboardType = TextInputType.text,
    this.textController,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      style: TextStyle(color: AppColors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        errorText: errorText,
        errorStyle: TextStyle(
          color: const Color(0xFFFF6565),
          fontSize: 12.sp,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: Color(0xFFFF6565),
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: Color(0xFFFF6565),
            width: 1.5,
          ),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.white70, fontSize: 14.sp),
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.w),
          child: SvgPicture.asset(
            prefixIcon,
            width: 20.w,
            height: 20.w,
            colorFilter: ColorFilter.mode(
              AppColors.white.withOpacity(0.54),
              BlendMode.srcIn,
            ),
          ),
        ),
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: onTogglePassword,
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: SvgPicture.asset(
                    isPasswordVisible
                        ? AppImages.eyeClosedIcon
                        : AppImages.eyeOpenIcon,
                    width: 20.w,
                    height: 20.w,
                    colorFilter: ColorFilter.mode(
                      AppColors.white.withOpacity(0.54),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: AppColors.grey,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
