import 'dart:convert';
import 'package:movie_app/features/home/data/models/created_by_model.dart';
import 'package:movie_app/features/shared/data/models/genre_model.dart';

class TvSeriesModel {
  final int id;
  final String? name;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final int? voteCount;
  final double? popularity;
  final List<int>? genreIds;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? firstAirDate;
  final bool? adult;
  final List<GenreModel>? genreList;

  final List<CreatedByModel>? createdBy;
  final int? numberOfSeasons;
  final int? numberOfEpisodes;
  final String? homepage;

  TvSeriesModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.genreIds,
    required this.originCountry,
    required this.originalLanguage,
    required this.firstAirDate,
    required this.adult,
    this.genreList,
    this.createdBy,
    this.numberOfSeasons,
    this.numberOfEpisodes,
    this.homepage,
  });

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) {
    return TvSeriesModel(
      id: json["id"],
      name: json["name"] ?? "",
      originalName: json["original_name"] ?? "",
      overview: json["overview"] ?? "",
      posterPath: json["poster_path"] ?? "",
      backdropPath: json["backdrop_path"] ?? "",
      voteAverage: (json["vote_average"] ?? 0).toDouble(),
      voteCount: json["vote_count"] ?? 0,
      popularity: (json["popularity"] ?? 0).toDouble(),
      genreIds: List<int>.from(json["genre_ids"] ?? []),
      originCountry: List<String>.from(json["origin_country"] ?? []),
      originalLanguage: json["original_language"] ?? "",
      firstAirDate: json["first_air_date"] ?? "",
      adult: json["adult"] ?? false,
      createdBy: (json["created_by"] as List?)
          ?.map((e) => CreatedByModel.fromJson(e))
          .toList(),
      numberOfSeasons: json["number_of_seasons"]?? 0,
      numberOfEpisodes: json["number_of_episodes"]?? 0,
      homepage: json["homepage"]?? "",
    );
  }

  static List<TvSeriesModel> listFromJson(String str) {
    final jsonData = json.decode(str);
    return List<TvSeriesModel>.from(
      jsonData.map((x) => TvSeriesModel.fromJson(x)),
    );
  }

  TvSeriesModel copyWith({
    int? id,
    String? name,
    String? originalName,
    String? overview,
    String? posterPath,
    String? backdropPath,
    double? voteAverage,
    int? voteCount,
    double? popularity,
    List<int>? genreIds,
    List<String>? originCountry,
    String? originalLanguage,
    String? firstAirDate,
    bool? adult,
    List<GenreModel>? genreList,
    List<CreatedByModel>? createdBy,
    int? numberOfSeasons,
    int? numberOfEpisodes,
    String? homepage,
  }) {
    return TvSeriesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      popularity: popularity ?? this.popularity,
      genreIds: genreIds ?? this.genreIds,
      originCountry: originCountry ?? this.originCountry,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      adult: adult ?? this.adult,
      genreList: genreList ?? this.genreList,
      createdBy: createdBy ?? this.createdBy,
      numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
      numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
      homepage: homepage ?? this.homepage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "original_name": originalName,
      "overview": overview,
      "poster_path": posterPath,
      "backdrop_path": backdropPath,
      "vote_average": voteAverage,
      "vote_count": voteCount,
      "popularity": popularity,
      "genre_ids": genreIds,
      "origin_country": originCountry,
      "original_language": originalLanguage,
      "first_air_date": firstAirDate,
      "adult": adult,
      "genre_list": genreList?.map((genre) => genre.toJson()).toList(),
      "created_by": createdBy?.map((creator) => creator.toJson()).toList(),
      "number_of_seasons": numberOfSeasons,
      "number_of_episodes": numberOfEpisodes,
      "homepage": homepage,
    };
  }
}
