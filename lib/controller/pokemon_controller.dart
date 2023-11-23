import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:poke_list/cache/pokemon_cache.dart';
import 'package:poke_list/models/all.dart';
import 'package:poke_list/models/pokemon_team_model.dart';
import 'package:poke_list/services/pokemon_services.dart';

/*enum PokemonRequestStatus {
  succes,
  fail,
  none,
}*/

class PokemonController extends GetxController {
  final PokemonServices _services = PokemonServices();
  final PokemonCache _cache = PokemonCache();

  final ScrollController scrollController = ScrollController();

  final RxList<PokemonTeamElementModel> pokemonsList =
      <PokemonTeamElementModel>[].obs;

  final RxList<PokemonTeamElementModel> myTeamList =
      <PokemonTeamElementModel>[].obs;

  PokemonListFragmentModel? _lastFragment;

  PokemonController() {
    _cache.getTeam().then((myTeam) {
      myTeamList.addAll(myTeam.pokemons);
    });
  }

  Future<void> addToMyTeam({
    required PokemonTeamElementModel pokemon,
  }) async {
    final myTeam = await _cache.getTeam();
    myTeam.pokemons.add(pokemon);
    myTeamList.clear();
    myTeamList.addAll(
      myTeam.pokemons,
    );
    await _cache.updateTeam(pokemonTeam: myTeam);
  }

  Future<void> removeFromMyTeam({
    required PokemonTeamElementModel pokemon,
  }) async {
    myTeamList.remove(pokemon);
    await _cache.updateTeam(
      pokemonTeam: PokemonTeam(
        pokemons: myTeamList,
      ),
    );
  }

  Future<void> loadMore() async {
    try {
      final auxList = <PokemonTeamElementModel>[];
      _lastFragment = await _services.getlistFragment(
        url: _lastFragment?.next,
      );
      for (var overview in _lastFragment!.results) {
        PokemonTeamElementModel? element =
            await _cache.getDetails(url: overview.url);
        if (element == null) {
          element = PokemonTeamElementModel(
            name: overview.name,
            details: await _services.getDetails(
              url: overview.url,
            ),
          );
          _cache.addToList(
            pokemon: element,
            url: overview.url,
          );
        }
        auxList.add(element);
      }
      pokemonsList.addAll(auxList);
    } catch (_) {}
  }
}
