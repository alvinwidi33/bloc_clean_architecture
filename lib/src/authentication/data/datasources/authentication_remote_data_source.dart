import 'dart:convert';

import 'package:bloc_clean_architecture/core/errors/exceptions.dart';
import 'package:bloc_clean_architecture/core/utils/constants.dart';
import 'package:bloc_clean_architecture/core/utils/typedef.dart';
import 'package:bloc_clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = '/users';
const kGetUserEndpoint = '/users';

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImpl(this._client);
  final http.Client _client;
  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          'avatar': avatar,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.parse('$kBaseUrl$kGetUserEndpoint'),
      );
      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return List<DataMap>.from(
        jsonDecode(response.body) as List
      ).map((userData) => UserModel.fromMap(userData)).toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
