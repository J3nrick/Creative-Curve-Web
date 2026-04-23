import 'package:animations/animations.dart';
import 'package:creative_curve_web/features/contact_modal/presentation/contact_modal_screen.dart';
import 'package:creative_curve_web/features/crafters/presentation/crafters_screen.dart';
import 'package:creative_curve_web/features/hero/presentation/hero_screen.dart';
import 'package:creative_curve_web/features/service_grid/presentation/service_grid_screen.dart';
import 'package:creative_curve_web/shared/layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MainLayout(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          name: 'hero',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _sharedAxisPage(state, const HeroScreen());
          },
        ),
        GoRoute(
          path: '/services',
          name: 'services',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _sharedAxisPage(state, const ServiceGridScreen());
          },
        ),
        GoRoute(
          path: '/crafters',
          name: 'crafters',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _sharedAxisPage(state, const CraftersScreen());
          },
        ),
        GoRoute(
          path: '/contact',
          name: 'contact',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _sharedAxisPage(state, const ContactModalScreen());
          },
        ),
      ],
    ),
  ],
);

CustomTransitionPage<void> _sharedAxisPage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 450),
    reverseTransitionDuration: const Duration(milliseconds: 380),
    child: child,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal,
        fillColor: Colors.transparent,
        child: child,
      );
    },
  );
}
