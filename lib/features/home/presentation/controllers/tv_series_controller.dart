import 'package:get/get.dart';
import 'package:movie_app/core/utils/toast_utils.dart';
import 'package:movie_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:movie_app/features/home/data/models/tv_series_model.dart';
import 'package:movie_app/features/shared/data/models/genre_model.dart';

class TvSeriesController extends GetxController {
  final isLoading = false.obs;
  final tvSeriesList = <TvSeriesModel>[].obs;
  final tvSeriesGenreList = <GenreModel>[].obs;
  final _homeRemoteDatasource =
      Get.put<HomeRemoteDatasource>(HomeRemoteDatasource());

  @override
  void onReady() async {
    super.onReady();
    await fetchTvListGenres().then((_) => fetchTvSeries()).catchError((_) {
      fetchTvSeries();
    });
  }

  Future<void> fetchTvListGenres() async {
    isLoading(true);

    final res = await _homeRemoteDatasource.fetchTvListGenres();
    res.fold((l) {
      ToastUtils.showError(l.message);
    }, (r) {
      tvSeriesGenreList.assignAll(r);
    });

    isLoading(false);
  }

  Future<void> fetchTvSeries() async {
    isLoading(true);

    final res = await _homeRemoteDatasource.fetchTvSeries();
    res.fold((l) {
      ToastUtils.showError(l.message);
    }, (r) {
      // Map genre IDs to actual genre names
      final updatedTvSeries = r.map((tvSeries) {
        final genres = tvSeries.genreIds
            ?.map((id) {
              return tvSeriesGenreList
                  .firstWhereOrNull((genre) => genre.id == id);
            })
            .whereType<GenreModel>()
            .toList();

        return tvSeries.copyWith(genreList: genres);
      }).toList();

      tvSeriesList.assignAll(updatedTvSeries);
    });

    isLoading(false);
  }
  
}
