import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/config/api_paths.dart';
import 'package:movie_app/config/app_colors.dart';
import 'package:movie_app/core/enums/text_style_enum.dart';
import 'package:movie_app/core/widgets/custom_cached_image.dart';
import 'package:movie_app/core/widgets/custom_text_widget.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/presentation/screens/movie_details_screen.dart';
import 'package:movie_app/features/profile/presentation/controllers/saved_movies_controller.dart';

class TopRatedMovieItemWidget extends StatelessWidget {
  final Movie movie;
  const TopRatedMovieItemWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final savedMoviesController = Get.find<SavedMoviesController>();

    return GestureDetector(
      onTap: () {
        if (movie.id != null) {
          Get.to(() => MovieDetailsScreen(movieId: movie.id!));
        }
      },
      child: Container(
        margin: EdgeInsets.all(8.r),
        child: Column(
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CustomCachedImage(
                image: '${ApiPaths.imageBaseUrl}${movie.backdropPath}',
                fit: BoxFit.cover,
                height: 212.h,
                width: double.infinity,
              ),
            ),
            CustomTextWidget(
              text: movie.title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(Icons.star, color: SharedColors.goldColor, size: 16.sp),
                SizedBox(width: 8.w),
                CustomTextWidget(
                  text: "${movie.voteAverage?.toStringAsFixed(1)}/10",
                  textThemeStyle: TextThemeStyleEnum.displaySmall,
                ),
                const Spacer(),
                Obx(() {
                  bool isSaved = savedMoviesController.isSaved(movie);
                  return GestureDetector(
                    onTap: () => savedMoviesController.toggleMovie(movie),
                    child: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_outline,
                      color: isSaved
                          ? Get.theme.colorScheme.primary
                          : Get.theme.colorScheme.inverseSurface,
                      size: 24.sp,
                    ),
                  );
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
