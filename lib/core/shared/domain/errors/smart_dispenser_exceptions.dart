import 'package:freezed_annotation/freezed_annotation.dart';

part 'smart_dispenser_exceptions.freezed.dart';

@freezed
class SmartDispenserExceptions
    with _$SmartDispenserExceptions
    implements Exception {
  const factory SmartDispenserExceptions.networkException() = NetworkException;
  const factory SmartDispenserExceptions.dataNullException() =
      DataNullException;
  const factory SmartDispenserExceptions.internalServerException() =
      InternalServerException;
  const factory SmartDispenserExceptions.unknownException() = UnknownException;
}
