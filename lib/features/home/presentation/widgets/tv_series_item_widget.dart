import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/config/api_paths.dart';
import 'package:movie_app/config/app_colors.dart';
import 'package:movie_app/core/widgets/custom_text_widget.dart';
import 'package:movie_app/features/home/data/models/tv_series_model.dart';
import 'package:movie_app/features/home/presentation/screens/tv_series_details.dart';
import 'package:movie_app/features/profile/presentation/controllers/saved_tv_series_controller.dart';

class TvSeriesItemWidget extends StatelessWidget {
  final TvSeriesModel tvSeries;

  const TvSeriesItemWidget({super.key, required this.tvSeries});

  @override
  Widget build(BuildContext context) {
    final savedTvSeriesController = Get.find<SavedTvSeriesController>();

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => TvSeriesDetailsScreen(tvSeriesId: tvSeries.id));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  '${ApiPaths.imageBaseUrl}${tvSeries.posterPath}',
                  width: 100.w,
                  height: 140.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: tvSeries.name ?? "",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: SharedColors.goldColor, size: 16.sp),
                        SizedBox(width: 4.w),
                        CustomTextWidget(
                          text:
                              '${tvSeries.voteAverage?.toStringAsFixed(1)}/10 IMDb',
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 6.w,
                      children: tvSeries.genreList?.take(3).map((genre) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: CustomTextWidget(
                                text: genre.name,
                                fontSize: 10.sp,
                                color: Colors.blue.shade900,
                              ),
                            );
                          }).toList() ??
                          [],
                    ),
                    SizedBox(height: 8.h),
                    CustomTextWidget(
                      text: 'Country: ${tvSeries.originCountry?.first}',
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 8.w,
          child: Obx(() {
            bool isSaved = savedTvSeriesController.isSaved(tvSeries);
            return GestureDetector(
              onTap: () => savedTvSeriesController.toggleTvSeries(tvSeries),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: BackdropFilter(
                  // used blur here because the title could be too long and I need to show the bookmark
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_outline,
                      color: isSaved
                          ? Get.theme.colorScheme.primary
                          : Get.theme.colorScheme.inverseSurface,
                      size: 24.sp,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
