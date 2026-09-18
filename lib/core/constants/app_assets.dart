abstract final class AppAssets {
  // Branding assets
  static const String logoRed = 'assets/branding/logored.png';
  static const String logoWhite = 'assets/branding/logowhite.png';
  static const String favicon = 'assets/branding/favicon_full_192.png';

  // Home carousel legacy roots
  static const String home1 = 'assets/Home1.png';
  static const String home2 = 'assets/Home2.png';
  static const String home3 = 'assets/Home3.png';
  static const String home4 = 'assets/Home4.png';

  // Semantic asset constants based on verified visual analysis:
  // 01: Core Values Manifesto ("We don't just follow trends — we set them.")
  static const String valuesManifesto = 'assets/gallery/01_lifestyle_grid.png';

  // 02: Brand Philosophy Wave Banner ("Taking the curve isn't just about being different—it's about leading the way.")
  static const String curveWaveBanner = 'assets/gallery/02_food_grid.png';

  // 03: Hero Narrative 1 ("because straightforward is too predictable.")
  static const String heroStraightforward = 'assets/gallery/03_hero_home1.png';

  // 04: Hero Narrative 2 (Crimson Studio Splash: "creative CURVE studios")
  static const String heroStudioRed = 'assets/gallery/04_hero_home2.png';

  // 05: Hero Narrative 3 ("discover curve" digital agency mission)
  static const String heroDiscoverCurve = 'assets/gallery/05_hero_home3.png';

  // 06: Hero Narrative 4 ("who are we? in a world where brands follow the same paths")
  static const String heroWhoAreWe = 'assets/gallery/06_hero_home4.png';

  // 07: Creative Lab & Growth Framework (1. transformation, 2. momentum, 3. influence)
  static const String labPillars = 'assets/gallery/07_team_group.png';

  // 08: Studio Slogan ("at creative curve studios, we create the curve")
  static const String createTheCurveSlogan = 'assets/gallery/08_krystal.png';

  // 09: JP Profile Card (Media Producer)
  static const String profileJp = 'assets/gallery/09_jp.png';

  // 10: Zyle Profile Card (Sales & Content Strategy)
  static const String profileZyle = 'assets/gallery/10_zyle.png';

  // 11: Erika Profile Card (Creative Direction & Design Lead)
  static const String profileErika = 'assets/gallery/11_erika.png';

  // 12: The Crafters Collective with Sunglasses ("we take the curve so you can stay ahead.")
  static const String teamAnthemSunglasses = 'assets/gallery/12_discover_curve.png';

  // 13: Culinary & Lifestyle Media Portfolio (Solita's bakehouse, tonkatsu, etc.)
  static const String portfolioCulinary = 'assets/gallery/13_because_straight.png';

  // 14: Clean High-Res Studio Portrait (4 crafters in sunglasses, clean backdrop)
  static const String teamCleanPortrait = 'assets/gallery/14_who_are_we.png';

  // 15: Krystal Profile Card (Project Manager)
  static const String profileKrystal = 'assets/gallery/15_values.png';

  // All 15 authentic gallery assets:
  static const List<String> allGallery = <String>[
    valuesManifesto,
    curveWaveBanner,
    heroStraightforward,
    heroStudioRed,
    heroDiscoverCurve,
    heroWhoAreWe,
    labPillars,
    createTheCurveSlogan,
    profileJp,
    profileZyle,
    profileErika,
    teamAnthemSunglasses,
    portfolioCulinary,
    teamCleanPortrait,
    profileKrystal,
  ];

  // Legacy gallery aliases for backwards-compatibility:
  static const String galleryLifestyleGrid = valuesManifesto;
  static const String galleryFoodGrid = curveWaveBanner;
  static const String galleryHeroHome1 = heroStraightforward;
  static const String galleryHeroHome2 = heroStudioRed;
  static const String galleryHeroHome3 = heroDiscoverCurve;
  static const String galleryHeroHome4 = heroWhoAreWe;
  static const String galleryTeamGroup = labPillars;
  static const String galleryKrystal = createTheCurveSlogan;
  static const String galleryJp = profileJp;
  static const String galleryZyle = profileZyle;
  static const String galleryErika = profileErika;
  static const String galleryDiscoverCurve = teamAnthemSunglasses;
  static const String galleryBecauseStraight = portfolioCulinary;
  static const String galleryWhoAreWe = teamCleanPortrait;
  static const String galleryValues = profileKrystal;
}
