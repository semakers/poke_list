import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_list/models/all.dart';
import 'package:poke_list/controller/pokemon_controller.dart';
import 'package:poke_list/pages/my_team/my_team_dialog.dart';
import 'package:poke_list/utils/pokemon_utils.dart';

part 'pokemon_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonController = Get.put(PokemonController());
    final scrollController = ScrollController();
    initEndLess(
      scrollController: scrollController,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Intercambio Pokémon'),
        actions: [
          TextButton(
            onPressed: () {
              const MyTeamDialog().show(context);
            },
            child: const Text(
              'Mi equipo',
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.computer),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    'Selecciona hasta 5 Pokémons para agregarlos a tu equipo',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () {
                return ListView.builder(
                  controller: scrollController,
                  itemCount: pokemonController.pokemonsList.length + 1,
                  itemBuilder: (context, index) {
                    return index == pokemonController.pokemonsList.length
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _PokemonCard(
                            pokemon: pokemonController.pokemonsList[index],
                          );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void initEndLess({
    required ScrollController scrollController,
  }) async {
    final pokemonController = Get.find<PokemonController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      while (scrollController.position.maxScrollExtent == 0) {
        await pokemonController.loadMore();
      }
      scrollController.addListener(() async {
        if (scrollController.position.atEdge) {
          bool isBottom = scrollController.position.pixels != 0;
          if (isBottom) {
            await pokemonController.loadMore();
          }
        }
      });
    });
  }
}
