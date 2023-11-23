part of 'home_page.dart';

class _PokemonCard extends StatelessWidget {
  const _PokemonCard({
    Key? key,
    required this.pokemon,
  }) : super(
          key: key,
        );

  final PokemonTeamElementModel pokemon;

  @override
  Widget build(BuildContext context) {
    final pokemonController = Get.find<PokemonController>();
    return Padding(
      padding: const EdgeInsets.only(
        right: 16.0,
        left: 16.0,
        bottom: 8.0,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Image.network(
                      pokemon.details.sprites.frontDefault,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Nombre: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Text(pokemon.name),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        'Tipo:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: pokemon.details.types
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8.0,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: PokemonUtils().stringToColor(
                                        e.type.name,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        8.0,
                                      ),
                                    ),
                                    child: Text(
                                      e.type.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Obx(() {
                  return pokemonController.myTeamList.length < 5
                      ? ElevatedButton(
                          onPressed: () {
                            pokemonController.addToMyTeam(pokemon: pokemon);
                          },
                          child: const Text(
                            'Agregar a mi equipo',
                          ),
                        )
                      : const Text(
                          'Tu equipo está completo',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
