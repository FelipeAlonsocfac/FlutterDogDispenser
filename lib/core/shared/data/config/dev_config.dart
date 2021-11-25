import 'package:injectable/injectable.dart';
import 'package:smart_dispenser/core/shared/domain/config/config.dart';

@dev
@Injectable(as: Config)
class DevConfig implements Config {
  @override
  String get flavorName => dev.name;

  @override
  String get baseUrl => 'http://13.92.82.121:1880/';

  @override
  bool get enableLogging => true;
}
