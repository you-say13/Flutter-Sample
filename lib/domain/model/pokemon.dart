import "package:freezed_annotation/freezed_annotation.dart";

part "pokemon.freezed.dart";
part "pokemon.g.dart";

@freezed
class Pokemon with _$Pokemon {
  // TODO APIの取得後の結果に応じて内容を変更する必要あり
  const factory Pokemon({
    required String name,
    required String url,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);
}
