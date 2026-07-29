import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/favorite_movie_item.dart';
import 'detail_view.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  // ===== DUMMY DATA — GetX controller/API se baad mein aayega =====
  final List<Map<String, String>> _favorites = [
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
    {
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'title': 'Justice League',
      'year': '2017',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg',
      'title': 'The Nun',
      'year': '2018',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg',
      'title': 'Fast X',
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

            SizedBox(height: 8.h),

            // ===== FAVORITES LIST =====
            Expanded(
              child: _favorites.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                padding: EdgeInsets.only(top: 4.h, bottom: 20.h),
                itemCount: _favorites.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white12,
                  height: 1,
                  indent: 16.w,
                  endIndent: 16.w,
                ),
                itemBuilder: (context, index) {
                  final movie = _favorites[index];
                  // return FavoriteMovieItem(
                  //   imageUrl: movie['image'] ?? '',
                  //   title: movie['title'] ?? '',
                  //   year: movie['year'] ?? '',
                  //   onTap: () {
                  //     Get.to(
                  //           () => const MovieDetailView(),
                  //       preventDuplicates: false,
                  //     );
                  //   },
                  //   onRemove: () {
                  //     setState(() {
                  //       _favorites.removeAt(index); // ── NEW ── local remove abhi, API ke baad backend call bhi hoga
                  //     });
                  //   },
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== TOP BAR — back + title pill + heart icon =====
  // ===== TOP BAR — back + title pill + heart icon =====
  // ===== TOP BAR — sab ek single pill container ke andar =====
  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h), // ── NEW ── poore Row ki padding
        decoration: BoxDecoration(
          color: const Color(0xFF262626), // ── NEW ── single background sabke liye
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          children: [
            // Back button
            GestureDetector(
              onTap: () => Get.back(),
              child: Padding(
                padding: EdgeInsets.all(6.w), // ── NEW ── tap area thori badi
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 15.sp,
                ),
              ),
            ),

            // Title — beech mein expand ho ke center ho
            Expanded(
              child: Center(
                child: Text(
                  'Favorites',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Heart icon
            Container(
              width: 30.w,
              height: 30.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white10, // ── NEW ── thora lighter shade taake heart circle subtly visible ho andar
              ),
              child: Icon(
                Icons.favorite,
                color: Colors.white,
                size: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== EMPTY STATE — jab koi favorite na ho =====
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