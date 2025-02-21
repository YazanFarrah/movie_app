import 'dart:developer';

import 'package:get/get.dart';
import 'package:movie_app/core/routes/route_paths.dart';
import 'package:movie_app/core/services/hive_services.dart';
import 'package:movie_app/core/utils/toast_utils.dart';
import 'package:movie_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/shared/presentation/controllers/current_user_controller.dart';

class AuthController extends GetxController {
  final _authLocalDatasource = Get.find<AuthLocalDatasource>();
  final _currentUserController = Get.find<CurrentUserController>();

  final _hiveServices = Get.find<HiveServices>();
  void signup(String name) {
    final user = UserModel(id: 1, name: name.trim());
    final res = _authLocalDatasource.signup(user);

    res.fold((l) {
      ToastUtils.showError(l.message);
    }, (r) {
      log("Token: ${r.token}");
      _hiveServices.setToken(r.token);
      _currentUserController.setUser(r);
      Get.toNamed(RoutePaths.navScreen);
    });
  }
}
