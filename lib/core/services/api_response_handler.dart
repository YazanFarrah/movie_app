import 'dart:convert';
import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/shared/presentation/controllers/current_user_controller.dart';

class ApiResponseHandler {
  // Utility function to navigate through nested JSON based on dot-separated keys
  static dynamic _getNestedJsonValue(Map<String, dynamic> json, String path) {
    return path.split('.').fold<dynamic>(json, (prev, key) {
      if (prev == null || prev is! Map<String, dynamic>) {
        return null; // Return null if the current object is not a Map or is null.
      }
      return prev[key]; // Safely access the nested key.
    });
  }

  // Handle a response for a list of items
  static Either<Failure, List<T>> handleListResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson, {
    String? jsonPath,
  }) {
    final int statusCode = response.statusCode;
    final String responseBody = response.body;

    final dynamic resBody = jsonDecode(responseBody);

    if (statusCode >= 200 && statusCode < 300) {
      final data = jsonPath != null && resBody is Map<String, dynamic>
          ? _getNestedJsonValue(resBody, jsonPath) // Handle nested paths
          : resBody;

      if (data is List) {
        final list =
            data.map((item) => fromJson(item as Map<String, dynamic>)).toList();
        return Right(list);
      } else {
        return Left(
            ParsingFailure('Expected a list but received something else'));
      }
    } else if (statusCode >= 400 && statusCode < 500) {
      final errorMessage = resBody is Map<String, dynamic>
          ? resBody['message'] ??
              resBody['error'] ??
              'Validation error occurred'
          : 'Validation error occurred';

      return Left(ValidationFailure(errorMessage));
    } else if (statusCode >= 500 && statusCode < 600) {
      final errorMessage = resBody is Map<String, dynamic>
          ? resBody['message'] ?? resBody['error'] ?? 'Server error occurred'
          : 'Server error occurred';

      return Left(ServerFailure(errorMessage));
    } else {
      final errorMessage = resBody is Map<String, dynamic>
          ? resBody['message'] ??
              resBody['error'] ??
              'An unknown error occurred'
          : 'An unknown error occurred';
      return Left(UnknownFailure(errorMessage));
    }
  }

  // Handle a response for a single item
// Handle a response for a single item
  static Either<Failure, T> handleSingleResponse<T>(
    Response response,
    T Function(Map<String, dynamic>)? fromJson, {
    String? jsonPath,
  }) {
    final int statusCode = response.statusCode;
    final String responseBody = response.body;

    final dynamic resBody = jsonDecode(responseBody);

    if (statusCode >= 200 && statusCode < 300) {
      final data = jsonPath != null && resBody is Map<String, dynamic>
          ? _getNestedJsonValue(resBody, jsonPath) // Handle nested paths
          : resBody;

      if (T == Null || data == null) {
        return Right(null as dynamic); // Treat `void` responses as success
      }

      if (data is Map<String, dynamic> && fromJson != null) {
        final item = fromJson(data);
        return Right(item);
      } else {
        return Left(
          ParsingFailure(
              'Expected a Map<String, dynamic> but received something else or null'),
        );
      }
    } else if (statusCode >= 400 && statusCode < 500) {
      final errorMessage = resBody is Map<String, dynamic>
          ? resBody['message'] ??
              resBody['error'] ??
              'Validation error occurred'
          : 'Validation error occurred';

      log("Error Message: $errorMessage");

      if (resBody['message'].contains("Unauthenticated")) {
        Get.find<CurrentUserController>().logUserOut();
        return Left(AuthFailure(errorMessage));
      }
      return Left(ValidationFailure(errorMessage));
    } else if (statusCode >= 500 && statusCode < 600) {
      final errorMessage = resBody is Map<String, dynamic>
          ? resBody['message'] ?? resBody['error'] ?? 'Server error occurred'
          : 'Server error occurred';
      return Left(ServerFailure(errorMessage));
    } else {
      final errorMessage = resBody is Map<String, dynamic>
          ? resBody['message'] ??
              resBody['error'] ??
              'An unknown error occurred'
          : 'An unknown error occurred';
      return Left(UnknownFailure(errorMessage));
    }
  }

  // Handle a response for a map of lists
  static Either<Failure, Map<String, List<T>>> handleMapResponse<T>(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final int statusCode = response.statusCode;
    final String responseBody = response.body;

    final dynamic resBody = jsonDecode(responseBody);

    if (statusCode >= 200 && statusCode < 300) {
      if (resBody is Map<String, dynamic>) {
        // Convert the Map<String, dynamic> into Map<String, List<T>>
        final map = resBody.map<String, List<T>>((key, value) {
          if (value is List) {
            final list = value
                .map((item) => fromJson(item as Map<String, dynamic>))
                .toList();
            return MapEntry(key, list);
          } else {
            return MapEntry(key, []);
          }
        });

        return Right(map);
      } else {
        return Left(
          ParsingFailure('Expected a map but received something else'),
        );
      }
    } else if (statusCode >= 400 && statusCode < 500) {
      final errorMessage = resBody is Map<String, dynamic>
          ? resBody['message'] ??
              resBody['error'] ??
              'Validation error occurred'
          : 'Validation error occurred';
      return Left(ValidationFailure(errorMessage));
    } else if (statusCode >= 500 && statusCode < 600) {
      final errorMessage = resBody is Map<String, dynamic>
          ? resBody['message'] ?? resBody['error'] ?? 'Server error occurred'
          : 'Server error occurred';
      return Left(ServerFailure(errorMessage));
    } else {
      final errorMessage = resBody is Map<String, dynamic>
          ? resBody['message'] ??
              resBody['error'] ??
              'An unknown error occurred'
          : 'An unknown error occurred';
      return Left(UnknownFailure(errorMessage));
    }
  }
}
