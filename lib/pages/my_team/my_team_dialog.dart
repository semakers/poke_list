import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_list/models/all.dart';
import 'package:poke_list/controller/pokemon_controller.dart';

part 'pokemon_card.dart';

class MyTeamDialog extends StatelessWidget {
  const MyTeamDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonController = Get.find<PokemonController>();
    return Dialog(
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (pokemonController.myTeamList.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 16.0,
                    ),
                    child: Text(
                      'No tienes Pokémons en tu equipo',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                else
                  ...pokemonController.myTeamList.map(
                    (pokemon) => _PokemonCard(
                      pokemon: pokemon,
                    ),
                  ),
                const SizedBox(
                  height: 32.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cerrar'),
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> show(BuildContext context) async {
    await showDialog(context: context, builder: (context) => this);
  }
}
