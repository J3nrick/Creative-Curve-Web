import 'package:creative_curve_web/app/app_router.dart';
import 'package:creative_curve_web/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Root application entry for the Creative Curve web experience.
class CreativeCurveApp extends ConsumerWidget {
  /// Creates the root app widget.
  const CreativeCurveApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Creative Curve Studios',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
