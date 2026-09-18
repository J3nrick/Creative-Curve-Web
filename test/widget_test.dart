import 'package:creative_curve_web/core/constants/app_assets.dart';
import 'package:creative_curve_web/features/gallery/data/gallery_catalog.dart';
import 'package:creative_curve_web/features/team/application/team_provider.dart';
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
}

