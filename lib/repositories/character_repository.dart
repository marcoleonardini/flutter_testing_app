import 'package:flutter_testing_app/services/models/character_models.dart';
import 'package:flutter_testing_app/services/remote/character_remote_service.dart';

abstract class ICharacterRepository {
  Future<CharactersResponse> getAllCharacters();
  Future<CharacterResponse> characterById(int id);
}

class CharacterRepositoryImpl implements ICharacterRepository {
  final CharacterRemoteService _characterRemoteService;

  CharacterRepositoryImpl(
      {required CharacterRemoteService characterRemoteService})
      : _characterRemoteService = characterRemoteService;

  @override
  Future<CharacterResponse> characterById(int id) {
    // TODO: implement characterById
    throw UnimplementedError();
  }

  @override
  Future<CharactersResponse> getAllCharacters() {
    // TODO: implement getAllCharacters
    throw UnimplementedError();
  }
}
