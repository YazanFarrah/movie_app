import 'package:movie_app/core/network/network_controller.dart';
import 'package:movie_app/core/services/hive_services.dart';
import 'package:get/get.dart';
import 'package:movie_app/features/profile/presentation/controllers/saved_movies_controller.dart';
import 'package:movie_app/features/profile/presentation/controllers/saved_tv_series_controller.dart';
import 'package:movie_app/features/shared/data/datasources/shared_local_datasource.dart';
import 'package:movie_app/features/shared/presentation/controllers/bottom_nav_bar_controller.dart';
import 'package:movie_app/features/shared/presentation/controllers/current_user_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<HiveServices>(HiveServices(), permanent: true);

    Get.put<NetworkController>(NetworkController(), permanent: true);

    Get.put<BottomNavController>(BottomNavController(), permanent: true);

    Get.put<SharedLocalDatasource>(SharedLocalDatasource(), permanent: true);

    Get.put<CurrentUserController>(CurrentUserController(), permanent: true);

    Get.put<SavedMoviesController>(SavedMoviesController(), permanent: true);

    Get.put<SavedTvSeriesController>(SavedTvSeriesController(), permanent: true);
  }
}
