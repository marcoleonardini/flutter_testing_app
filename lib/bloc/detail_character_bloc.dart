import 'package:flutter_testing_app/repositories/character_repository.dart';
import 'package:flutter_testing_app/services/models/character_models.dart';
import 'package:rxdart/subjects.dart';

class DetailCharacterBloc {
  final ICharacterRepository characterRepository;

  DetailCharacterBloc({required this.characterRepository});

  final BehaviorSubject<DetailCharacterBlocState> _subject = BehaviorSubject();

  Future<void> charactersById(int id) async {
    _subject.sink.add(DetailCharacterBlocState.loading());

    final response = await characterRepository.characterById(id);
    if (response.error == null) {
      _subject.sink
          .add(DetailCharacterBlocState.success(character: response.results));
    } else {
      _subject.sink.addError(Exception());
    }
  }

  BehaviorSubject<DetailCharacterBlocState> get subject => _subject;

  void dispose() {
    _subject.close();
  }
}

class DetailCharacterBlocState {
  final CharacterModel? character;
  final DetailCharacterBlocStatus status;

  DetailCharacterBlocState.success({required this.character})
      : status = DetailCharacterBlocStatus.loaded;

  DetailCharacterBlocState.error()
      : character = null,
        status = DetailCharacterBlocStatus.error;
  DetailCharacterBlocState.loading()
      : character = null,
        status = DetailCharacterBlocStatus.loading;
  DetailCharacterBlocState.initial()
      : character = null,
        status = DetailCharacterBlocStatus.initial;
}

enum DetailCharacterBlocStatus { initial, loading, loaded, error }
