import 'package:bloc/bloc.dart';
import 'package:cubit_tutorial/core/exception_handling/failures.dart';
import 'package:flutter/material.dart';

import '../../data/models/character_model.dart';
import '../../data/repository/characters_repo.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository repo;
  late List<CharacterModel> characters;

  CharactersCubit(this.repo) : super(CharactersInitial());

  Future<void> fetchAllCharacters() async {
    emit(CharactersStateLoading());
    final result = await repo.fetchAllCharacters();

    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            emit(CharactersStateErrorServer(failure.errorObject.message));
            break;
          // case NoConnectionFailure:
          //   emit(CharactersStateErrorNoConnection(failure.errorObject.message));
          //   break;
          case DataParsingFailure:
            emit(CharactersStateErrorDataParsing(failure.errorObject.message));
            break;
        }
      },
      (characters) {
        this.characters = characters;
        emit(CharactersStateLoaded(characters));
        debugPrint(this.characters.toString());
      },
    );
  }
}
