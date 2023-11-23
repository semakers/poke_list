import 'package:get/state_manager.dart';
import 'package:poke_list/cache/pokemon_cache.dart';
import 'package:poke_list/models/all.dart';
import 'package:poke_list/models/pokemon_team_model.dart';
import 'package:poke_list/services/pokemon_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonController extends GetxController {
  PokemonController({
    SharedPreferences? prefs,
    PokemonServices? services,
  }) : _services = services ?? PokemonServices() {
    if (prefs != null) {
      _cache.prefs = prefs;
      _cache.getTeam().then((myTeam) {
        myTeamList.addAll(myTeam.pokemons);
      });
    } else {
      SharedPreferences.getInstance().then((prefs) {
        _cache.prefs = prefs;
        _cache.getTeam().then((myTeam) {
          myTeamList.addAll(myTeam.pokemons);
        });
      });
    }
  }

  final PokemonServices _services;
  final PokemonCache _cache = PokemonCache();

  final RxList<PokemonTeamElementModel> pokemonsList =
      <PokemonTeamElementModel>[].obs;

  final RxList<PokemonTeamElementModel> myTeamList =
      <PokemonTeamElementModel>[].obs;

  PokemonListFragmentModel? _lastFragment;

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

  Future<void> _load() async {
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
  }

  Future<void> loadMore() async {
    try {
      if (_lastFragment != null) {
        if (_lastFragment!.next != null) {
          await _load();
        }
      } else {
        await _load();
      }
    } catch (_) {}
  }
}
