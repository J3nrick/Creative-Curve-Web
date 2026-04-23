import 'package:creative_curve_web/features/contact/presentation/contact_screen.dart';
import 'package:creative_curve_web/features/home/presentation/home_screen.dart';
import 'package:creative_curve_web/features/services/presentation/services_screen.dart';
import 'package:creative_curve_web/features/team/presentation/team_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// Central route graph for web-friendly URL routing.
@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/services',
        name: 'services',
        builder: (context, state) => const ServicesScreen(),
      ),
      GoRoute(
        path: '/team',
        name: 'team',
        builder: (context, state) => const TeamScreen(),
      ),
      GoRoute(
        path: '/contact',
        name: 'contact',
        builder: (context, state) => const ContactScreen(),
      ),
    ],
  );
}
