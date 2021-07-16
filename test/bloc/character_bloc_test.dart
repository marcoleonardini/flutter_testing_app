import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_app/bloc/character_bloc.dart';
import 'package:flutter_testing_app/repositories/character_repository.dart';
import 'package:flutter_testing_app/services/models/character_models.dart';

import 'package:mocktail/mocktail.dart';

class CharacterRepositoryMock extends Mock implements ICharacterRepository {}

void main() {
  final characterRepositoryMock = CharacterRepositoryMock();
  late CharacterBloc characterBloc;
  setUp(() {
    characterBloc = CharacterBloc(
      characterRepository: characterRepositoryMock,
    );
  });
  group('Character Bloc Test', () {
    test('- get All Characters with Error', () async {
      when(() => characterRepositoryMock.getAllCharacters()).thenAnswer(
          (_) => Future.value(CharactersResponse.withError(error: 'Error')));

      expectLater(
        characterBloc.subject,
        emitsInOrder(
          [
            emits(isA<CharacterBlocState>()),
            emitsError(isA<Exception>()),
          ],
        ),
      );

      await characterBloc.allCharacters();
    });

    test('- get All Characters with Success', () async {
      when(() => characterRepositoryMock.getAllCharacters())
          .thenAnswer((_) => Future.value(CharactersResponse(results: [])));

      expectLater(
        characterBloc.subject,
        emitsInOrder(
          [
            emits(isA<CharacterBlocState>()),
            emits(isA<CharacterBlocState>()),
          ],
        ),
      );
      await characterBloc.allCharacters();
    });
  });
}
