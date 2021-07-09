import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_app/repositories/character_repository.dart';
import 'package:flutter_testing_app/services/models/character_models.dart';
import 'package:flutter_testing_app/services/remote/character_remote_service.dart';
import 'package:mocktail/mocktail.dart';

class CharacterRemoteServiceMock extends Mock
    implements CharacterRemoteService {}

void main() {
  group('Testing Characters Remote ', () {
    final characterRemoteServiceMock = CharacterRemoteServiceMock();
    final characterRepositoryImpl = CharacterRepositoryImpl(
      characterRemoteService: characterRemoteServiceMock,
    );
    test('- Success', () async {
      /// Given
      when(() => characterRemoteServiceMock.getAllCharacters()).thenAnswer(
        (_) => Future.value(
          [
            const CharacterModel(
              charId: 1,
              name: "Walter White",
              birthday: "09-07-1958",
              occupation: ["High School Chemistry Teacher", "Meth King Pin"],
              img:
                  "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
              status: "Deceased",
              appearance: [1, 2, 3, 4, 5],
              nickname: "Heisenberg",
              portrayed: "Bryan Cranston",
              betterCallSaulAppearance: [],
              category: '',
            )
          ],
        ),
      );

      /// When
      final res = await characterRepositoryImpl.getAllCharacters();

      /// Then
      expect(res, isA<CharactersResponse>());
      expect(res.results, isNotNull);
      expect(res.error, isNull);
    });
    test('- Error Captured', () async {
      /// Given
      when(() => characterRemoteServiceMock.getAllCharacters())
          .thenThrow(Exception('oops'));

      /// When
      final res = await characterRepositoryImpl.getAllCharacters();

      /// Then
      expect(res, isA<CharactersResponse>());
      expect(res.results, isNull);
      expect(res.error, isNotNull);
    });
  });

  group('Testing Character Remote ', () {
    final characterRemoteServiceMock = CharacterRemoteServiceMock();
    final characterRepositoryImpl = CharacterRepositoryImpl(
      characterRemoteService: characterRemoteServiceMock,
    );
    test('- Success', () async {
      /// Given
      when(() => characterRemoteServiceMock.characterById(1)).thenAnswer(
        (_) => Future.value(const CharacterModel(
          charId: 1,
          name: "Walter White",
          birthday: "09-07-1958",
          occupation: ["High School Chemistry Teacher", "Meth King Pin"],
          img:
              "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
          status: "Deceased",
          appearance: [1, 2, 3, 4, 5],
          nickname: "Heisenberg",
          portrayed: "Bryan Cranston",
          betterCallSaulAppearance: [],
          category: '',
        )),
      );

      /// When
      final res = await characterRepositoryImpl.characterById(1);

      /// Then
      expect(res, isA<CharacterResponse>());
      expect(res.results, isNotNull);
      expect(res.error, isNull);
    });
    test('- Error Captured', () async {
      /// Given
      when(() => characterRemoteServiceMock.characterById(1))
          .thenThrow(Exception('oops'));

      /// When
      final res = await characterRepositoryImpl.characterById(1);

      /// Then
      expect(res, isA<CharacterResponse>());
      expect(res.results, isNull);
      expect(res.error, isNotNull);
    });
  });
}
