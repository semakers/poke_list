import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:poke_list/cache/pokemon_cache.dart';
import 'package:poke_list/models/all.dart';
import 'package:poke_list/services/pokemon_services.dart';

/*enum PokemonRequestStatus {
  succes,
  fail,
  none,
}*/

class HomeController extends GetxController {
  final PokemonServices services = PokemonServices();
  final PokemonCache cache = PokemonCache();

  final ScrollController scrollController = ScrollController();

  final RxList<PokemonTeamElementModel> pokemonsList =
      <PokemonTeamElementModel>[].obs;
  PokemonListFragmentModel? _lastFragment;

  Future<void> loadMore() async {
    try {
      final auxList = <PokemonTeamElementModel>[];
      _lastFragment = await services.getlistFragment(
        url: _lastFragment?.next,
      );
      for (var overview in _lastFragment!.results) {
        PokemonTeamElementModel? element =
            await cache.getDetails(url: overview.url);
        if (element == null) {
          element = PokemonTeamElementModel(
            name: overview.name,
            details: await services.getDetails(
              url: overview.url,
            ),
          );
          cache.addToList(
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
