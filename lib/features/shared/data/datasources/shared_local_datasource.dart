import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/core/services/hive_services.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';

class SharedLocalDatasource extends GetxController {
  final _hiveServices = Get.find<HiveServices>();

  Either<Failure, UserModel> fetchUser() {
    try {
      final user = _hiveServices.fetchUserData();
      if (user != null) {
        return right(user);
      }
      return left(AuthFailure("Please enter your name to continue"));
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }
}
