import 'dart:async';

import 'package:creative_curve_web/core/constants/app_assets.dart';
import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    final double horizontalPadding = isMobile
        ? 16
        : isTablet
            ? 24
            : 32;

    final double topPadding = isMobile ? 8 : 16;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        topPadding,
        horizontalPadding,
        isMobile ? 20 : 32,
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool compact = constraints.maxWidth < 980;
          final bool tiny = constraints.maxWidth < 420;
          final double desktopHeight = constraints.maxWidth < 1180 ? 600 : 640;

          if (compact) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(tiny ? 18 : 28),
              decoration: ShapeDecoration(
                color: AppColors.surfaceFor(context),
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 26,
                    cornerSmoothing: 0.6,
                  ),
                  side: BorderSide(
                    color: AppColors.strokeFor(context),
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const _HeroCopy(compact: true),
                  const SizedBox(height: 24),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: tiny ? 230 : 300,
                    ),
                    child: const _MacStudioDeck(),
                  ),
                ],
              ),
            );
          }

          return SizedBox(
            height: desktopHeight,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      color: AppColors.surfaceFor(context),
                      shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(
                          cornerRadius: 28,
                          cornerSmoothing: 0.6,
                        ),
                        side: BorderSide(
                          color: AppColors.strokeFor(context),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 32,
                  top: 32,
                  bottom: 32,
                  width: constraints.maxWidth * 0.54,
                  child: const _HeroCopy(compact: false),
                ),
                Positioned(
                  right: 24,
                  top: 24,
                  bottom: 24,
                  width: constraints.maxWidth * 0.42,
                  child: const _MacStudioDeck(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Live Telemetry Badge (macOS pill style)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF19191E)
                : const Color(0xFFF1F3F6),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppColors.strokeFor(context),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF34C759),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'LIVE STUDIO',
                style: TextStyle(
                  color: AppColors.mutedFor(context),
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.mutedFor(context).withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Q2 Project Intake Open',
                style: TextStyle(
                  color: AppColors.textFor(context),
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Main Headline
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: compact ? 34 : 56,
                  height: 1.04,
                  letterSpacing: -1.3,
                  color: AppColors.textFor(context),
                ),
            children: const <TextSpan>[
              TextSpan(text: 'Designing strategic momentum for brands that '),
              TextSpan(
                text: 'refuse straight lines.',
                style: TextStyle(color: AppColors.curveRed),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Strategic Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            'We fuse brand architecture, bespoke commercial visual production, and high-performance digital systems into category-defining momentum.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.mutedFor(context),
                  height: 1.5,
                  fontSize: compact ? 14.5 : 16.5,
                ),
          ),
        ),
        const SizedBox(height: 26),

        // Action Buttons
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: <Widget>[
            _HeroActionButton(
              label: 'Explore Capabilities',
              icon: Icons.arrow_forward_rounded,
              onTap: () => context.go('/services'),
            ),
            _HeroActionButton(
              label: 'Meet The Specialists',
              outlined: true,
              onTap: () => context.go('/team'),
            ),
          ],
        ),
      ],
    );
  }
}

/// Apple/macOS-inspired Studio Deck Window with Glass Title Bar & Interactive Tabs
class _MacStudioDeck extends StatefulWidget {
  const _MacStudioDeck();

  @override
  State<_MacStudioDeck> createState() => _MacStudioDeckState();
}

class _MacStudioDeckState extends State<_MacStudioDeck> {
  static const Duration _autoCycleDuration = Duration(milliseconds: 5000);
  static const Duration _fadeDuration = Duration(milliseconds: 650);

  static const List<({String title, String tag, String asset})> _slides = [
    (
      title: 'Solita Commercial Suite',
      tag: 'PRODUCTION',
      asset: AppAssets.heroStudioRed,
    ),
    (
      title: 'Brand Philosophy Geometry',
      tag: 'ARCHITECTURE',
      asset: AppAssets.heroStraightforward,
    ),
    (
      title: 'Discover The Curve',
      tag: 'CAMPAIGN',
      asset: AppAssets.heroDiscoverCurve,
    ),
    (
      title: 'The Crafters Collective',
      tag: 'SPECIALISTS',
      asset: AppAssets.heroWhoAreWe,
    ),
  ];

  late final Timer _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_autoCycleDuration, (_) {
      if (!mounted) return;
      setState(() => _index = (_index + 1) % _slides.length);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);
    final activeSlide = _slides[_index];

    return Container(
      decoration: ShapeDecoration(
        color: isDark ? const Color(0xFF101014) : const Color(0xFFF3F5F8),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 22,
            cornerSmoothing: 0.6,
          ),
          side: BorderSide(
            color: AppColors.strokeFor(context),
            width: 1.0,
          ),
        ),
        shadows: [
          BoxShadow(
            color: (isDark ? Colors.black : const Color(0xFF101216))
                .withValues(alpha: isDark ? 0.35 : 0.06),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          // macOS Window Header Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF16161B)
                  : const Color(0xFFE9ECF1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(21)),
              border: Border(
                bottom: BorderSide(color: AppColors.strokeFor(context), width: 1.0),
              ),
            ),
            child: Row(
              children: [
                // Traffic Lights (macOS style)
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5F56),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFBD2E),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFF27C93F),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'studio_viewport.app',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.mutedFor(context),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.curveRed.withValues(alpha: isDark ? 0.15 : 0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    activeSlide.tag,
                    style: const TextStyle(
                      color: AppColors.curveRed,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main Viewport Canvas
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipSmoothRect(
                radius: SmoothBorderRadius(
                  cornerRadius: 14,
                  cornerSmoothing: 0.6,
                ),
                child: AnimatedSwitcher(
                  duration: _fadeDuration,
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Container(
                    key: ValueKey<int>(_index),
                    color: isDark
                        ? const Color(0xFF09090B)
                        : const Color(0xFFE5E8ED),
                    alignment: Alignment.center,
                    child: Image.asset(
                      activeSlide.asset,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Interactive Tab Selector (macOS Dock Style)
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(
              children: List<Widget>.generate(_slides.length, (int i) {
                final bool active = i == _index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _index = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: active
                            ? (isDark ? const Color(0xFF22222A) : Colors.white)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: active
                              ? AppColors.curveRed.withValues(alpha: 0.5)
                              : Colors.transparent,
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        '0${i + 1}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: active
                              ? AppColors.curveRed
                              : AppColors.mutedFor(context),
                          fontSize: 10.5,
                          fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroActionButton extends StatefulWidget {
  const _HeroActionButton({
    required this.label,
    required this.onTap,
    this.outlined = false,
    this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final bool outlined;
  final IconData? icon;

  @override
  State<_HeroActionButton> createState() => _HeroActionButtonState();
}

class _HeroActionButtonState extends State<_HeroActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    if (widget.outlined) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          decoration: ShapeDecoration(
            color: _hovered
                ? AppColors.textFor(context).withValues(alpha: 0.08)
                : Colors.transparent,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 14,
                cornerSmoothing: 0.6,
              ),
              side: BorderSide(
                color: _hovered
                    ? AppColors.textFor(context).withValues(alpha: 0.4)
                    : AppColors.strokeFor(context),
                width: 1.2,
              ),
            ),
          ),
          child: TextButton(
            onPressed: widget.onTap,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textFor(context),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13.5,
                letterSpacing: 0.2,
              ),
            ),
            child: Text(widget.label),
          ),
        ),
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _hovered ? -2.0 : 0.0, 0.0, 1.0),
        decoration: ShapeDecoration(
          color: _hovered ? AppColors.curveRedHover : AppColors.curveRed,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 14,
              cornerSmoothing: 0.6,
            ),
            side: BorderSide(
              color: Colors.white.withValues(alpha: isDark ? 0.25 : 0.4),
              width: 1.0,
            ),
          ),
          shadows: [
            BoxShadow(
              color: AppColors.curveRed.withValues(alpha: _hovered ? 0.35 : 0.18),
              blurRadius: _hovered ? 20 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FilledButton.icon(
          onPressed: widget.onTap,
          icon: widget.icon != null
              ? Icon(widget.icon, size: 15)
              : const SizedBox.shrink(),
          label: Text(widget.label),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13.5,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
