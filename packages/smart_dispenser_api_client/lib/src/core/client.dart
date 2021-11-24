import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:smart_dispenser_api_client/src/core/utils/api_request.dart';

class Client {
  Client._privateConstructor();

  static final Client _instance = Client._privateConstructor();

  static Client get instance => _instance;

  late Dio dio;

  void init({
    required String baseUrl,
    required Map<String, Object> headers,
    bool enableLogging = false,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        connectTimeout: 10000,
        receiveTimeout: 3000,
      ),
    );
    if (enableLogging) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          logPrint: (message) => log(message.toString()),
        ),
      );
    }
  }

  static Future<Response> request(ApiRequest request) {
    return _instance.dio.request(
      request.url,
      data: request.body,
      queryParameters: request.query,
      options: Options(method: request.method, headers: request.headers),
    );
  }
}
