import 'package:cubit_tutorial/core/exception_handling/error_object.dart';

abstract class Failure {
  final ErrorObject errorObject;

  Failure(this.errorObject);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorObject);
}

class DataParsingFailure extends Failure {
  DataParsingFailure(super.errorObject);
}

// class NoConnectionFailure extends Failure {
//   NoConnectionFailure(super.errorObject);
// }
