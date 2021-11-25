import 'package:smart_dispenser_api_client/src/core/domain/models/api_result.dart';
import 'package:smart_dispenser_api_client/src/features/dispenser_status/domain/models/configurations.dart';

abstract class DispenserStatusApi {
  Future<ApiResult<Configurations?>> getConfigurations();
  Future<ApiResult<Configurations?>> setConfigurations({
    required Configurations configurations,
  });
}
