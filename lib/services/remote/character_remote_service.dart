import 'package:dio/dio.dart';
import 'package:flutter_testing_app/config/endpotins.dart';
import 'package:flutter_testing_app/services/models/character_models.dart';

class CharacterRemoteService {
  final Dio _dio;

  CharacterRemoteService({required Dio dio}) : _dio = dio;

  Future<List<CharacterModel>> getAllCharacters() async {
    final res = await _dio.get(AppEndpoints.allCharacters);

    if (res.data == null) {
      return [];
    }

    if (res.statusCode == 200) {
      final characters = <CharacterModel>[];

      for (final item in res.data!) {
        characters.add(CharacterModel.fromJson(item as Map<String, dynamic>));
      }
      return characters;
    } else {
      throw Exception();
    }
  }

  Future<CharacterModel> characterById(int id) async {
    final res = await _dio.get<List<Map<String, dynamic>>>(
        AppEndpoints.charactersById.replaceAll('{{id}}', '$id'));

    if (res.data == null) {
      throw Exception();
    }

    if (res.statusCode == 200) {
      return CharacterModel.fromJson(res.data![0]);
    } else {
      throw Exception();
    }
  }
}
