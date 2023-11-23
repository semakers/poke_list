import 'package:poke_list/connection/pokemon_connection.dart';
import 'package:poke_list/models/pokemon_details_model.dart';
import 'package:poke_list/models/pokemon_list_fragment_model.dart';

class PokemonServices {
  Future<PokemonListFragmentModel> getlistFragment({
    String? url,
  }) async {
    final response = await PokemonConnection().client.get(
          url ?? 'https://pokeapi.co/api/v2/pokemon?limit=10&offset=0',
        );
    return PokemonListFragmentModel.fromJson(
      response.data,
    );
  }

  Future<PokemonDetailsModel> getDetails({required String url}) async {
    final response = await PokemonConnection().client.get(
          url,
        );
    return PokemonDetailsModel.fromJson(
      response.data,
    );
  }

  static final PokemonServices _pokemonServices = PokemonServices._internal();

  factory PokemonServices() {
    return _pokemonServices;
  }

  PokemonServices._internal();
}
