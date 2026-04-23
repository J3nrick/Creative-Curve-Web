import 'package:creative_curve_web/features/home/presentation/home_screen.dart';
import 'package:creative_curve_web/features/team/presentation/team_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('home screen renders hero and mission copy', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen()),
    );

    expect(find.text('Non-linear growth for ambitious brands.'), findsOneWidget);
    expect(find.text('Because straightforward is too predictable'), findsOneWidget);
    expect(find.text('The Curve'), findsOneWidget);
  });

  testWidgets('team screen renders all curve crafters', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: TeamScreen()),
    );

    expect(find.text('Krystal'), findsOneWidget);
    expect(find.text('Zyle'), findsOneWidget);
    expect(find.text('Erika'), findsOneWidget);
    expect(find.text('JP'), findsOneWidget);
  });

  testWidgets('home CTA navigates to team screen', (tester) async {
    final router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/team',
          builder: (context, state) => const TeamScreen(),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(routerConfig: router),
    );

    await tester.tap(find.text('Meet the Curve Crafters'));
    await tester.pumpAndSettle();

    expect(find.text('Curve Crafters'), findsOneWidget);
    expect(find.text('Krystal'), findsOneWidget);
  });
}
