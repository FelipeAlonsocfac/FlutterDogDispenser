import 'package:injectable/injectable.dart';
import 'package:smart_dispenser/core/shared/domain/config/config.dart';
import 'package:smart_dispenser_api_client/smart_dispense_api_client.dart'
    show ClientApi, SmartDispenseApi;

@module
abstract class RegisterApi {
  @lazySingleton
  ClientApi api(Config config) => SmartDispenseApi(
        config.baseUrl,
        enableLogging: config.enableLogging,
      );
}
