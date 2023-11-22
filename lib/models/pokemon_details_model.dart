import 'dart:convert';

PokemonDetailsModel pokemonDetailsModelFromJson(String str) =>
    PokemonDetailsModel.fromJson(json.decode(str));

String pokemonDetailsModelToJson(PokemonDetailsModel data) =>
    json.encode(data.toJson());

class PokemonDetailsModel {
  final Sprites sprites;
  final List<TypeElement> types;

  PokemonDetailsModel({
    required this.sprites,
    required this.types,
  });

  factory PokemonDetailsModel.fromJson(Map<String, dynamic> json) =>
      PokemonDetailsModel(
        sprites: Sprites.fromJson(json["sprites"]),
        types: List<TypeElement>.from(
            json["types"].map((x) => TypeElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sprites": sprites.toJson(),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
      };
}

class Sprites {
  final String backDefault;

  Sprites({
    required this.backDefault,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        backDefault: json["back_default"],
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
      };
}

class TypeElement {
  final int slot;
  final TypeDetails type;

  TypeElement({
    required this.slot,
    required this.type,
  });

  factory TypeElement.fromJson(Map<String, dynamic> json) => TypeElement(
        slot: json["slot"],
        type: TypeDetails.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
      };
}

class TypeDetails {
  final String name;
  final String url;

  TypeDetails({
    required this.name,
    required this.url,
  });

  factory TypeDetails.fromJson(Map<String, dynamic> json) => TypeDetails(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
