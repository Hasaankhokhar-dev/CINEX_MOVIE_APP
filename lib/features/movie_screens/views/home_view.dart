import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../widgets/section_header.dart';
import '../widgets/featured_movie_banner.dart';
import '../widgets/movie_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // ===== DUMMY DATA  =====

  // Featured banner movies
  static const List<Map<String, String>> _featuredMovies = [
    {
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'title': 'Spider-Man: No Way Home',
      'description': 'Spider-Man\'s identity is revealed, throwing his life into chaos.',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg',
      'title': 'The Nun',
      'description': 'A priest and a novice uncover a dark secret in a Romanian monastery.',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg',
      'title': 'Fast X',
      'description': 'Dom Toretto and his family face their most lethal opponent yet.',
    },
  ];

  // Popular movies
  static const List<Map<String, String>> _popularMovies = [
    {
      'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg',
      'title': 'Fast X',
      'year': '2024',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg',
      'title': 'The Nun',
      'year': '2018',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'title': 'Justice League',
      'year': '2017',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg',
      'title': 'Spider-Man',
      'year': '2021',
    },
  ];

  // Last month movies
  static const List<Map<String, String>> _lastMonthMovies = [
    {
      'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg',
      'title': 'Squid Game',
      'year': '2024',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg',
      'title': 'Money Heist',
      'year': '2022',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'title': 'Avengers',
      'year': '2019',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg',
      'title': 'Fast X',
      'year': '2024',
    },
  ];

  // Last 6 months movies
  static const List<Map<String, String>> _last6MonthMovies = [
    {
      'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg',
      'title': 'Fast X Part 2',
      'year': '2025',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'title': 'Dune: Part Two',
      'year': '2024',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg',
      'title': 'The Nun',
      'year': '2018',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'title': 'Justice League',
      'year': '2017',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg',
      'title': 'Fast X',
      'year': '2024',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg',
      'title': 'The Nun',
      'year': '2018',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'title': 'Squid Game',
      'year': '2024',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg',
      'title': 'Money Heist',
      'year': '2022',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            FeaturedMovieBanner(movies: _featuredMovies),

            SizedBox(height: 24.h),

            SectionHeader(
              title: 'Popular Movies',
            ),

            SizedBox(height: 12.h),

            SizedBox(
              height: 165.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16.w, right: 4.w),
                itemCount: _popularMovies.length,
                itemBuilder: (context, index) {
                  final movie = _popularMovies[index];
                  return MovieCard(
                    imageUrl: movie['image'] ?? '',
                    title: movie['title'] ?? '',
                    width: 130,
                    height: 130,
                    onTap: () => Get.toNamed(AppRoutes.detail),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),

            SectionHeader(
              title: 'Last Month',
            ),

            SizedBox(height: 12.h),

            SizedBox(
              height: 165.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16.w, right: 4.w),
                itemCount: _lastMonthMovies.length,
                itemBuilder: (context, index) {
                  final movie = _lastMonthMovies[index];
                  return MovieCard(
                    imageUrl: movie['image'] ?? '',
                    title: movie['title'] ?? '',
                    width: 130,
                    height: 130,
                    onTap: () => Get.toNamed(AppRoutes.detail),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),

            SectionHeader(
              title: 'Last 6 Month',
            ),

            SizedBox(height: 12.h),

            SizedBox(
              height: 280.h,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(

                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 16.w, right: 4.w),
                      itemCount: (_last6MonthMovies.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        final movie = _last6MonthMovies[index * 2];
                        return MovieCard(
                          imageUrl: movie['image'] ?? '',
                          title: movie['title'] ?? '',
                          width: 100,
                          height: 100,
                          onTap: () => Get.toNamed(AppRoutes.detail),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 16.w, right: 4.w),
                      itemCount: _last6MonthMovies.length ~/ 2,
                      itemBuilder: (context, index) {
                        final movie = _last6MonthMovies[index * 2 + 1];
                        return MovieCard(
                          imageUrl: movie['image'] ?? '',
                          title: movie['title'] ?? '',
                          width: 100,
                          height: 100,
                          onTap: () => Get.toNamed(AppRoutes.detail),
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
  }
}