import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/config/api_paths.dart';
import 'package:movie_app/features/home/data/models/tv_series_model.dart';
import 'package:movie_app/features/profile/presentation/controllers/saved_tv_series_controller.dart';
import 'package:movie_app/features/profile/presentation/widgets/confirm_removal_sheet.dart';

class SavedTvShowsGrid extends StatelessWidget {
  final TvSeriesModel tvSeries;
  const SavedTvShowsGrid({super.key, required this.tvSeries});

  @override
  Widget build(BuildContext context) {
    final seriesController = Get.find<SavedTvSeriesController>();

    return GestureDetector(
      onTap: () {
        // Handle series tap later.
      },
      child: Stack(
        children: [
          // Poster image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              '${ApiPaths.imageBaseUrl}${tvSeries.posterPath}',
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
                      seriesController.toggleTvSeries(tvSeries);
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
