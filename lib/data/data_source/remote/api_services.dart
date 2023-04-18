import 'dart:io';

import 'package:cubit_tutorial/core/exception_handling/exceptions.dart';
import 'package:cubit_tutorial/data/models/character_model.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../../core/constants/strings.dart';
import '../../../core/exception_handling/error_object.dart';

class ApiServices {
  late Dio dio;

  ApiServices() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        receiveDataWhenStatusError: true);
    dio = Dio(options);
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<List<CharacterModel>> getAllCharacters() async {
    try {
      Response response = await dio.get(allCharactersEndPoint);
      if (response.statusCode == 200) {
        try {
          return List<CharacterModel>.from(response.data['results']
              .map((element) => CharacterModel.fromJson(element)));
        } on Exception {
          throw DataParsingException(ErrorObject(
            statusCode: response.statusCode!,
            message: response.statusMessage!,
          ));
        }
      } else {
        throw ServerException(ErrorObject(
          message: response.statusMessage!,
          statusCode: response.statusCode!,
        ));
      }
    } catch (e) {
      rethrow;
      // else {
      //   debugPrint(e.toString());
      //   throw NoConnectionException(
      //     ErrorObject(
      //       statusCode: 0,
      //       message:
      //           "No Internet Connection , Please check your Connectivity !!",
      //     ),
      //   );
      // }
    }
  }
}
