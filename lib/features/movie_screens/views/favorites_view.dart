import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/favorites_controller.dart';
import '../widgets/favorite_movie_item.dart';
import 'detail_view.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            SizedBox(height: 8.h),

            Expanded(
              child: Obx(() {
                if (controller.favorites.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.separated(
                  padding: EdgeInsets.only(top: 4.h, bottom: 20.h),
                  itemCount: controller.favorites.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.white12,
                    height: 1,
                    indent: 16.w,
                    endIndent: 16.w,
                  ),
                  itemBuilder: (context, index) {
                    final movie = controller.favorites[index];
                    return FavoriteMovieItem(
                      imageUrl: movie.posterUrl, // ── NEW ──
                      title: movie.title,
                      year: movie.year,
                      onTap: () {
                        Get.to(
                              () => MovieDetailView(movieId: movie.id), // ── NEW ──
                          preventDuplicates: false,
                        );
                      },
                      onRemove: () {
                        controller.toggleFavorite(movie); // ── NEW ── remove karega kyunke already favorite hai
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF262626),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 15.sp),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Favorites',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 30.w),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_border, color: Colors.white24, size: 60.sp),
          SizedBox(height: 12.h),
          Text(
            'No favorites yet',
            style: TextStyle(color: Colors.white54, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}