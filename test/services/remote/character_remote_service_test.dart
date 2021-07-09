import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_app/config/endpoints.dart';

import 'package:flutter_testing_app/services/models/character_models.dart';
import 'package:flutter_testing_app/services/remote/character_remote_service.dart';

import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  group('Testing Characters Remote Get All ', () {
    final dioMock = DioMock();
    final characterRemoteService = CharacterRemoteService(dio: dioMock);
    setUpAll(() => reset(dioMock));
    test('- Success', () async {
      /// Given
      // final characterRemoteService

      /// When
      when(() => dioMock.get<List<Map<String, dynamic>>>(
            AppEndpoints.allCharacters,
          )).thenAnswer(
        (_) async => Response<List<Map<String, dynamic>>>(
          data: [],
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final res = await characterRemoteService.getAllCharacters();

      /// Then
      expect(res, isA<List<CharacterModel>>());

      verify(() => dioMock.get(AppEndpoints.allCharacters)).called(1);
      verifyNoMoreInteractions(dioMock);
    });
    test('- Exception', () async {
      /// Given
      // final characterRemoteServiceMock

      /// When
      when(() => dioMock.get<List<Map<String, dynamic>>>(
          AppEndpoints.allCharacters)).thenThrow(Exception());
      try {
        await characterRemoteService.getAllCharacters();
      } catch (e) {
        /// Then
        expect(e, isA<Exception>());
        verify(() => dioMock.get(AppEndpoints.allCharacters)).called(1);
        verifyNoMoreInteractions(dioMock);
      }
    });
    test('- No 200', () async {
      /// Given
      // final characterRemoteServiceMock

      /// When
      when(() => dioMock.get<List<Map<String, dynamic>>>(
            AppEndpoints.allCharacters,
          )).thenAnswer(
        (_) async => Response<List<Map<String, dynamic>>>(
          data: [],
          statusCode: 0,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      try {
        await characterRemoteService.getAllCharacters();
      } catch (e) {
        /// Then
        expect(e, isA<Exception>());
        verify(() => dioMock.get(AppEndpoints.allCharacters)).called(1);
        verifyNoMoreInteractions(dioMock);
      }
    });
    test('- null data', () async {
      /// Given
      // final characterRemoteServiceMock

      /// When
      when(() => dioMock.get<List<Map<String, dynamic>>>(
          AppEndpoints.allCharacters)).thenAnswer(
        (_) async => Response<List<Map<String, dynamic>>>(
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      try {
        await characterRemoteService.getAllCharacters();
      } catch (e) {
        /// Then
        expect(e, isA<Exception>());
        verify(() => dioMock.get(AppEndpoints.allCharacters)).called(1);
        verifyNoMoreInteractions(dioMock);
      }
    });
  });

  group('Testing Characters Remote GetById ', () {
    final dioMock = DioMock();
    final characterRemoteService = CharacterRemoteService(dio: dioMock);
    setUpAll(() => reset(dioMock));
    test('- Success', () async {
      /// Given
      // final characterRemoteService

      /// When
      when(() => dioMock.get<List<Map<String, dynamic>>>(
            AppEndpoints.charactersById.replaceAll('{{id}}', '1'),
          )).thenAnswer(
        (_) async => Response<List<Map<String, dynamic>>>(
          data: [
            {
              'char_id': 1,
              'name': "Walter White",
              'birthday': "09-07-1958",
              'occupation': ["High School Chemistry Teacher", "Meth King Pin"],
              'img':
                  "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
              'status': "Deceased",
              'appearance': [1, 2, 3, 4, 5],
              'nickname': "Heisenberg",
              'portrayed': "Bryan Cranston",
              'better_call_saul_appearance': [],
              'category': '',
            }
          ],
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final res = await characterRemoteService.characterById(1);

      /// Then
      expect(res, isA<CharacterModel>());

      verify(() => dioMock.get(
            AppEndpoints.charactersById.replaceAll('{{id}}', '1'),
          )).called(1);
      verifyNoMoreInteractions(dioMock);
    });
    test('- Exception', () async {
      /// Given
      // final characterRemoteServiceMock

      /// When
      when(() => dioMock.get<List<Map<String, dynamic>>>(
            AppEndpoints.charactersById.replaceAll('{{id}}', '1'),
          )).thenThrow(Exception());
      try {
        await characterRemoteService.characterById(1);
      } catch (e) {
        /// Then
        expect(e, isA<Exception>());
        verify(() => dioMock.get(
              AppEndpoints.charactersById.replaceAll('{{id}}', '1'),
            )).called(1);
        verifyNoMoreInteractions(dioMock);
      }
    });
    test('- No 200', () async {
      /// Given
      // final characterRemoteServiceMock

      /// When
      when(() => dioMock.get<List<Map<String, dynamic>>>(
            AppEndpoints.charactersById.replaceAll('{{id}}', '1'),
          )).thenAnswer(
        (_) async => Response<List<Map<String, dynamic>>>(
          data: [],
          statusCode: 0,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      try {
        await characterRemoteService.characterById(1);
      } catch (e) {
        /// Then
        expect(e, isA<Exception>());
        verify(() => dioMock.get(
              AppEndpoints.charactersById.replaceAll('{{id}}', '1'),
            )).called(1);
        verifyNoMoreInteractions(dioMock);
      }
    });
    test('- null data', () async {
      /// Given
      // final characterRemoteServiceMock

      /// When
      when(() => dioMock.get<List<Map<String, dynamic>>>(
            AppEndpoints.charactersById.replaceAll('{{id}}', '1'),
          )).thenAnswer(
        (_) async => Response<List<Map<String, dynamic>>>(
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      try {
        await characterRemoteService.characterById(1);
      } catch (e) {
        /// Then
        expect(e, isA<Exception>());
        verify(() => dioMock.get(
              AppEndpoints.charactersById.replaceAll('{{id}}', '1'),
            )).called(1);
        verifyNoMoreInteractions(dioMock);
      }
    });
  });
}
