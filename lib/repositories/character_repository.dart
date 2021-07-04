import 'package:flutter_testing_app/services/models/character_models.dart';
import 'package:flutter_testing_app/services/remote/character_remote_service.dart';

abstract class ICharacterRepository {
  Future<CharactersResponse> getAllCharacters();
  Future<CharacterResponse> characterById(int id);
}

class CharacterRepositoryImpl implements ICharacterRepository {
  final CharacterRemoteService _characterRemoteService;

  CharacterRepositoryImpl({
    required CharacterRemoteService characterRemoteService,
  }) : _characterRemoteService = characterRemoteService;

  @override
  Future<CharacterResponse> characterById(int id) async {
    try {
      final res = await _characterRemoteService.characterById(id);
      return CharacterResponse(results: res);
    } catch (e) {
      return CharacterResponse.withError(error: 'Error en el enpoint');
    }
  }

  @override
  Future<CharactersResponse> getAllCharacters() async {
    try {
      final res = await _characterRemoteService.getAllCharacters();
      return CharactersResponse(results: res);
    } catch (e) {
      return CharactersResponse.withError(error: 'Error en el enpoint');
    }
  }
}
