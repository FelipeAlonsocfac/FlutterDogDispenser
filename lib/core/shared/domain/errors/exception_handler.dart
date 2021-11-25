import 'dart:async';
import 'dart:io';
import 'package:smart_dispenser/core/shared/domain/errors/smart_dispenser_exceptions.dart';
import 'package:smart_dispenser_api_client/smart_dispense_api_client.dart'
    show DioError;

abstract class ExceptionHandler {
  static dynamic throwPaxException(Exception exception) {
    if (exception is DioError) {
      final error = exception.error;
      if (error is SocketException || error is TimeoutException) {
        throw const SmartDispenserExceptions.networkException();
      }
      final statusCode = exception.response!.statusCode ?? -1;
      switch (statusCode) {
        case HttpStatus.internalServerError:
          throw const SmartDispenserExceptions.internalServerException();
        default:
      }
    }
    throw const SmartDispenserExceptions.unknownException();
  }
}
