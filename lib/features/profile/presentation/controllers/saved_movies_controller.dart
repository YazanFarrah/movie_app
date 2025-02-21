import 'package:get/get.dart';
import 'package:movie_app/core/services/hive_services.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

class SavedMoviesController extends GetxController {
  final savedMovies = <Movie>[].obs;
  final _hiveServices = Get.find<HiveServices>();

  @override
  void onInit() {
    super.onInit();
    savedMovies.assignAll(_hiveServices.fetchSavedMovies());
  }

  void toggleMovie(Movie movie) {
    if (isSaved(movie)) {
      savedMovies.removeWhere((element) => element.id == movie.id);
      _hiveServices.removeMovieLocally(movie);
    } else {
      savedMovies.add(movie);
      _hiveServices.saveMovieLocally(movie);
    }
  }

  bool isSaved(Movie movie) {
    return savedMovies.any((element) => element.id == movie.id);
  }
}
