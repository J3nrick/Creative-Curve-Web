import 'package:creative_curve_web/core/constants/app_assets.dart';

/// Strongly-typed gallery / project-image slot.
typedef GalleryItem = ({
  String path,
  String title,
  String category,
  String description,
  double aspectRatio,
  bool isNetwork,
});

/// Comprehensive catalog mapping all 15 provided assets to their authentic categories.
abstract final class GalleryCatalog {
  static const List<GalleryItem> items = <GalleryItem>[
    // --- Team & Crafters ---
    (
      path: AppAssets.teamAnthemSunglasses,
      title: 'The Crafters Collective — Anthem',
      category: 'Team & Squad',
      description:
          'Full team official anthem portrait in sunglasses on crimson backdrop: "we take the curve so you can stay ahead."',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.profileKrystal,
      title: 'Krystal — Project Manager',
      category: 'Team & Squad',
      description:
          'Official studio card: Project leadership, workflow efficiency, and Disney princess spirit guiding the journey.',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.profileZyle,
      title: 'Zyle — Sales & Content Strategist',
      category: 'Team & Squad',
      description:
          'Official studio card: Campaign storytelling, sales velocity, unconventional strategy, tennis, and golf.',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.profileErika,
      title: 'Erika — Creative Director & Design Lead',
      category: 'Team & Squad',
      description:
          'Official studio card: Creative vision, asset creation, overall branding, oil painting, and design excellence.',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.profileJp,
      title: 'JP — Media Producer',
      category: 'Team & Squad',
      description:
          'Official studio card: High-quality photography, videography, visual narratives, cafe hopping, and anime.',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.teamCleanPortrait,
      title: 'Founders Studio Portrait (Clean)',
      category: 'Team & Squad',
      description:
          'High-resolution clean portrait of all four founders in black suits and sunglasses on signature studio crimson.',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),

    // --- Client Work & Production ---
    (
      path: AppAssets.portfolioCulinary,
      title: 'Culinary & Brand Photography Showcase',
      category: 'Client Work',
      description:
          'Commercial visual production for Solita’s Bakehouse croissants, tonkatsu, ceremonial matcha, and gourmet wraps.',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),

    // --- Framework & Process ---
    (
      path: AppAssets.labPillars,
      title: 'The Creative Lab — Growth Framework',
      category: 'Framework & Process',
      description:
          'Laboratory composition detailing our three pillars: 1. Transformation, 2. Momentum, and 3. Influence.',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),

    // --- Values & Philosophy ---
    (
      path: AppAssets.valuesManifesto,
      title: 'Core Values — "We Set Them"',
      category: 'Philosophy & Values',
      description:
          'Core agency manifesto: 1. Transparent, 2. Respectful, 3. Data-driven, 4. Purpose-driven.',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.curveWaveBanner,
      title: 'Leading The Curve — Philosophy Banner',
      category: 'Philosophy & Values',
      description:
          'Signature wave curve geometry: "Taking the curve isn\'t just about being different—it\'s about leading the way."',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.createTheCurveSlogan,
      title: 'Studio Slogan Signature',
      category: 'Brand Identity',
      description:
          'Official signature wordmark: "at creative curve studios, we create the curve."',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),

    // --- Hero & Narrative Sequence ---
    (
      path: AppAssets.heroStraightforward,
      title: 'Brand Narrative I — "Too Predictable"',
      category: 'Brand Identity',
      description:
          'Introductory narrative frame: "because straightforward is too predictable."',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.heroStudioRed,
      title: 'Brand Narrative II — Crimson Splash Mark',
      category: 'Brand Identity',
      description:
          'Signature crimson studio splash with white Creative Curve Studios typography.',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.heroDiscoverCurve,
      title: 'Brand Narrative III — "Discover Curve"',
      category: 'Brand Identity',
      description:
          'Agency definition: Digital creative agency driven by storytellers, strategists, and curve crafters.',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
    (
      path: AppAssets.heroWhoAreWe,
      title: 'Brand Narrative IV — "Who Are We?"',
      category: 'Brand Identity',
      description:
          'The defining question: "who are we? in a world where brands follow the same paths."',
      aspectRatio: 16 / 9,
      isNetwork: false,
    ),
  ];
}
