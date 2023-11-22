import 'package:poke_list/models/all.dart';
import 'package:poke_list/models/pokemon_team_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonCache {
  Future<void> addToList({
    required PokemonTeamElementModel pokemon,
    required String url,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      url,
      pokemonTeamElementModelToJson(
        pokemon,
      ),
    );
  }

  Future<PokemonTeamElementModel?> getDetails({
    required String url,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(url);
    if (data == null) {
      return null;
    }
    return pokemonTeamElementModelFromJson(data);
  }

  Future<void> updateTeam({
    required PokemonTeam pokemonTeam,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('team', pokemonTeamToJson(pokemonTeam));
  }

  Future<PokemonTeam> getTeam() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('team');
    if (data == null) {
      return PokemonTeam(
        pokemons: [],
      );
    }
    return pokemonTeamFromJson(
      data,
    );
  }
}
