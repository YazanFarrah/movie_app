import 'package:fpdart/fpdart.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';

class AuthLocalDatasource {
// didn't use future because put method because there are no async operations here.
  Either<Failure, UserModel> signup(UserModel user) {
    try {
      return right(UserModel(id: user.id, name: user.name, token: "USerT0K3N"));
    } catch (e) {
      return left(UnknownFailure());
    }
  }
}
