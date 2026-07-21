import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/cast_avatar.dart';
import '../widgets/movie_card.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({super.key});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  bool _isWishlisted = false;
  bool _isSynopsisExpanded = false;

  final String _posterUrl =
      'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg';

  final List<Map<String, String>> _cast = [
    {
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'name': 'Tom Holland',
      'role': 'Hero',
    },{
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'name': 'Tom Holland',
      'role': 'Hero',
    },{
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'name': 'Tom Holland',
      'role': 'Hero',
    },{
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'name': 'Tom Holland',
      'role': 'Hero',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg',
      'name': 'Zendaya',
      'role': 'Heroine',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdYTdeq.jpg',
      'name': 'Tom Hardy',
      'role': 'Actor',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg',
      'name': 'Mark Charles',
      'role': 'Actor',
    },
  ];

  final List<Map<String, String>> _relatedMovies = [
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
      'title': 'Avengers',
      'year': '2019',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg',
      'title': 'The Batman',
      'year': '2022',
    },
    {
      'image': 'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      'title': 'Dune',
      'year': '2024',
    },
  ];

  final String _synopsis =
      'Spider-Man: No Way Home (2020) follows Peter Parker as he grapples with the consequences of his secret identity being exposed to the world. In an effort to erase everyone\'s memory and restore his normal life, Peter seeks the help of Doctor Strange.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPosterHeader(),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      _buildTitleAndMeta(),
                      SizedBox(height: 20.h),
                      _buildSynopsis(),
                      SizedBox(height: 20.h),
                      _buildCastSection(),
                      SizedBox(height: 20.h),
                      _buildWatchNowButton(),
                      SizedBox(height: 24.h),
                      _buildRelatedMoviesHeader(),
                    ],
                  ),
                ),

                SizedBox(height: 12.h),
                _buildRelatedMoviesList(),
                SizedBox(height: 30.h),
              ],
            ),
          ),

          _buildStickyTopBar(),
        ],
      ),
    );
  }

  Widget _buildStickyTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back button
              _circleIconButton(
                icon: Icons.arrow_back_ios_new,
                onTap: () => Navigator.pop(context),
              ),
              Row(
                children: [
                  _circleIconButton(
                    icon: _isWishlisted ? Icons.favorite : Icons.favorite_border,
                    iconColor: _isWishlisted ? Colors.red : Colors.white,
                    onTap: () {
                      setState(() {
                        _isWishlisted = !_isWishlisted;
                      });
                    },
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPosterHeader() {
    return SizedBox(
      width: double.infinity,
      height: 320.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            _posterUrl,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: Colors.grey[900]);
            },
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.4),
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),

          // Center — Play trailer button
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(

                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4.w),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 30.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Play Trailer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleIconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34.w,
        height: 34.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.4),
        ),
        child: Icon(icon, color: iconColor, size: 16.sp),
      ),
    );
  }

  Widget _buildTitleAndMeta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Spider-Man: No Way Home',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '2021 · Action/Sci-Fi · 3hr 28min',
              style: TextStyle(fontSize: 12.sp, color: Colors.white54),
            ),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < 4 ? Icons.star : Icons.star_border,
                  color: const Color(0xFFFFC107),
                  size: 14.sp,
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSynopsis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Synopsis',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        RichText(
          maxLines: _isSynopsisExpanded ? null : 3,
          overflow: _isSynopsisExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          text: TextSpan(
            style: TextStyle(fontSize: 12.sp, color: Colors.white70, height: 1.5),
            children: [
              TextSpan(text: _synopsis),
              TextSpan(
                text: _isSynopsisExpanded ? '' : '  Read More...',
                style: const TextStyle(
                  color: Color(0xFFFF6565),
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      _isSynopsisExpanded = true;
                    });
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCastSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cast',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _cast.length,
            itemBuilder: (context, index) {
              final member = _cast[index];
              return CastAvatar(
                imageUrl: member['image'] ?? '',
                name: member['name'] ?? '',
                role: member['role'] ?? '',
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWatchNowButton() {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6565),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_circle_fill, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              'Watch Now',
              style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedMoviesHeader() {
    return Text(
      'Related Movies',
      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white),
    );
  }

  Widget _buildRelatedMoviesList() {
    return SizedBox(
      height: 280.h,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 16.w, right: 4.w),
              itemCount: (_relatedMovies.length / 2).ceil(),
              itemBuilder: (context, index) {
                final movie = _relatedMovies[index * 2];
                return MovieCard(
                  imageUrl: movie['image'] ?? '',
                  title: movie['title'] ?? '',
                  width: 100,
                  height: 100,
                  onTap: () {
                    Get.to(() => const MovieDetailView(),
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
              itemCount: _relatedMovies.length ~/ 2,
              itemBuilder: (context, index) {
                final movie = _relatedMovies[index * 2 + 1];
                return MovieCard(
                  imageUrl: movie['image'] ?? '',
                  title: movie['title'] ?? '',
                  width: 100,
                  height: 100,
                  onTap: () {
                    Get.to(() => const MovieDetailView(),
                      preventDuplicates: false,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}