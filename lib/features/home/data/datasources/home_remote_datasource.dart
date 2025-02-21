import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:movie_app/config/api_paths.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/core/errors/strings.dart';
import 'package:movie_app/core/network/network_mixin.dart';
import 'package:movie_app/core/services/api_response_handler.dart';
import 'package:movie_app/core/services/api_services.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/data/models/tv_series_model.dart';
import 'package:movie_app/features/shared/data/models/genre_model.dart';

class HomeRemoteDatasource with NetworkMixin {
  Future<Either<Failure, List<Movie>>> fetchMovies() async {
    try {
      if (!await isConnected) {
        return left(NetworkFailure(noInternetConnection));
      }

      final res = await RestApiService.get(ApiPaths.fetchDiscoverMovies);

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

  Future<Either<Failure, List<TvSeriesModel>>> fetchTvSeries() async {
    try {
      final res = await RestApiService.get(ApiPaths.fetchDiscoverTvSeries);

      return ApiResponseHandler.handleListResponse(
        res,
        (json) => TvSeriesModel.fromJson(json),
        jsonPath: "results",
      );
    } catch (e) {
      log("ERROR: ${e.toString()}");
      return left(UnknownFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<GenreModel>>> fetchTvListGenres() async {
    try {
      final res = await RestApiService.get(ApiPaths.fetchTvListGenres);

      log("BODY: ${res.body}");

      return ApiResponseHandler.handleListResponse<GenreModel>(
        res,
        (json) => GenreModel.fromJson(json),
        jsonPath: "genres",
      );
    } catch (e) {
      log("ERRPO: ${e.toString()}");
      return left(UnknownFailure(e.toString()));
    }
  }

  Future<Either<Failure, TvSeriesModel>> fetchTvSeriesById(String id) async {
    try {
      final res = await RestApiService.get("${ApiPaths.fetchTvSeriesDetails}/$id");


      return ApiResponseHandler.handleSingleResponse<TvSeriesModel>(
        res,
        (json) => TvSeriesModel.fromJson(json),
      );
    } catch (e) {
      log("ERRPO: ${e.toString()}");
      return left(UnknownFailure(e.toString()));
    }
  }

   Future<Either<Failure, Movie>> fetchMovieById(String id) async {
    try {
      final res = await RestApiService.get("${ApiPaths.fetchMovieDetails}/$id");

      log("RES BODY: ${res.body}");

      return ApiResponseHandler.handleSingleResponse<Movie>(
        res,
        (json) => Movie.fromJson(json),
      );
    } catch (e) {
      log("ERRPO: ${e.toString()}");
      return left(UnknownFailure(e.toString()));
    }
  }
}
