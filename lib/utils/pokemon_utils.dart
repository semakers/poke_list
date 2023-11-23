import 'package:flutter/material.dart';

class PokemonUtils {
  Color stringToColor(String inputString) {
    int sum = 0;
    for (int i = 0; i < inputString.length; i++) {
      sum += inputString.codeUnitAt(i);
    }

    int hexColorValue = sum % 0xFFFFFF;

    Color color = Color(hexColorValue | 0xFF000000);
    return color.withAlpha(180);
  }

  static final PokemonUtils _pokemonUtils = PokemonUtils._internal();

  factory PokemonUtils() {
    return _pokemonUtils;
  }

  PokemonUtils._internal();
}
