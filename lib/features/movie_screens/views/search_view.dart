import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/movie_list_tile.dart';
import 'detail_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  // ===== DUMMY DATA — API se baad mein aayega =====
  final List<Map<String, String>> _topSearches = [
    {'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg', 'title': 'Spider-Man: No Way Home', 'year': '2021'},
    {'image': 'https://image.tmdb.org/t/p/w500/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg', 'title': 'Money Heist', 'year': '2022'},
    {'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg', 'title': 'Squid Game', 'year': '2024'},
    {'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg', 'title': 'Justice League', 'year': '2017'},
    {'image': 'https://image.tmdb.org/t/p/w500/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg', 'title': 'The Nun', 'year': '2018'},
    {'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg', 'title': 'Fast X', 'year': '2024'},
    {'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg', 'title': 'Fast X', 'year': '2024'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== SEARCH TITLE =====
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 4.h),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white38,
                  letterSpacing: 1,
                ),
              ),
            ),

            // ===== SEARCH BAR =====
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: SizedBox( // ── NEW ── Container ki jagah SizedBox, guaranteed full width
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
                          controller: _searchController,
                          style: TextStyle(color: Colors.white, fontSize: 13.sp),
                          decoration: InputDecoration(
                            hintText: 'Search for a show, movie, genre, etc.',
                            hintStyle: TextStyle(color: Colors.white38, fontSize: 12.sp),
                            border: InputBorder.none,
                            isDense: true,
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

            // ===== TOP SEARCHES HEADING =====
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Top Searches',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 4.h),

            // ===== RESULTS LIST =====
            Expanded(
              child: ListView.separated( // ── NEW ── builder ki jagah separated, divider ke liye
                padding: EdgeInsets.only(bottom: 90.h),
                itemCount: _topSearches.length,
                separatorBuilder: (context, index) => Divider( // ── NEW ── divider line
                  color: Colors.white12,
                  height: 1,
                  indent: 16.w,
                  endIndent: 16.w,
                ),
                itemBuilder: (context, index) {
                  final movie = _topSearches[index];
                  return MovieListTile(
                    imageUrl: movie['image'] ?? '',
                    title: movie['title'] ?? '',
                    year: movie['year'] ?? '',
                    showPlayOverlay: false,
                    onTap: () {
                      Get.to(() => const MovieDetailView(), preventDuplicates: false);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}