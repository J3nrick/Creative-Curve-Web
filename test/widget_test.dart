import 'package:creative_curve_web/core/constants/app_assets.dart';
import 'package:creative_curve_web/core/theme/curve_theme_extension.dart';
import 'package:creative_curve_web/core/theme/theme_mode_provider.dart';
import 'package:creative_curve_web/features/contact_modal/presentation/contact_modal_screen.dart';
import 'package:creative_curve_web/features/gallery/data/gallery_catalog.dart';
import 'package:creative_curve_web/features/team/application/team_provider.dart';
import 'package:creative_curve_web/shared/interactions/cursor_magnet_scope.dart';
import 'package:creative_curve_web/shared/interactions/studio_command_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Asset & Catalog Integrity Tests', () {
    test('All 15 gallery assets are registered in AppAssets.allGallery', () {
      expect(AppAssets.allGallery.length, equals(15));
      for (final asset in AppAssets.allGallery) {
        expect(asset.startsWith('assets/gallery/'), isTrue);
        expect(asset.endsWith('.png') || asset.endsWith('.jpg'), isTrue);
      }
    });

    test('Gallery catalog contains all 15 gallery items with 16:9 ratio', () {
      expect(GalleryCatalog.items.length, equals(15));
      for (final item in GalleryCatalog.items) {
        expect(item.aspectRatio, equals(16 / 9));
        expect(item.title.isNotEmpty, isTrue);
        expect(item.category.isNotEmpty, isTrue);
        expect(item.description.isNotEmpty, isTrue);
      }
    });

    test('Team members have authentic local profile assets', () {
      final members = TeamMembers().build();
      expect(members.length, equals(4));
      for (final member in members) {
        expect(member.imagePath.startsWith('assets/gallery/'), isTrue);
        expect(member.name.isNotEmpty, isTrue);
        expect(member.role.isNotEmpty, isTrue);
        expect(member.tagline.isNotEmpty, isTrue);
      }
    });
  });

  group('Theme Engine & HSL Tokens Tests', () {
    test('CurveThemeExtension dark preset has correct brand and surface tokens', () {
      const CurveThemeExtension dark = CurveThemeExtension.dark;
      expect(dark.curveRed, equals(const Color(0xFFFF3B30)));
      expect(dark.surface, equals(const Color(0xFF141417)));
      expect(dark.darkSurface, equals(const Color(0xFF141417)));
      expect(dark.background, equals(const Color(0xFF09090B)));
      expect(dark.glassBlurSigma, equals(20.0));
    });

    test('CurveThemeExtension light preset has correct tokens', () {
      const CurveThemeExtension light = CurveThemeExtension.light;
      expect(light.curveRed, equals(const Color(0xFFFF3B30)));
      expect(light.surface, equals(const Color(0xFFFFFFFF)));
      expect(light.background, equals(const Color(0xFFF7F8FA)));
      expect(light.textPrimary, equals(const Color(0xFF0F1013)));
    });

    test('CurveThemeExtension lerp interpolates smoothly', () {
      const CurveThemeExtension dark = CurveThemeExtension.dark;
      const CurveThemeExtension light = CurveThemeExtension.light;
      final CurveThemeExtension mid = dark.lerp(light, 0.5);

      expect(mid.surface, isNotNull);
      expect(mid.background, isNotNull);
      expect(mid.glassBlurSigma, equals(20.0));
    });

    test('ThemeNotifier toggles and sets modes accurately in ProviderContainer', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(themeModeProvider), equals(ThemeMode.dark));

      container.read(themeModeProvider.notifier).toggle();
      expect(container.read(themeModeProvider), equals(ThemeMode.light));

      container.read(themeModeProvider.notifier).toggle();
      expect(container.read(themeModeProvider), equals(ThemeMode.dark));

      container.read(themeModeProvider.notifier).setLight();
      expect(container.read(themeModeProvider), equals(ThemeMode.light));

      container.read(themeModeProvider.notifier).setDark();
      expect(container.read(themeModeProvider), equals(ThemeMode.dark));

      container.read(themeModeProvider.notifier).setSystem();
      expect(container.read(themeModeProvider), equals(ThemeMode.system));
    });
  });

  group('Cursor Magnet & Micro-Interactions Tests', () {
    testWidgets('CursorMagnetScope renders child correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CursorMagnetScope(
              child: Text('Magnetic Action'),
            ),
          ),
        ),
      );

      expect(find.text('Magnetic Action'), findsOneWidget);
    });
  });

  group('Studio Command Palette & Intake Brief Tests', () {
    testWidgets('StudioCommandPalette renders search input and command list', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StudioCommandPalette(),
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Studio Overview & Deck'), findsOneWidget);
      expect(find.text('Capabilities & Disciplines'), findsOneWidget);
      expect(find.text('The Crafters Collective'), findsOneWidget);
    });

    testWidgets('ContactModalScreen renders interactive scope configurator', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ContactModalScreen(),
            ),
          ),
        ),
      );

      expect(find.text('Initiate Studio Project Brief'), findsOneWidget);
      expect(find.text('1. SELECT CRAFT DISCIPLINES'), findsOneWidget);
      expect(find.text('2. DESIRED DELIVERY CADENCE'), findsOneWidget);
      expect(find.text('3. ESTIMATED INVESTMENT TIER'), findsOneWidget);
      expect(find.text('Brand Architecture'), findsOneWidget);
      expect(find.text('hello@creativecurve.ph'), findsOneWidget);
    });
  });
}
