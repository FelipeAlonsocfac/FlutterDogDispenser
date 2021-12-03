import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_dispenser/core/shared/domain/errors/smart_dispenser_exceptions.dart';
import 'package:smart_dispenser/features/home/domain/model/count_meal.dart';
import 'package:smart_dispenser/features/home/domain/usecase/configurations_usecase.dart';
import 'package:smart_dispenser_api_client/smart_dispense_api_client.dart';

part 'home_state.dart';
part 'home_event.dart';
part 'home_bloc.freezed.dart';

enum MealType { breakFast, lunch, dinner }

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._useCase) : super(HomeState.initial()) {
    on<_LoadDataEvent>(_loadDataEventToState);
    on<_UpdateConfigurations>(_updateConfigurations);
  }

  final ConfigurationsUseCase _useCase;

  Future<void> _loadDataEventToState(
    _LoadDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final configurations = await _useCase.getConfigurations();
      emit(state.copyWith(configurations: configurations, loading: false));
    } on SmartDispenserExceptions catch (_) {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> refresh() async => add(const HomeEvent.loadData());

  Future<void> _updateConfigurations(
    _UpdateConfigurations event,
    Emitter<HomeState> emit,
  ) async {
    final type = event.type;
    late Configurations configurations;
    final countMeal = event.countMeal;
    switch (type) {
      case MealType.breakFast:
        configurations = state.configurations!.copyWith(
          breakfastAmount: countMeal.gr,
          breakfastHour: countMeal.hour,
          breakfastMinute: countMeal.minutes,
        );
        break;
      case MealType.lunch:
        configurations = state.configurations!.copyWith(
          lunchAmount: countMeal.gr,
          lunchHour: countMeal.hour,
          lunchMinute: countMeal.minutes,
        );
        break;
      case MealType.dinner:
        configurations = state.configurations!.copyWith(
          dinnerAmount: countMeal.gr,
          dinnerHour: countMeal.hour,
          dinnerMinute: countMeal.minutes,
        );
        break;
    }
    try {
      emit(state.copyWith(loading: true));
      final newConfigurations = await _useCase.setConfigurations(
        configurations: configurations,
      );
      emit(state.copyWith(loading: false, configurations: newConfigurations));
    } on SmartDispenserExceptions catch (_) {
      emit(state.copyWith(loading: false));
    }
  }
}
