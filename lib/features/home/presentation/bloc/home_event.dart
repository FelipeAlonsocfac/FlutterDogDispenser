part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.loadData() = _LoadDataEvent;
  const factory HomeEvent.updateConfigurations(
    CountMeal countMeal,
    MealType type,
  ) = _UpdateConfigurations;
}
