import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_dispenser/core/shared/domain/errors/smart_dispenser_exceptions.dart';
import 'package:smart_dispenser/features/home/domain/usecase/configurations_usecase.dart';
import 'package:smart_dispenser_api_client/smart_dispense_api_client.dart';

part 'home_state.dart';
part 'home_event.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._useCase) : super(HomeState.initial()) {
    on<_LoadDataEvent>(_loadDataEventToState);
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
}
