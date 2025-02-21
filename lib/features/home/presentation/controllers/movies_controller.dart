import 'package:get/get.dart';
import 'package:movie_app/core/utils/toast_utils.dart';
import 'package:movie_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

class MoviesController extends GetxController {
  final isLoading = false.obs;
  final movies = <Movie>[].obs;
  final _homeRemoteDatasource = Get.put<HomeRemoteDatasource>(HomeRemoteDatasource());

  @override
  void onReady() {
    super.onReady();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    isLoading(true);

    final res = await _homeRemoteDatasource.fetchMovies();
    res.fold((l) {
      ToastUtils.showError(l.message);
    }, (r) {
      movies.assignAll(r);
    });

    isLoading(false);
  }
}
