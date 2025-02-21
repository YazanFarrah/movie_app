import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/utils/shared.dart';
import 'package:movie_app/core/widgets/custom_appbar.dart';
import 'package:movie_app/core/widgets/custom_text_widget.dart';
import 'package:movie_app/core/widgets/loader.dart';
import 'package:movie_app/features/home/presentation/controllers/movies_controller.dart';
import 'package:movie_app/features/home/presentation/controllers/tv_series_controller.dart';
import 'package:movie_app/features/home/presentation/widgets/movie_item_widget.dart';
import 'package:movie_app/features/home/presentation/widgets/tv_series_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesController = Get.put(MoviesController());
    final tvSeriesController = Get.put(TvSeriesController());
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Movie App',
        leading: SizedBox.shrink(),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.wait([
            moviesController.fetchMovies(),
            tvSeriesController.fetchTvListGenres(),
            tvSeriesController.fetchTvSeries(),
          ]);
        },
        child: SingleChildScrollView(
          child: Obx(() {
            if (moviesController.isLoading.value) {
              return Center(
                  child: LoadingFadingCircle(
                color: Get.theme.colorScheme.primary,
              ));
            }
            final movieList = moviesController.movies;
            final tvSeriesList = tvSeriesController.tvSeriesList;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.h,
              children: [
                // the reason here I used 2 padding instead of one in the single child scroll view
                // so when the user scrolls, the listview builder items don't get cropped under the
                // global padding

                if (movieList.isEmpty) ...{
                  const Center(
                      child: CustomTextWidget(text: 'No movies found')),
                } else ...{
                  Padding(
                    padding: UIConstants.horizontalPadding,
                    child: CustomTextWidget(text: "Movies"),
                  ),
                  SizedBox(
                    height: 310.h,
                    child: ListView.builder(
                      padding: UIConstants.horizontalPadding,
                      scrollDirection: Axis.horizontal,
                      itemCount: movieList.length,
                      itemBuilder: (context, index) {
                        final movie = movieList[index];
                        return MovieItemWidget(movie: movie);
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                },
                if (tvSeriesList.isEmpty) ...{
                  const Center(
                      child: CustomTextWidget(text: 'No movies found')),
                } else ...{
                  Padding(
                    padding: UIConstants.horizontalPadding,
                    child: CustomTextWidget(text: "TV Shows"),
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
                    padding: UIConstants.horizontalPadding,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tvSeriesList.length,
                    itemBuilder: (context, index) {
                      final tvSeries = tvSeriesList[index];
                      return TvSeriesItemWidget(tvSeries: tvSeries);
                    },
                  ),
                },
              ],
            );
          }),
        ),
      ),
    );
  }
}
