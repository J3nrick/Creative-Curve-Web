import 'package:creative_curve_web/features/home/presentation/home_screen.dart';
import 'package:creative_curve_web/features/team/presentation/team_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
