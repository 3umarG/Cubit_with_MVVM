import 'package:cubit_tutorial/business/cubit/characters_cubit.dart';
import 'package:cubit_tutorial/core/constants/strings.dart';
import 'package:cubit_tutorial/data/data_source/remote/api_services.dart';
import 'package:cubit_tutorial/data/models/character_model.dart';
import 'package:cubit_tutorial/data/repository/characters_repo.dart';
import 'package:cubit_tutorial/presentation/screens/all_characters_screen.dart';
import 'package:cubit_tutorial/presentation/screens/character_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersCubit charactersCubit;
  late CharactersRepository charactersRepository;

  AppRouter() {
    charactersRepository = CharactersRepository(ApiServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case allCharactersScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => charactersCubit,
            child: const AllCharactersScreen(),
          ),
        );
      case characterDetailsScreenRoute:
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(
                  character: character,
                ));
      default:
        return null;
    }
  }
}
