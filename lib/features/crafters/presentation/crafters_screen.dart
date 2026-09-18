import 'dart:math' as math;
import 'package:creative_curve_web/core/constants/app_assets.dart';
import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/widgets/curve_logo.dart';
import 'package:flutter/material.dart';

class CraftersScreen extends StatefulWidget {
  const CraftersScreen({super.key});

  @override
  State<CraftersScreen> createState() => _CraftersScreenState();
}

class _CraftersScreenState extends State<CraftersScreen> {
  final ScrollController _scrollController = ScrollController();

  static const List<
          ({String name, String line, String imageAsset, bool darkShell})>
      _crafters =
      <({String name, String line, String imageAsset, bool darkShell})>[
    (
      name: 'Krystal',
      line: 'Strategic precision and disciplined delivery across every milestone.',
      imageAsset: AppAssets.profileKrystal,
      darkShell: false,
    ),
    (
      name: 'Zyle',
      line: 'High-velocity market positioning and high-converting content frameworks.',
      imageAsset: AppAssets.profileZyle,
      darkShell: true,
    ),
    (
      name: 'Erika',
      line: 'Bespoke design systems that make brands unforgettable.',
      imageAsset: AppAssets.profileErika,
      darkShell: false,
    ),
    (
      name: 'JP',
      line: 'Cinematic visual storytelling, motion craft, and commercial polish.',
      imageAsset: AppAssets.profileJp,
      darkShell: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool compact = MediaQuery.sizeOf(context).width < 980;
    final double sectionHeight = compact ? 420 : 520;
    final double viewportHeight = MediaQuery.sizeOf(context).height;

    return ListView.separated(
      controller: _scrollController,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: EdgeInsets.fromLTRB(0, compact ? 18 : 22, 0, compact ? 20 : 26),
      itemBuilder: (BuildContext context, int index) {
        final ({
          String name,
          String line,
          String imageAsset,
          bool darkShell
        }) crafter = _crafters[index];
        final double sectionTop = index * (sectionHeight + 14);
        final double viewportCenter = _scrollController.hasClients
            ? _scrollController.offset + (viewportHeight / 2)
            : viewportHeight / 2;
        final double sectionCenter = sectionTop + (sectionHeight / 2);
        final double distance = (sectionCenter - viewportCenter).abs();
        final double t =
            (1 - (distance / (viewportHeight * 0.9))).clamp(0.0, 1.0);
        final double scale = 1.06 - (0.08 * t);

        return _CrafterSection(
          name: crafter.name,
          line: crafter.line,
          imageAsset: crafter.imageAsset,
          darkShell: crafter.darkShell,
          height: sectionHeight,
          imageScale: scale,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemCount: _crafters.length,
    );
  }
}

class _CrafterSection extends StatelessWidget {
  const _CrafterSection({
    required this.name,
    required this.line,
    required this.imageAsset,
    required this.darkShell,
    required this.height,
    required this.imageScale,
  });

  final String name;
  final String line;
  final String imageAsset;
  final bool darkShell;
  final double height;
  final double imageScale;

  @override
  Widget build(BuildContext context) {
    final bool compact = MediaQuery.sizeOf(context).width < 980;
    final Color shell = darkShell ? AppColors.charcoal : AppColors.surface;
    final Color textColor = darkShell ? Colors.white : AppColors.charcoal;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(compact ? 24 : 32),
        child: Container(
          height: height,
          color: shell,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Transform.scale(
                scale: imageScale,
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[
                      (darkShell ? Colors.black : const Color(0xFF101010))
                          .withValues(alpha: 0.65),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(compact ? 20 : 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CurveLogo(
                      height: compact ? 26 : 32,
                      variant: darkShell
                          ? CurveLogoVariant.white
                          : CurveLogoVariant.red,
                      semanticLabel: 'Creative Curve logo',
                    ),
                    const SizedBox(height: 12),
                    Text(
                      name,
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: textColor,
                                fontSize: compact ? 36 : 54,
                                height: 1.0,
                              ),
                    ),
                    const SizedBox(height: 8),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: compact ? 320 : 520),
                      child: Text(
                        line,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: darkShell ? Colors.white70 : Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'CREATIVE CURVE',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.curveRed,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.6,
                          ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: compact ? 14 : 20,
                top: compact ? 14 : 18,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color:
                        Colors.black.withValues(alpha: darkShell ? 0.35 : 0.5),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white24, width: 1.0),
                  ),
                  child: Text(
                    '0${math.max(1, name.length)}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
