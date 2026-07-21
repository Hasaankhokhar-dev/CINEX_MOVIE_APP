import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
 // final String year;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.width = 130,
    this.height = 130,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width.w,
        margin: EdgeInsets.only(right: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                imageUrl,
                width: width.w,
                height: height.h,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,

                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: width.w,
                    height: height.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF6565),
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },

                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: width.w,
                    height: height.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.movie,
                      color: Colors.white38,
                      size: 30.sp,
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 6.h),

            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 2.h),

          ],
        ),
      ),
    );
  }
}