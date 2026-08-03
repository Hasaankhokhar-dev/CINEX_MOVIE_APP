import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/search_controller.dart';
import '../widgets/movie_list_tile.dart';
import 'detail_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MovieSearchController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 4.h),
              child: Text(
                'Search',
                style: TextStyle(fontSize: 13.sp, color: Colors.white38, letterSpacing: 1),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.white54, size: 20.sp),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: controller.searchTextController, // ── NEW ──
                          style: TextStyle(color: Colors.white, fontSize: 13.sp),
                          decoration: InputDecoration(
                            hintText: 'Search for a show, movie, genre, etc.',
                            hintStyle: TextStyle(color: Colors.white38, fontSize: 12.sp),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Icon(Icons.mic_none, color: Colors.white54, size: 20.sp),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(() => Text(
                controller.hasSearched.value ? 'Results' : 'Top Searches',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
              )),
            ),

            SizedBox(height: 4.h),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFFF6565)),
                  );
                }

                if (controller.errorMessage.value != null) {
                  return Center(
                    child: Text(
                      controller.errorMessage.value!,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  );
                }

                // ===== EMPTY STATE — kuch search hi nahi hua abhi =====
                if (!controller.hasSearched.value) {
                  return Center(
                    child: Text(
                      'Search for a movie to get started',
                      style: TextStyle(color: Colors.white38, fontSize: 13.sp),
                    ),
                  );
                }

                // ===== NO RESULTS =====
                if (controller.searchResults.isEmpty) {
                  return Center(
                    child: Text(
                      'No movies found',
                      style: TextStyle(color: Colors.white54, fontSize: 13.sp),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 90.h),
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final movie = controller.searchResults[index];
                    return MovieListTile(
                      imageUrl: movie.posterUrl,
                      title: movie.title,
                      year: movie.year,
                      showPlayOverlay: false,
                      onTap: () {
                        Get.to(
                              () => MovieDetailView(movieId: movie.id), // ── NEW ── crash fix bhi ho gaya
                          preventDuplicates: false,
                        );
                      },
                      trailing: Container(
                        width: 34.w,
                        height: 34.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFFF6565), width: 1.5),
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: const Color(0xFFFF6565),
                          size: 18.sp,
                        ),
                      ),
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
}