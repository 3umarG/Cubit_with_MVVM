import 'package:cubit_tutorial/core/exception_handling/exceptions.dart';
import 'package:cubit_tutorial/data/data_source/remote/api_services.dart';
import 'package:cubit_tutorial/data/models/character_model.dart';
import 'package:dartz/dartz.dart';

import '../../core/exception_handling/failures.dart';

class CharactersRepository {
  final ApiServices api;

  CharactersRepository(this.api);

  Future<Either<Failure, List<CharacterModel>>> fetchAllCharacters() async {
    try {
      return Right(await api.getAllCharacters());
    } on DataParsingException catch (e) {
      return Left(DataParsingFailure(e.errorObject));
    } on NoConnectionException catch (e) {
      return Left(NoConnectionFailure(e.errorObject));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorObject));
    }
  }
}
