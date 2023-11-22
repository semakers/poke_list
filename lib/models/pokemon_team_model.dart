import 'dart:convert';

import 'package:poke_list/models/all.dart';

PokemonTeam pokemonTeamFromJson(String str) =>
    PokemonTeam.fromJson(json.decode(str));

String pokemonTeamToJson(PokemonTeam data) => json.encode(data.toJson());

class PokemonTeam {
  final List<PokemonTeamElementModel> pokemons;

  PokemonTeam({
    required this.pokemons,
  });

  factory PokemonTeam.fromJson(Map<String, dynamic> json) => PokemonTeam(
        pokemons: List<PokemonTeamElementModel>.from(
            json["pokemons"].map((x) => PokemonTeamElementModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pokemons": List<dynamic>.from(pokemons.map((x) => x.toJson())),
      };
}
