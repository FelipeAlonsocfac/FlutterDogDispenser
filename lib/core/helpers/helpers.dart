import 'package:flutter/material.dart' show Colors;
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiOverlayStyle, DeviceOrientation;

abstract class Helpers {
  static Future<void> get orientations => SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
      );

  static void get overlayStyle => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
      );
}
