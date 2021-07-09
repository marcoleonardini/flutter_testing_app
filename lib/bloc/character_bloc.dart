import 'package:flutter_testing_app/repositories/character_repository.dart';
import 'package:flutter_testing_app/services/models/character_models.dart';
import 'package:rxdart/subjects.dart';

class CharacterBloc {
  final ICharacterRepository characterRepository;

  CharacterBloc({required this.characterRepository});

  final BehaviorSubject<CharacterBlocState> _subject = BehaviorSubject();

  Future allCharacters() async {
    _subject.sink.add(CharacterBlocState.loading());

    final response = await characterRepository.getAllCharacters();
    if (response.error == null) {
      _subject.sink.add(CharacterBlocState.success(list: response.results));
    } else {
      _subject.sink.add(CharacterBlocState.error());
    }
  }

  BehaviorSubject<CharacterBlocState> get subject => _subject;

  void dispose() {
    _subject.close();
  }
}

class CharacterBlocState {
  final List<CharacterModel>? list;
  final CharacterBlocStatus status;

  CharacterBlocState.success({required this.list})
      : status = CharacterBlocStatus.loaded;

  CharacterBlocState.error()
      : list = null,
        status = CharacterBlocStatus.error;
  CharacterBlocState.loading()
      : list = null,
        status = CharacterBlocStatus.loading;
  CharacterBlocState.initial()
      : list = null,
        status = CharacterBlocStatus.initial;
}

enum CharacterBlocStatus { initial, loading, loaded, error }
