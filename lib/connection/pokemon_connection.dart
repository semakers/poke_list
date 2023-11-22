import 'package:dio/dio.dart';

class PokemonConnection {
  static final PokemonConnection _pokemonConnection =
      PokemonConnection._internal();
  final client = Dio();

  factory PokemonConnection() {
    return _pokemonConnection;
  }

  PokemonConnection._internal();
}
