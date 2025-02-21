import 'package:movie_app/features/home/data/models/production_company_model.dart';
import 'package:movie_app/features/home/data/models/spoken_language_model.dart';

class Movie {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final String? tagline;
  final List<ProductionCompany>? productionCompanies;
  final String? homepage;
  final int? runtime;
  final int? budget;
  final List<String>? originCountry;
  final List<SpokenLanguage>? spokenLanguages;

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.tagline,
    this.productionCompanies,
    this.homepage,
    this.runtime,
    this.budget,
    this.originCountry,
    this.spokenLanguages,
  });

  factory Movie.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Movie();
    }
    return Movie(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList(),
      id: json['id'] as int?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      tagline: json['tagline'] as String?,
      productionCompanies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'] as String?,
      runtime: json['runtime'] as int?,
      budget: json['budget'] as int?,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
          ?.map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'tagline': tagline,
      'production_companies': productionCompanies?.map((e) => e.toJson()).toList(),
      'homepage': homepage,
      'runtime': runtime,
      'budget': budget,
      'origin_country': originCountry,
      'spoken_languages': spokenLanguages?.map((e) => e.toJson()).toList(),
    };
  }
}
