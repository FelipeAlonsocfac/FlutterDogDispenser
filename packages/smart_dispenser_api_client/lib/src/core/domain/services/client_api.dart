import 'package:smart_dispenser_api_client/src/features/dispenser_status/domain/services/dispenser_status_api.dart';

abstract class ClientApi {
  void init({required String baseUrl, bool enableLogging = false});

  DispenserStatusApi get dispenserStatusApi;
}
