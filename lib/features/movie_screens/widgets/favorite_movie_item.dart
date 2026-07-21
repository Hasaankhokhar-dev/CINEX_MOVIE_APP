import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import 'movie_list_tile.dart';

class FavoriteMovieItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String year;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const FavoriteMovieItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.year,
    required this.onTap,
    required this.onRemove,
  });

  void _showOptionsMenu(BuildContext context, Offset position) async {
    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx + 1, position.dy + 1),
      color: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      items: [
        PopupMenuItem(
          value: 'share',
          child: Row(
            children: [
              const Icon(Icons.share_outlined, color: Colors.white70, size: 18),
              SizedBox(width: 10.w),
              const Text('Share', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'remove',
          child: Row(
            children: [
              const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
              SizedBox(width: 10.w),
              const Text('Remove from Favorites', style: TextStyle(color: Colors.redAccent)),
            ],
          ),
        ),
      ],
    );

    if (selected == 'share') {
      Share.share('Check out "$title" ($year) on Cinex! 🎬');
    } else if (selected == 'remove') {
      onRemove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MovieListTile(
      imageUrl: imageUrl,
      title: title,
      year: year,
      onTap: onTap,
      showPlayOverlay: true,
      trailing: Builder(
        builder: (context) {
          return GestureDetector(
            onTapDown: (details) => _showOptionsMenu(context, details.globalPosition),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Icon(Icons.more_vert, color: Colors.white54, size: 20.sp),
            ),
          );
        },
      ),
    );
  }
}