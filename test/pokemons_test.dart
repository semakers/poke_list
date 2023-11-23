import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_list/controller/pokemon_controller.dart';
import 'package:poke_list/models/all.dart';
import 'package:poke_list/services/pokemon_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<PokemonServices>()])
import 'pokemons_test.mocks.dart';

void main() {
  group('PokemonController Tests', () {
    late PokemonController pokemonController;
    SharedPreferences.setMockInitialValues({});

    test('Loading more pokemons', () async {
      final prefs = await SharedPreferences.getInstance();
      final services = MockPokemonServices();

      when(services.getlistFragment()).thenAnswer((_) async {
        return PokemonListFragmentModel(
            count: 100,
            next: '',
            previous: '',
            results: [
              PokemonOverview(
                name: 'bulbasaur',
                url: 'https://pokeapi.co/api/v2/pokemon/1/',
              ),
            ]);
      });

      when(
        services.getDetails(
          url: 'https://pokeapi.co/api/v2/pokemon/1/',
        ),
      ).thenAnswer((_) async {
        return PokemonDetailsModel(
            sprites: Sprites(frontDefault: ''), types: []);
      });

      pokemonController = PokemonController(
        prefs: prefs,
        services: services,
      );
      await pokemonController.loadMore();

      expect(
        pokemonController.pokemonsList,
        isNotEmpty,
      );
    });
  });
}
