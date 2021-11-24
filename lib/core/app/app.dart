import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_dispenser/core/shared/ui/navigation/app_routes.dart';
import 'package:smart_dispenser/core/shared/ui/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Dispenser',
        theme: AppTheme.theme,
        onGenerateRoute: AppRoutes.routes,
      ),
    );
  }
}
