import 'package:animations/animations.dart';
import 'package:creative_curve_web/features/contact_modal/presentation/contact_modal_screen.dart';
import 'package:creative_curve_web/features/home/presentation/home_screen.dart';
import 'package:creative_curve_web/features/performance/presentation/performance_screen.dart';
import 'package:creative_curve_web/features/service_grid/presentation/service_grid_screen.dart';
import 'package:creative_curve_web/features/team/presentation/team_screen.dart';
import 'package:creative_curve_web/features/tools/presentation/tools_screen.dart';
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
          name: 'home',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _sharedAxisPage(state, const HomeScreen());
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
          path: '/team',
          name: 'team',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _sharedAxisPage(state, const TeamScreen());
          },
        ),
        GoRoute(
          path: '/performance',
          name: 'performance',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _sharedAxisPage(state, const PerformanceScreen());
          },
        ),
        GoRoute(
          path: '/tools',
          name: 'tools',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return _sharedAxisPage(state, const ToolsScreen());
          },
        ),
        GoRoute(
          path: '/contacts',
          name: 'contacts',
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
    transitionDuration: const Duration(milliseconds: 700),
    reverseTransitionDuration: const Duration(milliseconds: 700),
    child: child,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      final Animation<double> curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutQuart,
      );
      final Animation<double> curvedSecondary = CurvedAnimation(
        parent: secondaryAnimation,
        curve: Curves.easeOutQuart,
      );

      return SharedAxisTransition(
        animation: curved,
        secondaryAnimation: curvedSecondary,
        transitionType: SharedAxisTransitionType.vertical,
        fillColor: Colors.transparent,
        child: child,
      );
    },
  );
}
