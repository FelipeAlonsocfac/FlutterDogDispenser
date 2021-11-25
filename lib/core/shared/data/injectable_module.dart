import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_dispenser_api_client/smart_dispense_api_client.dart'
    show ClientApi, DispenserStatusApi;

@module
abstract class InjectableModule {
  DispenserStatusApi get dispenserStatusApi =>
      GetIt.instance.get<ClientApi>().dispenserStatusApi;
}
