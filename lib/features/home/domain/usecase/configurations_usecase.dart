import 'package:injectable/injectable.dart';
import 'package:smart_dispenser/features/home/domain/repositories/configurations_repository.dart';
import 'package:smart_dispenser_api_client/smart_dispense_api_client.dart'
    show Configurations;

abstract class ConfigurationsUseCase {
  Future<Configurations> getConfigurations();
  Future<Configurations> setConfigurations({
    required Configurations configurations,
  });
}

@Injectable(as: ConfigurationsUseCase)
class ConfigurationsUseCaseImp implements ConfigurationsUseCase {
  ConfigurationsUseCaseImp(this._configurationsRepository);

  final ConfigurationsRepository _configurationsRepository;

  @override
  Future<Configurations> getConfigurations() =>
      _configurationsRepository.getConfigurations();

  @override
  Future<Configurations> setConfigurations({
    required Configurations configurations,
  }) =>
      _configurationsRepository.setConfigurations(configurations);
}
