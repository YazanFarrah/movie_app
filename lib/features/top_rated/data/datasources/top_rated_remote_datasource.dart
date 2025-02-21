import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:movie_app/config/api_paths.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/core/errors/strings.dart';
import 'package:movie_app/core/network/network_mixin.dart';
import 'package:movie_app/core/services/api_response_handler.dart';
import 'package:movie_app/core/services/api_services.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

class TopRatedRemoteDatasource with NetworkMixin {
  Future<Either<Failure, List<Movie>>> fetchMovies() async {
    try {
      if (!await isConnected) {
        return left(NetworkFailure(noInternetConnection));
      }

      final res = await RestApiService.get(ApiPaths.fetchTopRatedMovies);

      return ApiResponseHandler.handleListResponse(
        res,
        (json) => Movie.fromJson(json),
        jsonPath: "results",
      );
    } catch (e) {
      log("ERROR: ${e.toString()}");
      return left(UnknownFailure(e.toString()));
    }
  }
}
