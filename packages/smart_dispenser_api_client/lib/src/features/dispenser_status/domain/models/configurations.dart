import 'package:freezed_annotation/freezed_annotation.dart';

part 'configurations.freezed.dart';
part 'configurations.g.dart';

@freezed
class Configurations with _$Configurations {
  factory Configurations({
    @JsonKey(name: 'hora_desayuno') required int breakfastHour,
    @JsonKey(name: 'hora_almuerzo') required int lunchHour,
    @JsonKey(name: 'hora_comida') required int dinnerHour,
    @JsonKey(name: 'minuto_desayuno') required int breakfastMinute,
    @JsonKey(name: 'minuto_almuerzo') required int lunchMinute,
    @JsonKey(name: 'minuto_comida') required int dinnerMinute,
    @JsonKey(name: 'cantidad_desayuno') required int breakfastAmount,
    @JsonKey(name: 'cantidad_almuerzo') required int lunchAmount,
    @JsonKey(name: 'cantidad_comida') required int dinnerAmount,
    @JsonKey(name: 'peso_actual') required double currentWeight,
  }) = _Configurations;

  factory Configurations.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationsFromJson(json);
}
