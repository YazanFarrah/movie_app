import 'package:get/get.dart';
import 'package:movie_app/core/utils/toast_utils.dart';
import 'package:movie_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:movie_app/features/home/data/models/tv_series_model.dart';

class TvSeriesDetailsController extends GetxController {
  final isLoading = false.obs;
  final tvSeries = Rxn<TvSeriesModel>();
  final _homeRemoteDatasource = Get.find<HomeRemoteDatasource>();

  Future<void> fetchTvSeriesDetails(int tvSeriesId) async {
    isLoading(true);

    final res =
        await _homeRemoteDatasource.fetchTvSeriesById(tvSeriesId.toString());
    res.fold((l) {
      ToastUtils.showError(l.message);
    }, (r) {
      tvSeries.value = r;
    });

    isLoading(false);
  }
}
