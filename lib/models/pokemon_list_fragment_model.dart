import 'dart:convert';

PokemonListFragmentModel pokemonListFragmentModelFromJson(String str) =>
    PokemonListFragmentModel.fromJson(json.decode(str));

String pokemonListFragmentModelToJson(PokemonListFragmentModel data) =>
    json.encode(data.toJson());

class PokemonListFragmentModel {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonOverview> results;

  PokemonListFragmentModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokemonListFragmentModel.fromJson(Map<String, dynamic> json) =>
      PokemonListFragmentModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<PokemonOverview>.from(
          json["results"].map(
            (x) => PokemonOverview.fromJson(
              x,
            ),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class PokemonOverview {
  final String name;
  final String url;

  PokemonOverview({
    required this.name,
    required this.url,
  });

  factory PokemonOverview.fromJson(Map<String, dynamic> json) =>
      PokemonOverview(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
