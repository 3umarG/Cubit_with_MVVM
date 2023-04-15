part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

abstract class CharactersStateError extends CharactersState {
  final String message;

  CharactersStateError(this.message);
}

class CharactersInitial extends CharactersState {}

class CharactersStateLoaded extends CharactersState {
  final List<CharacterModel> characters;

  CharactersStateLoaded(this.characters);
}

class CharactersStateErrorServer extends CharactersStateError {
  CharactersStateErrorServer(super.message);
}

class CharactersStateErrorDataParsing extends CharactersStateError {
  CharactersStateErrorDataParsing(super.message);
}

class CharactersStateErrorNoConnection extends CharactersStateError {
  CharactersStateErrorNoConnection(super.message);
}

class CharactersStateLoading extends CharactersState{}