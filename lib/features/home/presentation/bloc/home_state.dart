part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(true) bool loading,
    Configurations? configurations,
  }) = _HomeState;

  factory HomeState.initial() => const _HomeState();
}
