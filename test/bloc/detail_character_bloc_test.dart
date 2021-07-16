import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_testing_app/bloc/detail_character_bloc.dart';
import 'package:flutter_testing_app/repositories/character_repository.dart';
import 'package:flutter_testing_app/services/models/character_models.dart';

import 'package:mocktail/mocktail.dart';

class CharacterRepositoryMock extends Mock implements ICharacterRepository {}

void main() {
  final characterRepositoryMock = CharacterRepositoryMock();
  late DetailCharacterBloc characterBloc;
  setUp(() {
    characterBloc = DetailCharacterBloc(
      characterRepository: characterRepositoryMock,
    );
  });
  group('Character Bloc Test', () {
    test('- get All Characters with Error', () async {
      when(() => characterRepositoryMock.characterById(any())).thenAnswer(
          (_) => Future.value(CharacterResponse.withError(error: 'Error')));

      expectLater(
        characterBloc.subject,
        emitsInOrder(
          [
            emits(isA<DetailCharacterBlocState>()),
            emitsError(isA<Exception>()),
          ],
        ),
      );

      await characterBloc.charactersById(1);
    });

    test('- get All Characters with Success', () async {
      when(() => characterRepositoryMock.characterById(any())).thenAnswer((_) =>
          Future.value(
              CharacterResponse(results: CharacterModel.fromFakeData())));

      expectLater(
        characterBloc.subject,
        emitsInOrder(
          [
            emits(isA<DetailCharacterBlocState>()),
            emits(isA<DetailCharacterBlocState>()),
          ],
        ),
      );
      await characterBloc.charactersById(1);
    });
  });
}
