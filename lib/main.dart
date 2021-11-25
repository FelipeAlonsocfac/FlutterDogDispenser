import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_dispenser/core/app/app.dart';
import 'package:smart_dispenser/core/helpers/helpers.dart';
import 'package:smart_dispenser/core/shared/data/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Helpers.orientations;
  configure(kDebugMode ? dev.name : prod.name);
  Helpers.overlayStyle;
  runApp(const MyApp());
}
