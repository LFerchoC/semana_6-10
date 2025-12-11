// To parse this JSON data:
//
//     final character = characterFromJson(jsonString);

import 'dart:convert';

Character characterFromJson(String str) =>
    Character.fromJson(json.decode(str));

String characterToJson(Character data) => json.encode(data.toJson());

// ─────────────────────────────────────────────────────────────
// MODEL: CHARACTER
// ─────────────────────────────────────────────────────────────
class Character {
  int? id;
  dynamic age;
  dynamic birthdate;
  String description;
  int? firstAppearanceEpId;
  int? firstAppearanceShId;
  String gender;
  String name;
  String occupation;

  String portraitPath;
  String status;

  FirstAppearance? firstAppearanceEp;
  FirstAppearance? firstAppearanceSh;

  Character({
    this.id,
    this.age,
    this.birthdate,
    this.description = '',
    this.firstAppearanceEpId,
    this.firstAppearanceShId,
    this.gender = '',
    this.name = '',
    this.occupation = '',
    this.portraitPath = '',
    this.status = '',
    this.firstAppearanceEp,
    this.firstAppearanceSh,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        age: json["age"],
        birthdate: json["birthdate"],
        description: json["description"] ?? '',
        firstAppearanceEpId: json["first_appearance_ep_id"],
        firstAppearanceShId: json["first_appearance_sh_id"],
        gender: json["gender"] ?? '',
        name: json["name"] ?? '',
        occupation: json["occupation"] ?? '',
        portraitPath: json["portrait_path"] ?? '',
        status: json["status"] ?? '',

        // Si viene null, no llamamos a fromJson
        firstAppearanceEp: json["first_appearance_ep"] == null
            ? null
            : FirstAppearance.fromJson(json["first_appearance_ep"]),

        firstAppearanceSh: json["first_appearance_sh"] == null
            ? null
            : FirstAppearance.fromJson(json["first_appearance_sh"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "age": age,
        "birthdate": birthdate,
        "description": description,
        "first_appearance_ep_id": firstAppearanceEpId,
        "first_appearance_sh_id": firstAppearanceShId,
        "gender": gender,
        "name": name,
        "occupation": occupation,
        "portrait_path": portraitPath,
        "status": status,

        // Solo enviamos si NO es null
        "first_appearance_ep": firstAppearanceEp?.toJson(),
        "first_appearance_sh": firstAppearanceSh?.toJson(),
      };
}

// ─────────────────────────────────────────────────────────────
// MODEL: FIRST APPEARANCE
// ─────────────────────────────────────────────────────────────
class FirstAppearance {
  int id;
  DateTime? airdate;
  String description;
  int episodeNumber;
  String imagePath;
  String name;
  int season;
  String synopsis;

  FirstAppearance({
    required this.id,
    required this.airdate,
    required this.description,
    required this.episodeNumber,
    required this.imagePath,
    required this.name,
    required this.season,
    required this.synopsis,
  });

  factory FirstAppearance.fromJson(Map<String, dynamic> json) => FirstAppearance(
        id: json["id"] ?? 0,
        airdate: json["airdate"] == null
            ? null
            : DateTime.tryParse(json["airdate"]),
        description: json["description"] ?? '',
        episodeNumber: json["episode_number"] ?? 0,
        imagePath: json["image_path"] ?? '',
        name: json["name"] ?? '',
        season: json["season"] ?? 0,
        synopsis: json["synopsis"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "airdate": airdate?.toIso8601String(),
        "description": description,
        "episode_number": episodeNumber,
        "image_path": imagePath,
        "name": name,
        "season": season,
        "synopsis": synopsis,
      };
}
