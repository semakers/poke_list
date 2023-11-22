import 'package:poke_list/models/pokemon_details_model.dart';
import 'dart:convert';

PokemonTeamElementModel pokemonTeamElementModelFromJson(String str) =>
    PokemonTeamElementModel.fromJson(json.decode(str));

String pokemonTeamElementModelToJson(PokemonTeamElementModel data) =>
    json.encode(data.toJson());

class PokemonTeamElementModel {
  final String name;
  final PokemonDetailsModel details;

  PokemonTeamElementModel({
    required this.name,
    required this.details,
  });

  factory PokemonTeamElementModel.fromJson(Map<String, dynamic> json) =>
      PokemonTeamElementModel(
        name: json["name"],
        details: PokemonDetailsModel.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "details": details.toJson(),
      };
}
