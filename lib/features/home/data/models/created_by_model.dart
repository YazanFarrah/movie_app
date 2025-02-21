
class CreatedByModel {
  final int id;
  final String? name;
  final String? originalName;
  final int? gender;
  final String? profilePath;

  CreatedByModel({
    required this.id,
    required this.name,
    required this.originalName,
    this.gender,
    this.profilePath,
  });

  factory CreatedByModel.fromJson(Map<String, dynamic> json) {
    return CreatedByModel(
      id: json["id"],
      name: json["name"] ?? "",
      originalName: json["original_name"] ?? "",
      gender: json["gender"]?? 0,
      profilePath: json["profile_path"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "original_name": originalName,
        "gender": gender,
        "profile_path": profilePath,
      };
}