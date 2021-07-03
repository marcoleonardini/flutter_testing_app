import 'package:flutter_testing_app/repositories/character_repository.dart';
import 'package:flutter_testing_app/services/models/character_models.dart';
import 'package:rxdart/subjects.dart';

class CharacterBloc {
  final ICharacterRepository characterRepository;

  CharacterBloc({required this.characterRepository});

  final BehaviorSubject<CharactersResponse> _subject = BehaviorSubject();

  Future allCharacters() async {
    final response = await characterRepository.getAllCharacters();
    _subject.sink.add(response);
  }

  BehaviorSubject<CharactersResponse> get subject => _subject;

  void dispose() {
    _subject.close();
  }
}
