import 'package:injectable/injectable.dart';
import 'package:smart_dispenser/core/shared/domain/config/config.dart';

@prod
@Injectable(as: Config)
class ProdConfig implements Config {
  @override
  String get flavorName => prod.name;

  @override
  String get baseUrl => 'http://13.92.82.121:1880/';

  @override
  bool get enableLogging => false;
}
