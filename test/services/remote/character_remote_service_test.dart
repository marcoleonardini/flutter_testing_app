import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_app/services/models/character_models.dart';
import 'package:flutter_testing_app/services/remote/character_remote_service.dart';
import 'package:mocktail/mocktail.dart';

class CharacterRemoteServiceMock extends Mock
    implements CharacterRemoteService {}

void main() {
  group('Testing Character Remote ', () {
    final characterRemoteServiceMock = CharacterRemoteServiceMock();
    test('- Success', () async {
      /// Given
      // final characterRemoteServiceMock

      /// When
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

      final res = await characterRemoteServiceMock.getAllCharacters();

      /// Then
      expect(res, isA<List<CharacterModel>>());
    });
    test('- Exception', () async {
      /// Given
      // final characterRemoteServiceMock

      /// When
      when(() => characterRemoteServiceMock.getAllCharacters())
          .thenThrow(Exception('oops'));
      try {
        final res = await characterRemoteServiceMock.getAllCharacters();
      } catch (e) {
        /// Then
        expect(e, isA<Exception>());
      }
    });
  });
}
