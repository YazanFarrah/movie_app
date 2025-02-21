import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/utils/shared.dart';
import 'package:movie_app/core/widgets/custom_appbar.dart';
import 'package:movie_app/core/widgets/custom_text_widget.dart';
import 'package:movie_app/core/widgets/loader.dart';
import 'package:movie_app/features/top_rated/presentation/controllers/top_rated_controller.dart';
import 'package:movie_app/features/top_rated/presentation/widgets/top_rated_movie_item_widget.dart';

class TopRatedScreen extends StatelessWidget {
  const TopRatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topRatedController = Get.put(TopRatedController());
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Top rated',
        leading: SizedBox.shrink(),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => topRatedController.fetchTopRatedMovies(),
        child: SingleChildScrollView(
          child: Obx(() {
            if (topRatedController.isLoading.value) {
              return Center(
                  child: LoadingFadingCircle(
                color: Get.theme.colorScheme.primary,
              ));
            }
            final movieList = topRatedController.topRatedMovies;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.h,
              children: [
                if (movieList.isEmpty) ...{
                  const Center(
                      child: CustomTextWidget(text: 'No movies found')),
                } else ...{
                  Padding(
                    padding: UIConstants.horizontalPadding,
                    child: CustomTextWidget(text: "Movies"),
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
                    padding: UIConstants.horizontalPadding,
                    itemCount: movieList.length,
                    itemBuilder: (context, index) {
                      final movie = movieList[index];
                      return TopRatedMovieItemWidget(movie: movie);
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
