import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/section_header.dart';
import '../widgets/featured_movie_banner.dart';
import '../widgets/movie_card.dart';
import 'detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFFF6565)),
          );
        }

        if (controller.errorMessage.value != null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.wifi_off, color: Colors.white38, size: 40.sp),
                  SizedBox(height: 12.h),
                  Text(
                    controller.errorMessage.value!,
                    style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: controller.fetchPopularMovies,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6565),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchPopularMovies,
          color: const Color(0xFFFF6565),
          backgroundColor: Colors.grey[900],
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FeaturedMovieBanner(
                  movies: controller.popularMovies.take(5).map((movie) {
                    return {
                      'image': movie.backdropUrl,
                      'title': movie.title,
                      'description': movie.overview,
                    };
                  }).toList(),
                  onMovieTap: (index) {
                    Get.to(
                          () => MovieDetailView(movieId: controller.popularMovies[index].id),
                      preventDuplicates: false,
                    );
                  },
                ),

                SizedBox(height: 24.h),

                SectionHeader(title: 'Popular Movies'),
                SizedBox(height: 12.h),

                SizedBox(
                  height: 165.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16.w, right: 4.w),
                    itemCount: controller.popularMovies.length,
                    itemBuilder: (context, index) {
                      final movie = controller.popularMovies[index];
                      return MovieCard(
                        imageUrl: movie.posterUrl,
                        title: movie.title,
                        width: 130,
                        height: 130,
                        onTap: () {
                          Get.to(
                                () => MovieDetailView(movieId: movie.id),
                            preventDuplicates: false,
                          );
                        },
                      );
                    },
                  ),
                ),

                SizedBox(height: 24.h),


                SectionHeader(title: 'Last Month'),
                SizedBox(height: 12.h),

                SizedBox(
                  height: 165.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16.w, right: 4.w),
                    itemCount: controller.lastMonthMovies.length,
                    itemBuilder: (context, index) {
                      final movie = controller.lastMonthMovies[index];
                      return MovieCard(
                        imageUrl: movie.posterUrl,
                        title: movie.title,
                        width: 130,
                        height: 130,
                        onTap: () {
                          Get.to(
                                () => MovieDetailView(movieId: movie.id),
                            preventDuplicates: false,
                          );
                        },
                      );
                    },
                  ),
                ),

                SizedBox(height: 24.h),

                SectionHeader(title: 'Last 6 Month'),
                SizedBox(height: 12.h),

                SizedBox(
                  height: 280.h,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 16.w, right: 4.w),
                          itemCount: (controller.last6MonthMovies.length / 2).ceil(),
                          itemBuilder: (context, index) {
                            final movie = controller.last6MonthMovies[index * 2];
                            return MovieCard(
                              imageUrl:  movie.posterUrl,
                              title: movie.title,
                              width: 100,
                              height: 100,
                              onTap: () {
                                Get.to(
                                      () => MovieDetailView(movieId: movie.id),
                                       preventDuplicates: false,
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 16.w, right: 4.w),
                          itemCount: controller.last6MonthMovies.length ~/ 2,
                          itemBuilder: (context, index) {
                            final movie = controller.last6MonthMovies[index * 2 + 1];
                            return MovieCard(
                              imageUrl: movie.posterUrl,
                              title: movie.title,
                              width: 100,
                              height: 100,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 100.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}