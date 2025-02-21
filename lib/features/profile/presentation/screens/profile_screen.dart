import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movie_app/config/api_paths.dart';
import 'package:movie_app/config/asset_paths.dart';
import 'package:movie_app/core/widgets/custom_text_widget.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/data/models/tv_series_model.dart';
import 'package:movie_app/features/profile/presentation/controllers/saved_movies_controller.dart';
import 'package:movie_app/features/profile/presentation/controllers/saved_tv_series_controller.dart';
import 'package:movie_app/features/shared/presentation/controllers/current_user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SavedMoviesController moviesController =
        Get.find<SavedMoviesController>();
    final SavedTvSeriesController seriesController =
        Get.find<SavedTvSeriesController>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          elevation: 0,
          toolbarHeight: 100.h,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: SvgPicture.asset(
              AssetPaths.appLogo,
              height: 80.h,
              fit: BoxFit.contain,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout,
                  color: Get.theme.colorScheme.primary, size: 30.sp),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => LogoutConfirmationSheet(
                    onConfirm: () {
                      Get.find<CurrentUserController>().logUserOut();
                    },
                  ),
                );
              },
            )
          ],
          bottom: TabBar(
            indicatorColor: Get.theme.colorScheme.primary,
            labelStyle: Get.textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Get.theme.colorScheme.primary,
            ),
            unselectedLabelStyle: Get.textTheme.displayMedium,
            tabs: const [
              Tab(text: "Movies"),
              Tab(text: "Series"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Saved Movies Grid
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Obx(() {
                final movies = moviesController.savedMovies;
                if (movies.isEmpty) {
                  return Center(
                    child: CustomTextWidget(
                      text: "No saved movies",
                      color: Get.theme.colorScheme.primary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
                return GridView.builder(
                  itemCount: movies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.w,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return SavedMovieGridItem(movie: movie);
                  },
                );
              }),
            ),
            // Saved Series Grid
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Obx(() {
                final series = seriesController.savedTvSeries;
                if (series.isEmpty) {
                  return Center(
                    child: CustomTextWidget(
                      text: "No saved series",
                      color: Get.theme.colorScheme.primary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
                return GridView.builder(
                  itemCount: series.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.w,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final tvSeries = series[index];
                    return SavedSeriesGridItem(tvSeries: tvSeries);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class SavedMovieGridItem extends StatelessWidget {
  final Movie movie;
  const SavedMovieGridItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final SavedMoviesController moviesController =
        Get.find<SavedMoviesController>();

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

class SavedSeriesGridItem extends StatelessWidget {
  final TvSeriesModel tvSeries;
  const SavedSeriesGridItem({super.key, required this.tvSeries});

  @override
  Widget build(BuildContext context) {
    final SavedTvSeriesController seriesController =
        Get.find<SavedTvSeriesController>();

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

class ConfirmRemovalSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  const ConfirmRemovalSheet({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextWidget(
            text: "Remove from saved?",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Get.theme.colorScheme.primary,
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: CustomTextWidget(
                  text: "Cancel",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
              ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.colorScheme.primary,
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: CustomTextWidget(
                  text: "Remove",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LogoutConfirmationSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  const LogoutConfirmationSheet({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextWidget(
            text: "Logout",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Get.theme.colorScheme.primary,
          ),
          SizedBox(height: 16.h),
          CustomTextWidget(
            text: "Are you sure you want to logout?",
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: Get.theme.colorScheme.primary,
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: CustomTextWidget(
                  text: "Cancel",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  onConfirm();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.colorScheme.primary,
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: CustomTextWidget(
                  text: "Logout",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
