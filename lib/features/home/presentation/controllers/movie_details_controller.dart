import 'package:get/get.dart';
import 'package:movie_app/core/utils/toast_utils.dart';
import 'package:movie_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

class MovieDetailsController extends GetxController {
  final isLoading = false.obs;
  final movie = Rxn<Movie>();
  final _homeRemoteDatasource = Get.find<HomeRemoteDatasource>();

  Future<void> fetchMovieDetails(int movieId) async {
    isLoading(true);

    final res = await _homeRemoteDatasource.fetchMovieById(movieId.toString());
    res.fold((l) {
      ToastUtils.showError(l.message);
    }, (r) {
      movie.value = r;
    });

    isLoading(false);
  }
}
