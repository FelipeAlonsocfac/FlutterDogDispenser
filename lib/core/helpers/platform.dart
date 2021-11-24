import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;

bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;
bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
