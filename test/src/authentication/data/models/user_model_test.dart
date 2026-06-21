import 'dart:convert';

import 'package:bloc_clean_architecture/core/utils/typedef.dart';
import 'package:bloc_clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:bloc_clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  const tModel = UserModel.empty();

  test('should be a subclass of [User] entity', () {
    // Arrange
    expect(tModel, isA<User>());
  });

  final tJson = fixture("user.json");
  final tMap = jsonDecode(tJson) as DataMap;
  group('fromMap', () {
    test('should return a [UserModel] with the right data', (){

      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', (){

      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', (){
      // Act
      final result = tModel.toMap();

      //Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    
    test('should return a JSON string with the right data', () {
      final result = tModel.toJson();

      final tJson = {
        "id": "1",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name"
      };

      expect(jsonDecode(result), equals(tJson));
    });
  });

  group('copyWith', (){
    test("should return a [UserModel] with a different data", (){
          // Arrange


    // Act
    final result = tModel.copyWith(name:"Paul");

    expect(result.name, equals("Paul"));
    });
  });
}