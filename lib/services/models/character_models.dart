import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_models.freezed.dart';
part 'character_models.g.dart';

@freezed
class CharacterModel with _$CharacterModel {
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
}