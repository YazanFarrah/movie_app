import 'dart:developer';
import 'package:get/get.dart';
import 'package:movie_app/core/routes/route_paths.dart';
import 'package:movie_app/core/services/hive_services.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/shared/data/datasources/shared_local_datasource.dart';

class CurrentUserController extends GetxController {
  final user = Rxn<UserModel>();
  final _hiveService = Get.find<HiveServices>();
  final _sharedLocalDatasource = Get.find<SharedLocalDatasource>();

  void setUser(UserModel user) {
    this.user.value = user;
    log(this.user.toString());
  }

  Future<void> getUser() async {
    final res = _sharedLocalDatasource.fetchUser();
    res.fold((l) {
      log("Error: ${l.message}");
      Get.offAllNamed(RoutePaths.signup);
    }, (r) {
      setUser(r);
    });
  }

  void logUserOut() {
    _hiveService.clearPreferences();
    user.value = null;
    Get.offAllNamed(RoutePaths.signup);
  }
}
