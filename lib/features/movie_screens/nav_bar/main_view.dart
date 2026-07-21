import 'package:cinex_movie_app/core/constants/app_colors.dart';
import 'package:cinex_movie_app/features/movie_screens/views/genres_view.dart';
import 'package:cinex_movie_app/features/movie_screens/views/favorites_view.dart';
import 'package:cinex_movie_app/features/movie_screens/views/home_view.dart';
import 'package:cinex_movie_app/features/movie_screens/views/search_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const FavoritesView(),
    const SearchView(),
    const GenresView(),
  ];

  final List<String> _activeIcons = [
    'assets/svg/nav_home_filled.svg',
    'assets/svg/nav_favorite_filled.svg',
    'assets/svg/nav_search_filled.svg',
    'assets/svg/nav_compass_filled.svg',
  ];

  final List<String> _inactiveIcons = [
    'assets/svg/nav_home.svg',
    'assets/svg/nav_favorite.svg',
    'assets/svg/nav_search.svg',
    'assets/svg/compass.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
        bottomNavigationBar: SafeArea(

            child: CurvedNavigationBar(
              index: _currentIndex,
              height: 60.0,
              color: AppColors.primary,
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: AppColors.primary,
              animationDuration: const Duration(milliseconds: 300),
              animationCurve: Curves.easeInOut,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: List.generate(4, (index) {
                final isActive = _currentIndex == index;
                return SvgPicture.asset(
                  isActive ? _activeIcons[index] : _inactiveIcons[index],
                  width: 24.w,
                  height: 24.w,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                );
              }),
            ),
          ),
    );
  }
}