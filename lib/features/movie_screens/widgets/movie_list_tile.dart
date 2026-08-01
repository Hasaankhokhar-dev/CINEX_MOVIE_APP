import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieListTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String year;
  final VoidCallback onTap;
  final Widget trailing;
  final bool showPlayOverlay;

  const MovieListTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.year,
    required this.onTap,
    required this.trailing,
    this.showPlayOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          children: [
            // ===== THUMBNAIL =====
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    imageUrl,
                    width: 55.w,
                    height: 55.w,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 55.w,
                        height: 55.w,
                        color: Colors.grey[900],
                        child: Icon(Icons.movie, color: Colors.white38, size: 20.sp),
                      );
                    },
                  ),

                  // ── NEW ── Sirf tab dikhega jab showPlayOverlay true ho
                  if (showPlayOverlay) ...[
                    Container(
                      width: 55.w,
                      height: 55.w,
                      color: Colors.black.withOpacity(0.25),
                    ),
                    Icon(Icons.play_circle_fill, color: Colors.white, size: 22.sp),
                  ],
                ],
              ),
            ),

            SizedBox(width: 14.w),

            // ===== TITLE + YEAR =====
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(year, style: TextStyle(fontSize: 12.sp, color: Colors.white54)),
                ],
              ),
            ),

            trailing,
          ],
        ),
      ),
    );
  }
}