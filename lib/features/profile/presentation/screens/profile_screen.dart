import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movie_app/config/asset_paths.dart';
import 'package:movie_app/core/widgets/custom_text_widget.dart';
import 'package:movie_app/features/profile/presentation/controllers/saved_movies_controller.dart';
import 'package:movie_app/features/profile/presentation/controllers/saved_tv_series_controller.dart';
import 'package:movie_app/features/profile/presentation/widgets/logout_confirmation_sheet.dart';
import 'package:movie_app/features/profile/presentation/widgets/saved_movie_grid.dart';
import 'package:movie_app/features/profile/presentation/widgets/saved_tv_shows_grid.dart';
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
                    return SavedTvShowsGrid(tvSeries: tvSeries);
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




