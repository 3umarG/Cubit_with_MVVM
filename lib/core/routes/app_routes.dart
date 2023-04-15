import 'package:cubit_tutorial/core/constants/strings.dart';
import 'package:cubit_tutorial/presentation/screens/all_characters_screen.dart';
import 'package:cubit_tutorial/presentation/screens/character_details.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case allCharactersScreenRoute:
        return MaterialPageRoute(builder: (_) => const AllCharactersScreen());
      case characterDetailsScreenRoute:
        return MaterialPageRoute(builder: (_) => const CharacterDetailsScreen());
      default:
        return null;
    }
  }
}
