import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:smart_dispenser/core/shared/ui/navigation/my_page_route.dart';
import 'package:smart_dispenser/features/home/presentation/screen/home_screen.dart';

abstract class AppRoutes {
  static const initialRoute = '/';

  static Route<dynamic> routes(RouteSettings routeSettings) {
    log('Route name: ${routeSettings.name}');
    log('Route arguments: ${routeSettings.arguments.toString()}');
    switch (routeSettings.name) {
      case initialRoute:
        return MyPageRoute(
          screen: HomeScreen.create(),
        );
      default:
        return MyPageRoute(
          screen: _ScreenNotFound.create(),
        );
    }
  }
}

class _ScreenNotFound extends StatelessWidget {
  const _ScreenNotFound({Key? key}) : super(key: key);

  static Widget create() => const _ScreenNotFound();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Screen no found')),
    );
  }
}
