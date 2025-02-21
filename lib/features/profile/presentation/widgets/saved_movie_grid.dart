import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/config/api_paths.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/profile/presentation/controllers/saved_movies_controller.dart';
import 'package:movie_app/features/profile/presentation/widgets/confirm_removal_sheet.dart';

class SavedMovieGridItem extends StatelessWidget {
  final Movie movie;
  const SavedMovieGridItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final moviesController = Get.find<SavedMoviesController>();

    return GestureDetector(
      onTap: () {
        // Handle movie tap later.
      },
      child: Stack(
        children: [
          // Poster image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              '${ApiPaths.imageBaseUrl}${movie.posterPath}',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Bookmark button overlay
          Positioned(
            top: 8.h,
            right: 8.w,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ConfirmRemovalSheet(
                    onConfirm: () {
                      moviesController.toggleMovie(movie);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.primary.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.bookmark,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
