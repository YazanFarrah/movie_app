
class SpokenLanguage {
  final String? englishName;
  final String? iso6391;
  final String? name;

  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'] as String?,
      iso6391: json['iso_639_1'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'english_name': englishName,
      'iso_639_1': iso6391,
      'name': name,
    };
  }
}
