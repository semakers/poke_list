part of 'my_team_dialog.dart';

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
                    width: 100,
                    height: 75,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Image.network(
                      pokemon.details.sprites.frontDefault,
                    ),
                  ),
                  Expanded(
                      child: Center(
                    child: Text(
                      pokemon.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              ElevatedButton(
                onPressed: () {
                  pokemonController.removeFromMyTeam(
                    pokemon: pokemon,
                  );
                },
                child: const Text(
                  'Eliminar de mi equipo',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
