import 'package:smart_dispenser_api_client/smart_dispense_api_client.dart'
    show Configurations;

abstract class ConfigurationsRepository {
  Future<Configurations> getConfigurations();
  Future<Configurations> setConfigurations(Configurations configurations);
}
