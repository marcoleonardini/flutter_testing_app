import 'package:dio/dio.dart';
import 'package:flutter_testing_app/services/models/character_models.dart';

class CharacterRemoteService {
  final Dio _dio;

  CharacterRemoteService({required Dio dio}) : _dio = dio;

  Future<CharacterModel> characterById(int id) {
    // TODO: implement characterById
    throw UnimplementedError();
  }

  Future<List<CharacterModel>> getAllCharacters() {
    // TODO: implement getAllCharacters
    throw UnimplementedError();
  }
}
