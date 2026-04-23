import 'package:creative_curve_web/core/routing/router.dart';
import 'package:creative_curve_web/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreativeCurveApp extends StatelessWidget {
  const CreativeCurveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Creative Curve Studios',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
