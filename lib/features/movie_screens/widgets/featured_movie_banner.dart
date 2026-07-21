import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedMovieBanner extends StatefulWidget {
  final List<Map<String, String>> movies;

  const FeaturedMovieBanner({
    super.key,
    required this.movies,
  });

  @override
  State<FeaturedMovieBanner> createState() => _FeaturedMovieBannerState();
}

class _FeaturedMovieBannerState extends State<FeaturedMovieBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 450.h,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.movies.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie['image'] ?? '',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(color: Colors.grey[900]);
                    },
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
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.95),
                        ],
                        stops: const [0.0, 0.25, 0.7, 1.0],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 40.h,
                    left: 16.w,
                    right: 16.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie['title'] ?? '',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        Text(
                          movie['description'] ?? '',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white70,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              top: 25.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/home_logo.png', width: 28.w, height: 28.w),
              ],
            ),
          ),

          Positioned(
            bottom: 16.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.movies.length,
                    (index) {
                  final isSelected = _currentPage == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isSelected ? 20.w : 8.w,
                    height: 6.h,
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.white38,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}