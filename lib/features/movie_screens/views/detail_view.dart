import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/movie_detail_controller.dart';
import '../widgets/cast_avatar.dart';


class MovieDetailView extends StatefulWidget {
  final int movieId;

  const MovieDetailView({super.key, required this.movieId});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  bool _isWishlisted = false;
  bool _isSynopsisExpanded = false;

  late final MovieDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      MovieDetailController(movieId: widget.movieId),
      tag: widget.movieId.toString(),
    );
  }

  @override
  void dispose() {
    Get.delete<MovieDetailController>(tag: widget.movieId.toString());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    controller.errorMessage.value!,
                    style: const TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: controller.fetchMovieDetail,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final movie = controller.movieDetail.value;
        if (movie == null) {
          return const SizedBox.shrink();
        }

        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPosterHeader(movie),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        _buildTitleAndMeta(movie),
                        SizedBox(height: 20.h),
                        _buildSynopsis(movie),
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
                  SizedBox(height: 30.h),
                ],
              ),
            ),

            _buildStickyTopBar(),
          ],
        );
      }),
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
              _circleIconButton(
                icon: Icons.arrow_back_ios_new,
                onTap: () => Get.back(),
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
                  SizedBox(width: 10.w),
                  CircleAvatar(
                    radius: 16.r,
                    backgroundColor: const Color(0xFFFF6565),
                    child: Icon(Icons.person, size: 18.sp, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPosterHeader(movie) {
    return SizedBox(
      width: double.infinity,
      height: 320.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            movie.backdropUrl, // ── NEW ── real data
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
          Center(
            child: GestureDetector(
              onTap: () {
                // Trailer logic baad mein
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Play Trailer',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500),
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
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.4)),
        child: Icon(icon, color: iconColor, size: 16.sp),
      ),
    );
  }

  Widget _buildTitleAndMeta(movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 6.h),

        Row(
          children: [
            Expanded(
              child: Text(
                '${movie.year} · ${movie.genresText} · ${movie.runtimeFormatted}',
                style: TextStyle(fontSize: 12.sp, color: Colors.white54),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(width: 8.w),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                final starValue = (movie.voteAverage / 2).round();
                return Icon(
                  index < starValue ? Icons.star : Icons.star_border,
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
  Widget _buildSynopsis(movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Synopsis',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        SizedBox(height: 8.h),
        RichText(
          maxLines: _isSynopsisExpanded ? null : 3,
          overflow: _isSynopsisExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          text: TextSpan(
            style: TextStyle(fontSize: 12.sp, color: Colors.white70, height: 1.5),
            children: [
              TextSpan(text: movie.overview), // ── NEW ──
              TextSpan(
                text: _isSynopsisExpanded ? '' : '  Read More...',
                style: const TextStyle(color: Color(0xFFFF6565), fontWeight: FontWeight.w600),
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
          height: 130.h,
          child: Obx(() {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.cast.length,
              itemBuilder: (context, index) {
                final member = controller.cast[index];
                return CastAvatar(
                  imageUrl: member.profileUrl,
                  name: member.name,
                  role: member.character,
                );
              },
            );
          }),
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
}