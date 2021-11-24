import 'package:smart_dispenser_api_client/src/core/client.dart';
import 'package:smart_dispenser_api_client/src/core/domain/services/client_api.dart';
import 'package:smart_dispenser_api_client/src/features/dispenser_status/data/services/dispenser_status_api_imp.dart';
import 'package:smart_dispenser_api_client/src/features/dispenser_status/domain/services/dispenser_status_api.dart';

class SmartDispenseApi extends ClientApi {
  SmartDispenseApi(String baseUrl, {bool enableLogging = false}) {
    init(baseUrl: baseUrl, enableLogging: enableLogging);
  }

  @override
  void init({required String baseUrl, bool enableLogging = false}) {
    Client.instance.init(
      baseUrl: baseUrl,
      headers: {'Content-Type': 'application/json'},
      enableLogging: enableLogging,
    );
  }

  @override
  DispenserStatusApi get dispenserStatusApi => DispenserStatusApiImp();
}
