import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CastAvatar extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String role;

  const CastAvatar({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      margin: EdgeInsets.only(right: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              role,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.white54,
              ),
            ),
          ),

          SizedBox(height: 6.h),

          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              imageUrl,
              width: 70.w,
              height: 70.w,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 70.w,
                  height: 70.w,
                  color: Colors.grey[900],
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.white38,
                    size: 24.sp,
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            name,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}