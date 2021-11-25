import 'package:injectable/injectable.dart';
import 'package:smart_dispenser/core/shared/domain/errors/exception_handler.dart';
import 'package:smart_dispenser/core/shared/domain/errors/smart_dispenser_exceptions.dart';
import 'package:smart_dispenser/features/home/domain/repositories/configurations_repository.dart';
import 'package:smart_dispenser_api_client/smart_dispense_api_client.dart'
    show Configurations, DispenserStatusApi;

@Injectable(as: ConfigurationsRepository)
class ConfigurationsRepositoryImp implements ConfigurationsRepository {
  ConfigurationsRepositoryImp(this._api);

  final DispenserStatusApi _api;

  @override
  Future<Configurations> getConfigurations() async {
    final apiResponse = await _api.getConfigurations();
    return apiResponse.when(
      success: (configurations) {
        if (configurations != null) return configurations;
        throw const SmartDispenserExceptions.dataNullException();
      },
      failure: (exception, stackTrace) =>
          throw ExceptionHandler.throwPaxException(exception),
    );
  }

  @override
  Future<Configurations> setConfigurations(
    Configurations configurations,
  ) async {
    final apiResponse = await _api.setConfigurations(
      configurations: configurations,
    );
    return apiResponse.when(
      success: (configurations) {
        if (configurations != null) return configurations;
        throw const SmartDispenserExceptions.dataNullException();
      },
      failure: (exception, stackTrace) =>
          throw ExceptionHandler.throwPaxException(exception),
    );
  }
}
