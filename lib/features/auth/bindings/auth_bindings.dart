import 'package:get/get.dart';
import 'package:movie_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:movie_app/features/auth/presentation/controllers/auth_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() => [
        Get.lazyPut<AuthController>(() => AuthController()),
        Get.lazyPut<AuthLocalDatasource>(() => AuthLocalDatasource()),
      ];
}
