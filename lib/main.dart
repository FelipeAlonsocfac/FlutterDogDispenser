import 'package:flutter/material.dart';
import 'package:smart_dispenser/core/app/app.dart';
import 'package:smart_dispenser/core/helpers/helpers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Helpers.orientations;
  Helpers.overlayStyle;
  runApp(const MyApp());
}
