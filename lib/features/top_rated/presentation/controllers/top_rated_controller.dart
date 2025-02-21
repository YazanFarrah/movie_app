import 'package:get/get.dart';
import 'package:movie_app/core/utils/toast_utils.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/top_rated/data/datasources/top_rated_remote_datasource.dart';

class TopRatedController extends GetxController {
  final topRatedMovies = <Movie>[].obs;
  final isLoading = false.obs;
  final _topRatedRemoteDatasource = Get.put(TopRatedRemoteDatasource());

  @override
  void onReady() {
    super.onReady();
    fetchTopRatedMovies();
  }

  Future<void> fetchTopRatedMovies() async {
    isLoading(true);
    final res = await _topRatedRemoteDatasource.fetchMovies();
    res.fold((l) {
      ToastUtils.showError(l.message);
    }, (r) {
      topRatedMovies.assignAll(r);
    });
    isLoading(false);
  }
}
