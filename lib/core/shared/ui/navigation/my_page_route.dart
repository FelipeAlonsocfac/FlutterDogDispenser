import 'package:flutter/material.dart';
import 'package:smart_dispenser/core/helpers/platform.dart';

class MyPageRoute extends PageRouteBuilder {
  MyPageRoute({
    required this.screen,
    this.duration = const Duration(milliseconds: 450),
    this.routeSettings,
  }) : super(
          pageBuilder: (_, animation, ___) {
            if (isIOS) {
              return SlideTransition(
                position: Tween(begin: const Offset(1, 0), end: Offset.zero)
                    .animate(animation),
                child: screen,
              );
            }
            return SlideTransition(
              position: Tween(begin: const Offset(0, 1), end: Offset.zero)
                  .animate(animation),
              child: screen,
            );
          },
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          settings: routeSettings,
        );
  final Widget screen;
  final Duration duration;
  final RouteSettings? routeSettings;
}
