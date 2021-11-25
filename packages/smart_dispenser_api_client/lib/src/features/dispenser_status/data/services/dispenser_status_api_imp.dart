import 'package:smart_dispenser_api_client/src/core/constants/endpoints.dart';
import 'package:smart_dispenser_api_client/src/core/data/services/api_request.dart';
import 'package:smart_dispenser_api_client/src/core/domain/models/api_result.dart';
import 'package:smart_dispenser_api_client/src/core/utils/api_request.dart';
import 'package:smart_dispenser_api_client/src/features/dispenser_status/domain/models/configurations.dart';
import 'package:smart_dispenser_api_client/src/features/dispenser_status/domain/services/dispenser_status_api.dart';

class DispenserStatusApiImp implements DispenserStatusApi {
  @override
  Future<ApiResult<Configurations?>> getConfigurations() => request(
        ApiRequest.get(ConfigurationsEndpoints.getConfigurations),
        (j) => Configurations.fromJson(j),
      );

  @override
  Future<ApiResult<Configurations?>> setConfigurations({
    required Configurations configurations,
  }) =>
      request(
        ApiRequest.post(
          ConfigurationsEndpoints.setConfigurations,
          body: configurations.toJson(),
        ),
        (j) => Configurations.fromJson(j),
      );
}
