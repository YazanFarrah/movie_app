import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:movie_app/config/api_paths.dart';
import 'package:movie_app/config/app_colors.dart';
import 'package:movie_app/config/asset_paths.dart';
import 'package:movie_app/core/services/url_launcher_service.dart';
import 'package:movie_app/core/widgets/custom_text_widget.dart';
import 'package:movie_app/core/widgets/loader.dart';
import 'package:movie_app/features/home/presentation/controllers/tv_series_details_controller.dart';
import 'package:readmore/readmore.dart';

class TvSeriesDetailsScreen extends StatelessWidget {
  final int tvSeriesId;

  const TvSeriesDetailsScreen({super.key, required this.tvSeriesId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TvSeriesDetailsController());
    controller.fetchTvSeriesDetails(tvSeriesId);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: LoadingFadingCircle(color: Get.theme.colorScheme.primary),
          );
        }

        final tvSeries = controller.tvSeries.value;
        if (tvSeries == null) {
          return const Center(
            child: CustomTextWidget(text: "Failed to load data"),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                padding: EdgeInsets.zero,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Get.theme.colorScheme.onSurface,
                ),
              ),
              expandedHeight: 200.h,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: CustomTextWidget(
                  text: tvSeries.name ?? "",
                  color: Get.theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                background: Image.network(
                  '${ApiPaths.imageBaseUrl}${tvSeries.backdropPath}',
                  errorBuilder: (context, error, stackTrace) {
                    return SvgPicture.asset(AssetPaths.appLogo);
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: SharedColors.goldColor, size: 20.sp),
                        SizedBox(width: 5.w),
                        CustomTextWidget(
                          text:
                              "${tvSeries.voteAverage?.toStringAsFixed(1)}/10 IMDb",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    if (tvSeries.genreList?.isNotEmpty ?? false)
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 4.h,
                        children: tvSeries.genreList!.map((genre) {
                          return Chip(
                            label: CustomTextWidget(text: genre.name),
                            backgroundColor: Get.theme.colorScheme.secondary
                                .withValues(alpha: 0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                              side: BorderSide(
                                  color: Get.theme.colorScheme.primary),
                            ),
                          );
                        }).toList(),
                      ),
                    SizedBox(height: 16.h),
                    CustomTextWidget(
                      text: "Overview",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: ReadMoreText(
                        (tvSeries.overview?.isNotEmpty ?? false)
                            ? tvSeries.overview!
                            : "No overview available",
                        trimLines: 3,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: ' Read more',
                        trimExpandedText: ' Show less',
                        style:
                            TextStyle(color: Colors.black87, fontSize: 14.sp),
                        moreStyle: TextStyle(
                          color: Get.theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        lessStyle: TextStyle(
                          color: Get.theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextWidget(
                            text:
                                "Country: ${tvSeries.originCountry?.join(", ")}",
                            fontSize: 14.sp,
                          ),
                        ),
                        Expanded(
                          child: CustomTextWidget(
                            text:
                                "Language: ${tvSeries.originalLanguage?.toUpperCase()}",
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    if (tvSeries.createdBy?.isNotEmpty ?? false) ...[
                      CustomTextWidget(
                        text: "Created By",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 8.w,
                        children: tvSeries.createdBy!.map((creator) {
                          return Chip(
                            label: CustomTextWidget(text: creator.name ?? ""),
                            backgroundColor: Colors.grey.shade200,
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16.h),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextWidget(
                            text: "Seasons: ${tvSeries.numberOfSeasons}",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: CustomTextWidget(
                            text: "Episodes: ${tvSeries.numberOfEpisodes}",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    if (tvSeries.homepage != null &&
                        tvSeries.homepage!.isNotEmpty)
                      GestureDetector(
                        onTap: () => LaunchUrlService.openWeb(
                            context, tvSeries.homepage),
                        child: Row(
                          children: [
                            Icon(Icons.link, color: Colors.blue, size: 18.sp),
                            SizedBox(width: 5.w),
                            CustomTextWidget(
                              text: "Visit Official Page",
                              fontSize: 14.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
