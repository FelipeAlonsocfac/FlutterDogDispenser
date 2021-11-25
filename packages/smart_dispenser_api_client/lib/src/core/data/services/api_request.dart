import 'package:smart_dispenser_api_client/src/core/client.dart';
import 'package:smart_dispenser_api_client/src/core/domain/models/api_result.dart';
import 'package:smart_dispenser_api_client/src/core/utils/api_request.dart';

Future<ApiResult<T>> request<T>(
  ApiRequest request,
  Function(dynamic) fromJson,
) async {
  try {
    final response = await Client.request(request);
    return ApiResult.success(data: fromJson(response.data));
  } on Exception catch (error, stackTrace) {
    return ApiResult.failure(error: error, stackTrace: stackTrace);
  }
}
