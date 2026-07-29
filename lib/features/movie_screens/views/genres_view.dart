import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/custom_radio_tile.dart';
import '../widgets/movie_list_tile.dart';
import 'detail_view.dart';

class GenresView extends StatefulWidget {
  const GenresView({super.key});

  @override
  State<GenresView> createState() => _GenresViewState();
}

class _GenresViewState extends State<GenresView> {
  String _selectedSort = 'Most Popular';

  final List<String> _sortOptions = [
    'Most Relevant',
    'Most Popular',
    'Most Recent',
  ];

  String _selectedGenre = 'All';

  final List<String> _genres = [
    'All', 'Horror', 'Action', 'Thriller', 'Drama', 'Comedy',
    'Fantasy', 'Sci-fi', 'History', 'Anime', 'Romantic', 'Crime',
  ];

  final List<Map<String, String>> _results = [
    {
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'title': 'Spider-Man: No Way Home',
      'year': '2021',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg',
      'title': 'Money Heist',
      'year': '2022',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg',
      'title': 'Squid Game',
      'year': '2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== FILTERS (padded) =====
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),

                          _buildSectionLabel('SORT BY'),
                          SizedBox(height: 4.h),

                          ..._sortOptions.map((option) {
                            return CustomRadioTile(
                              label: option,
                              isSelected: _selectedSort == option,
                              onTap: () => setState(() => _selectedSort = option),
                            );
                          }),

                          SizedBox(height: 16.h),
                          Divider(color: Colors.white12, height: 1),
                          SizedBox(height: 16.h),

                          _buildSectionLabel('GENRES'),
                          SizedBox(height: 8.h),

                          _buildGenresGrid(),

                          SizedBox(height: 20.h),

                          _buildApplyButton(),

                          SizedBox(height: 20.h),
                          Divider(color: Colors.white12, height: 1),
                        ],
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // ── FIX ── ye call missing thi, ab add ki
                    _buildResultsList(),

                    SizedBox(height: 90.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== TOP BAR — single pill, Favorites jaisa =====
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
                  'Genres',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 30.w), // ── NEW ── back icon ke barabar khali jagah, text perfectly center rahe
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white54,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildGenresGrid() {
    return Wrap(
      children: List.generate(_genres.length, (index) {
        final genre = _genres[index];
        return SizedBox(
          width: (ScreenUtil().screenWidth - 32.w) / 2,
          child: CustomRadioTile(
            label: genre,
            isSelected: _selectedGenre == genre,
            onTap: () => setState(() => _selectedGenre = genre),
          ),
        );
      }),
    );
  }

  Widget _buildApplyButton() {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6565),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
          elevation: 0,
        ),
        child: Text(
          'Apply Settings',
          style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ── FIX ── ye poora method missing tha, ab add kiya
  Widget _buildResultsList() {
    if (_results.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Center(
          child: Text('No movies found', style: TextStyle(color: Colors.white54, fontSize: 13.sp)),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final movie = _results[index];
        // return MovieListTile(
        //   imageUrl: movie['image'] ?? '',
        //   title: movie['title'] ?? '',
        //   year: movie['year'] ?? '',
        //   onTap: () {
        //     Get.to(() => const MovieDetailView(), preventDuplicates: false);
        //   },
        //   showPlayOverlay: false,
        //   trailing: Container(
        //     width: 34.w,
        //     height: 34.w,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       border: Border.all(color: const Color(0xFFFF6565), width: 1.5),
        //     ),
        //     child: Icon(Icons.play_arrow_rounded, color: const Color(0xFFFF6565), size: 18.sp),
        //   ),
        // );
      },
    );
  }
}