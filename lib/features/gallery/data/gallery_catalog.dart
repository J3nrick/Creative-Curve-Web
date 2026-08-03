import 'package:creative_curve_web/core/constants/app_assets.dart';

/// Strongly-typed gallery / project-image slot.
/// Swap [path] with a local asset or network URL; set [isNetwork] accordingly.
typedef GalleryItem = ({
  String path,
  String title,
  String category,
  double aspectRatio,
  bool isNetwork,
});

/// Sequential catalog — every item is rendered in array order without skips.
abstract final class GalleryCatalog {
  static const List<GalleryItem> items = <GalleryItem>[
    (
      path: AppAssets.galleryLifestyleGrid,
      title: 'Lifestyle & Product Stories',
      category: 'Photography',
      aspectRatio: 4 / 3,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryFoodGrid,
      title: 'Culinary Visual Systems',
      category: 'Food',
      aspectRatio: 4 / 3,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryHeroHome1,
      title: 'Brand Momentum Frame I',
      category: 'Campaign',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryHeroHome2,
      title: 'Brand Momentum Frame II',
      category: 'Campaign',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryHeroHome3,
      title: 'Brand Momentum Frame III',
      category: 'Campaign',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryHeroHome4,
      title: 'Brand Momentum Frame IV',
      category: 'Campaign',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryTeamGroup,
      title: 'We Take the Curve',
      category: 'Studio',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryKrystal,
      title: 'Krystal — Project Leadership',
      category: 'Team',
      aspectRatio: 4 / 3,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryJp,
      title: 'JP — Media Production',
      category: 'Team',
      aspectRatio: 4 / 3,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryZyle,
      title: 'Zyle — Strategy & Sales',
      category: 'Team',
      aspectRatio: 4 / 3,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryErika,
      title: 'Erika — Creative Direction',
      category: 'Team',
      aspectRatio: 4 / 3,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryDiscoverCurve,
      title: 'Discover Curve',
      category: 'Identity',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryBecauseStraight,
      title: 'Because Straightforward Is Too Predictable',
      category: 'Identity',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryWhoAreWe,
      title: 'Who Are We?',
      category: 'Identity',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.galleryValues,
      title: 'We Set Trends',
      category: 'Values',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    // --- Placeholders: swap path / isNetwork when you add more assets ---
    // (
    //   path: 'assets/gallery/16_your_project.png',
    //   title: 'Your Project Title',
    //   category: 'Category',
    //   aspectRatio: 4 / 3,
    //   isNetwork: false,
    // ),
    // (
    //   path: 'https://example.com/project.jpg',
    //   title: 'Network Showcase',
    //   category: 'Remote',
    //   aspectRatio: 16 / 9,
    //   isNetwork: true,
    // ),
  ];
}
