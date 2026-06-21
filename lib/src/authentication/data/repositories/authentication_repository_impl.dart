import 'package:bloc_clean_architecture/core/errors/exceptions.dart';
import 'package:bloc_clean_architecture/core/errors/failure.dart';
import 'package:bloc_clean_architecture/core/utils/typedef.dart';
import 'package:bloc_clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:bloc_clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:bloc_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  
  const AuthenticationRepositoryImpl(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;
  @override
  ResultVoid createUser({
    required String createdAt, 
    required String name, 
    required String avatar
  }) async {
    try {
      await _remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch(e){
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
  
}