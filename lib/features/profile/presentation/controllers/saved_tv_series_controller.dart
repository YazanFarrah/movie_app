import 'package:get/get.dart';
import 'package:movie_app/core/services/hive_services.dart';
import 'package:movie_app/features/home/data/models/tv_series_model.dart';

class SavedTvSeriesController extends GetxController {
  final savedTvSeries = <TvSeriesModel>[].obs;
  final _hiveServices = Get.find<HiveServices>();

  @override
  void onInit() {
    super.onInit();
    savedTvSeries.assignAll(_hiveServices.fetchSavedTvSeries());
  }

  void toggleTvSeries(TvSeriesModel tvSeries) {
    if (isSaved(tvSeries)) {
      savedTvSeries.removeWhere((element) => element.id == tvSeries.id);
      _hiveServices.removeTvSeriesLocally(tvSeries);
    } else {
      savedTvSeries.add(tvSeries);
      _hiveServices.saveTvSeriesLocally(tvSeries);
    }
  }

  bool isSaved(TvSeriesModel tvSeries) {
    return savedTvSeries.any((element) => element.id == tvSeries.id);
  }
}
