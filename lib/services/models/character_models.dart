import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_models.freezed.dart';
part 'character_models.g.dart';

@freezed
class CharacterModel with _$CharacterModel {
  @JsonSerializable(anyMap: true, fieldRename: FieldRename.snake)
  const factory CharacterModel({
    required int charId,
    required String name,
    required String birthday,
    required List<String> occupation,
    required String img,
    required String status,
    required String nickname,
    required List<int> appearance,
    required String portrayed,
    required String category,
    required List<int> betterCallSaulAppearance,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
  factory CharacterModel.fromFakeData() => const CharacterModel(
        charId: 1,
        name: ' name',
        birthday: ' birthday',
        occupation: [],
        img: ' img',
        status: ' status',
        nickname: ' nickname',
        appearance: [],
        portrayed: ' portrayed',
        category: ' category',
        betterCallSaulAppearance: [],
      );
}

class CharactersResponse {
  final List<CharacterModel>? results;
  final String? error;

  CharactersResponse({this.results}) : error = null;

  CharactersResponse.withError({required this.error}) : results = null;
}

class CharacterResponse {
  final CharacterModel? results;
  final String? error;

  CharacterResponse({this.results}) : error = null;

  CharacterResponse.withError({this.error}) : results = null;
}
