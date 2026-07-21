import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadioTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomRadioTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // ── NEW ── InkWell ki jagah, koi ripple/highlight nahi aayega
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // ── NEW ── khali space pe bhi tap kaam kare
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFFF6565) : Colors.white38,
                  width: 1.5,
                ),
                color: isSelected ? const Color(0xFFFF6565) : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                  : null,
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}