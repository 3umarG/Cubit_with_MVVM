import 'package:cubit_tutorial/core/exception_handling/error_object.dart';

abstract class ApiException implements Exception {
  final ErrorObject errorObject;

  ApiException(this.errorObject);
}

class ServerException extends ApiException {
  ServerException(super.errorObject);
}

class DataParsingException extends ApiException {
  DataParsingException(super.errorObject);
}

// class NoConnectionException extends ApiException {
//   NoConnectionException(super.errorObject);
// }
