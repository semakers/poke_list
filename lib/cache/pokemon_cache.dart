import 'package:poke_list/models/all.dart';
import 'package:poke_list/models/pokemon_team_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonCache {
  late SharedPreferences _prefs;

  set prefs(SharedPreferences prefs) {
    _prefs = prefs;
  }

  Future<void> addToList({
    required PokemonTeamElementModel pokemon,
    required String url,
  }) async {
    await _prefs.setString(
      url,
      pokemonTeamElementModelToJson(
        pokemon,
      ),
    );
  }

  Future<PokemonTeamElementModel?> getDetails({
    required String url,
  }) async {
    final String? data = _prefs.getString(url);
    if (data == null) {
      return null;
    }
    return pokemonTeamElementModelFromJson(data);
  }

  Future<void> updateTeam({
    required PokemonTeam pokemonTeam,
  }) async {
    await _prefs.setString('team', pokemonTeamToJson(pokemonTeam));
  }

  Future<PokemonTeam> getTeam() async {
    final String? data = _prefs.getString('team');
    if (data == null) {
      return PokemonTeam(
        pokemons: [],
      );
    }
    return pokemonTeamFromJson(
      data,
    );
  }

  static final PokemonCache _pokemonCache = PokemonCache._internal();

  factory PokemonCache() {
    return _pokemonCache;
  }

  PokemonCache._internal();
}
