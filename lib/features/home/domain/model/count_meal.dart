import 'package:freezed_annotation/freezed_annotation.dart';

part 'count_meal.freezed.dart';

@freezed
class CountMeal with _$CountMeal {
  factory CountMeal({
    required int hour,
    required int minutes,
    required int gr,
  }) = _CountMeal;
}
