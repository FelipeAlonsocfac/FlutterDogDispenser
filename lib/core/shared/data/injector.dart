import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_dispenser/core/shared/data/injector.config.dart';

GetIt _getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
void configure(String environment) {
  $initGetIt(_getIt, environment: environment);
}
