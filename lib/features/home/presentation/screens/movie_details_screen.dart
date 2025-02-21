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
import 'package:movie_app/features/home/presentation/controllers/movie_details_controller.dart';
import 'package:readmore/readmore.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MovieDetailsController());
    controller.fetchMovieDetails(movieId);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: LoadingFadingCircle(color: Get.theme.colorScheme.primary),
          );
        }

        final movie = controller.movie.value;
        if (movie == null) {
          return const Center(
            child: CustomTextWidget(text: "Failed to load data"),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios,
                    color: Get.theme.colorScheme.onSurface),
              ),
              expandedHeight: 250.h,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: CustomTextWidget(
                  text: movie.title ?? "",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      '${ApiPaths.imageBaseUrl}${movie.backdropPath}',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          SvgPicture.asset(AssetPaths.appLogo),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.7),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ],
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
                              "${movie.voteAverage?.toStringAsFixed(1)}/10 IMDb",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
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
                        movie.overview?.isNotEmpty == true
                            ? movie.overview!
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
                    Wrap(
                      spacing: 12.w,
                      children: [
                        _buildDetailChip("Release", movie.releaseDate ?? "N/A"),
                        _buildDetailChip("Runtime", "${movie.runtime} min"),
                        _buildDetailChip(
                            "Budget", "\$${movie.budget?.toStringAsFixed(0)}"),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    if (movie.tagline?.isNotEmpty ?? false)
                      CustomTextWidget(
                        text: '"${movie.tagline}"',
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    SizedBox(height: 16.h),
                    if (movie.productionCompanies?.isNotEmpty ?? false) ...[
                      CustomTextWidget(
                        text: "Produced By",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 8.w,
                        children: movie.productionCompanies!.map((company) {
                          return Chip(
                            label: CustomTextWidget(text: company.name ?? ""),
                            backgroundColor: Colors.grey.shade200,
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16.h),
                    ],
                    if (movie.homepage != null && movie.homepage!.isNotEmpty)
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: () =>
                            LaunchUrlService.openWeb(context, movie.homepage),
                        icon: Icon(Icons.link, color: Colors.white),
                        label: CustomTextWidget(
                          text: "Visit Official Page",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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

  Widget _buildDetailChip(String label, String value) {
    return Chip(
      backgroundColor: Colors.grey.shade200,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextWidget(
            text: "$label: ",
            fontWeight: FontWeight.bold,
          ),
          CustomTextWidget(text: value),
        ],
      ),
    );
  }
}
