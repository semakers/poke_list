import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_list/models/all.dart';
import 'package:poke_list/pages/home/home_controller.dart';

part 'pokemon_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final scrollController = ScrollController();
    initEndLess(
      scrollController: scrollController,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Intercambio Pokémon'),
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
                  itemCount: homeController.pokemonsList.length + 1,
                  itemBuilder: (context, index) {
                    return index == homeController.pokemonsList.length
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _PokemonCard(
                            pokemon: homeController.pokemonsList[index],
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
    final homeController = Get.find<HomeController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      while (scrollController.position.maxScrollExtent == 0) {
        await homeController.loadMore();
      }
      scrollController.addListener(() async {
        if (scrollController.position.atEdge) {
          bool isBottom = scrollController.position.pixels != 0;
          if (isBottom) {
            await homeController.loadMore();
          }
        }
      });
    });
  }
}
