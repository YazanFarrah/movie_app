import 'package:movie_app/config/json_constants.dart';

class UserModel {
  final int id;
  final String? name;
  final String? token;

  UserModel({
    required this.id,
    this.name,
    this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      UserJsonConstants.id: id,
      UserJsonConstants.name: name,
    };
  }
}
