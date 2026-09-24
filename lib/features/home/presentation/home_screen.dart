import 'package:creative_curve_web/core/constants/app_assets.dart';
import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/features/home/presentation/widgets/home_hero_section.dart';
import 'package:creative_curve_web/features/team/application/team_provider.dart';
import 'package:creative_curve_web/features/team/domain/team_member.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
import 'package:creative_curve_web/shared/widgets/liquid_glass_image_card.dart';
import 'package:creative_curve_web/shared/widgets/liquid_glass_panel.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    final CurvedAnimation curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(curved);
    _slide = Tween<Offset>(begin: const Offset(0, 0.03), end: Offset.zero)
        .animate(curved);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: const SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // 1. Hero Section with macOS Interactive Studio Deck
              HomeHeroSection(),

              // 2. Strategic Bento Grid ("The Creative Curve Advantage")
              _StrategicBentoSection(),

              // 3. Strategic Paradigm ("Straight Lines vs. The Creative Curve")
              _StrategyComparisonSection(),

              // 4. Commercial Case Study Spotlight (Solita's Bakehouse)
              _CommercialSpotlightSection(),

              // 5. Execution Blueprint (4-Phase Engine)
              _ExecutionBlueprintSection(),

              // 6. Brand Manifesto & Core Values ("We Set Them")
              _BrandManifestoSection(),

              // 7. Meet The Crafters Collective
              _CraftersSquadSection(),

              // 8. macOS-Style Studio Terminal CTA Banner
              _StudioTerminalCtaSection(),

              SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// SECTION 2: STRATEGIC BENTO GRID ("The Creative Curve Advantage")
// =========================================================================
class _StrategicBentoSection extends StatelessWidget {
  const _StrategicBentoSection();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isDark = AppColors.isDark(context);
    final double horizontalPadding = isMobile ? 16 : 32;

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 28),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool stack = constraints.maxWidth < 900;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.curveRed.withValues(alpha: isDark ? 0.12 : 0.08),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: AppColors.curveRed.withValues(alpha: isDark ? 0.35 : 0.25),
                    width: 1.0,
                  ),
                ),
                child: const Text(
                  'STRATEGIC ADVANTAGE',
                  style: TextStyle(
                    color: AppColors.curveRed,
                    fontWeight: FontWeight.w800,
                    fontSize: 10.5,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Built for Category Dominance',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.textFor(context),
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  'Four unified disciplines working in concert to engineer unmistakable brand momentum and measurable market velocity.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.mutedFor(context),
                        height: 1.5,
                      ),
                ),
              ),
              const SizedBox(height: 24),

              // BENTO GRID ROW 1
              if (stack) ...[
                const _BentoCard(
                  title: 'Kinetic Brand Systems',
                  kicker: 'ARCHITECTURE & MOTION',
                  desc:
                      'Beyond static logos. We engineer adaptive identity systems, custom typography hierarchies, and kinetic motion rules that keep your brand ahead on every screen.',
                  icon: Icons.auto_awesome_motion_rounded,
                  metric: '4x',
                  metricLabel: 'Recall Velocity',
                ),
                const SizedBox(height: 16),
                const _BentoCard(
                  title: 'Commercial Visual Production',
                  kicker: 'FOOD & LIFESTYLE CINEMATOGRAPHY',
                  desc:
                      'Artisanal product styling, macro culinary photography, and cinematic post-production color grading.',
                  icon: Icons.camera_rounded,
                  metric: '100%',
                  metricLabel: 'In-House Studio',
                ),
                const SizedBox(height: 16),
                const _BentoCard(
                  title: 'Omnichannel Growth Loops',
                  kicker: 'RETENTION & CONTENT STRATEGY',
                  desc:
                      'Performance-aware social calendars, viral hooks, and high-converting storytelling loops.',
                  icon: Icons.trending_up_rounded,
                  metric: '7–14d',
                  metricLabel: 'Sprint Cadence',
                ),
                const SizedBox(height: 16),
                const _BentoCard(
                  title: 'Ultra-Fluid Digital Experiences',
                  kicker: 'PERFORMANCE WEB APPLICATION',
                  desc:
                      'Crafted with 60fps micro-animations, Apple-grade responsiveness, and precision conversion pathways.',
                  icon: Icons.devices_rounded,
                  metric: '60fps',
                  metricLabel: 'Fluid UX',
                ),
              ] else ...[
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _BentoCard(
                        title: 'Kinetic Brand Systems & Art Direction',
                        kicker: 'ARCHITECTURE & MOTION',
                        desc:
                            'Beyond static logos. We engineer adaptive identity systems, custom typography hierarchies, and kinetic motion rules that make your brand impossible to ignore.',
                        icon: Icons.auto_awesome_motion_rounded,
                        metric: '4x',
                        metricLabel: 'Recall Velocity',
                      ),
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      flex: 4,
                      child: _BentoCard(
                        title: 'Commercial Visual Production',
                        kicker: 'FOOD & LIFESTYLE SUITE',
                        desc:
                            'Bespoke prop styling, macro food cinematography, and commercial color grading that drives immediate appetite.',
                        icon: Icons.camera_rounded,
                        metric: '100%',
                        metricLabel: 'In-House Craft',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _BentoCard(
                        title: 'Omnichannel Growth Loops',
                        kicker: 'RETENTION & PERFORMANCE',
                        desc:
                            'High-converting content frameworks and distribution cadence that turn passing impressions into compound brand loyalty.',
                        icon: Icons.trending_up_rounded,
                        metric: '7–14d',
                        metricLabel: 'Sprint Cadence',
                      ),
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      flex: 6,
                      child: _BentoCard(
                        title: 'Ultra-Fluid Web & Digital Platforms',
                        kicker: 'APPLE-GRADE PERFORMANCE',
                        desc:
                            'Engineered with 60fps micro-interactions, squircle geometry, and conversion-optimized architectures that perform flawlessly.',
                        icon: Icons.devices_rounded,
                        metric: '60fps',
                        metricLabel: 'Fluid Execution',
                      ),
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _BentoCard extends StatefulWidget {
  const _BentoCard({
    required this.title,
    required this.kicker,
    required this.desc,
    required this.icon,
    required this.metric,
    required this.metricLabel,
  });

  final String title;
  final String kicker;
  final String desc;
  final IconData icon;
  final String metric;
  final String metricLabel;

  @override
  State<_BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<_BentoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translateByDouble(0, _hovered ? -4 : 0, 0, 1),
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: AppColors.surfaceFor(context),
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 22,
              cornerSmoothing: 0.6,
            ),
            side: BorderSide(
              color: _hovered
                  ? AppColors.curveRed.withValues(alpha: isDark ? 0.55 : 0.4)
                  : AppColors.strokeFor(context),
              width: 1.0,
            ),
          ),
          shadows: [
            BoxShadow(
              color: (isDark ? Colors.black : const Color(0xFF101216))
                  .withValues(alpha: isDark ? (_hovered ? 0.35 : 0.18) : (_hovered ? 0.08 : 0.03)),
              blurRadius: _hovered ? 24 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.curveRed
                        .withValues(alpha: isDark ? 0.12 : 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.curveRed
                          .withValues(alpha: isDark ? 0.35 : 0.25),
                      width: 1.0,
                    ),
                  ),
                  child: Icon(widget.icon, color: AppColors.curveRed, size: 20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.metric,
                      style: const TextStyle(
                        color: AppColors.curveRed,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      widget.metricLabel,
                      style: TextStyle(
                        color: AppColors.mutedFor(context),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              widget.kicker,
              style: const TextStyle(
                color: AppColors.curveRed,
                fontWeight: FontWeight.w800,
                fontSize: 10,
                letterSpacing: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    height: 1.2,
                    color: AppColors.textFor(context),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.desc,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.mutedFor(context),
                    height: 1.45,
                    fontSize: 13,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// SECTION 3: STRATEGY COMPARISON ("Straight Lines vs. The Curve")
// =========================================================================
class _StrategyComparisonSection extends StatefulWidget {
  const _StrategyComparisonSection();

  @override
  State<_StrategyComparisonSection> createState() =>
      _StrategyComparisonSectionState();
}

class _StrategyComparisonSectionState extends State<_StrategyComparisonSection> {
  int _selectedMode = 0; // 0: The Creative Curve, 1: Conventional Linear

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isDark = AppColors.isDark(context);
    final double horizontalPadding = isMobile ? 16 : 32;

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 28),
      child: LiquidGlassPanel(
        padding: EdgeInsets.all(isMobile ? 20 : 30),
        borderRadius: 26,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool stack = constraints.maxWidth < 840;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.curveRed.withValues(alpha: isDark ? 0.12 : 0.08),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: AppColors.curveRed.withValues(alpha: isDark ? 0.35 : 0.25),
                          width: 1.0,
                        ),
                      ),
                      child: const Text(
                        'THE STRATEGIC EQUATION',
                        style: TextStyle(
                          color: AppColors.curveRed,
                          fontWeight: FontWeight.w800,
                          fontSize: 10.5,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    // Live Mode Indicator Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : const Color(0xFFEDEFF3),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        _selectedMode == 0
                            ? '● EXPONENTIAL MOMENTUM'
                            : '○ LINEAR DRIFT',
                        style: TextStyle(
                          color: _selectedMode == 0
                              ? AppColors.curveRed
                              : AppColors.mutedFor(context),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Why Conventional Agencies Fail',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.textFor(context),
                      ),
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Text(
                    'Straightforward linear processes yield predictable, easily forgotten outcomes. We engineer non-linear, high-velocity compound brand momentum.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.mutedFor(context),
                          height: 1.5,
                        ),
                  ),
                ),
                const SizedBox(height: 20),

                // Interactive Trajectory Curve Switcher
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    _ModelTab(
                      label: 'The Creative Curve (Our Architecture)',
                      active: _selectedMode == 0,
                      onTap: () => setState(() => _selectedMode = 0),
                    ),
                    _ModelTab(
                      label: 'Conventional Straight Line (Standard Agencies)',
                      active: _selectedMode == 1,
                      onTap: () => setState(() => _selectedMode = 1),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Interactive Trajectory Graph Canvas
                ClipSmoothRect(
                  radius: SmoothBorderRadius(
                    cornerRadius: 18,
                    cornerSmoothing: 0.6,
                  ),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF101014)
                          : const Color(0xFFF3F5F8),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: AppColors.strokeFor(context),
                        width: 1.0,
                      ),
                    ),
                    child: CustomPaint(
                      painter: _TrajectoryCurvePainter(
                        isCurve: _selectedMode == 0,
                        isDark: isDark,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 4,
                            left: 4,
                            child: Text(
                              _selectedMode == 0
                                  ? 'ACCELERATING VELOCITY [CUBIC EXPONENTIAL]'
                                  : 'LINEAR PLATEAU [STANDSTILL]',
                              style: TextStyle(
                                color: _selectedMode == 0
                                    ? AppColors.curveRed
                                    : AppColors.mutedFor(context),
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 4,
                            child: Text(
                              _selectedMode == 0
                                  ? '4.2x Category Retention Velocity'
                                  : '1.0x Slow Baseline Plateau',
                              style: TextStyle(
                                color: _selectedMode == 0
                                    ? AppColors.curveRed
                                    : AppColors.mutedFor(context),
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Strategic Comparison Grid Boxes
                if (stack) ...[
                  _ComparisonBox(
                    isCurve: false,
                    highlighted: _selectedMode == 1,
                    title: 'The Straight Line (Standard Agencies)',
                    subtitle: 'Safe, fragmented, and easily forgotten.',
                    items: const [
                      'Cookie-cutter templates & safe trend imitation',
                      'Fragmented freelancer handoffs and slow turnaround',
                      'Vanity metrics with zero commercial translation',
                      'Rigid, linear processes that stall momentum',
                    ],
                  ),
                  const SizedBox(height: 16),
                  _ComparisonBox(
                    isCurve: true,
                    highlighted: _selectedMode == 0,
                    title: 'The Creative Curve (Our Model)',
                    subtitle: 'Bespoke, interdisciplinary, and category-defining.',
                    items: const [
                      'Bespoke visual architecture that sets new trends',
                      'Dedicated 4-specialist squad working in tight synchronization',
                      'Engineered for measurable revenue velocity and brand equity',
                      'Rapid 7–14 day sprint cycles with uncompromising craft',
                    ],
                  ),
                ] else ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _ComparisonBox(
                          isCurve: false,
                          highlighted: _selectedMode == 1,
                          title: 'The Straight Line (Standard Agencies)',
                          subtitle: 'Safe, fragmented, and easily forgotten.',
                          items: const [
                            'Cookie-cutter templates & safe trend imitation',
                            'Fragmented freelancer handoffs and slow turnaround',
                            'Vanity metrics with zero commercial translation',
                            'Rigid, linear processes that stall momentum',
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _ComparisonBox(
                          isCurve: true,
                          highlighted: _selectedMode == 0,
                          title: 'The Creative Curve (Our Model)',
                          subtitle: 'Bespoke, interdisciplinary, and category-defining.',
                          items: const [
                            'Bespoke visual architecture that sets new trends',
                            'Dedicated 4-specialist squad working in synchronization',
                            'Engineered for revenue velocity and brand equity',
                            'Rapid 7–14 day sprint cycles with elite craft',
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ModelTab extends StatelessWidget {
  const _ModelTab({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: active
                ? (isDark ? const Color(0xFF221617) : const Color(0xFFFFECEB))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: active
                  ? AppColors.curveRed.withValues(alpha: 0.6)
                  : AppColors.strokeFor(context),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: active ? AppColors.curveRed : AppColors.mutedFor(context),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: active ? AppColors.curveRed : AppColors.textFor(context),
                  fontSize: 12.5,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrajectoryCurvePainter extends CustomPainter {
  const _TrajectoryCurvePainter({
    required this.isCurve,
    required this.isDark,
  });

  final bool isCurve;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    // Subtle grid lines
    final Paint gridPaint = Paint()
      ..color = (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    for (double y = 20; y < size.height; y += 35) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    const double startX = 20;
    final double startY = size.height - 30;
    final double endX = size.width - 24;

    if (isCurve) {
      // The Creative Curve: Smooth Exponential Upward Trajectory
      const double endY = 24;
      final double controlX1 = size.width * 0.42;
      final double controlY1 = size.height - 28;
      final double controlX2 = size.width * 0.72;
      final double controlY2 = size.height * 0.35;

      final Path curvePath = Path()
        ..moveTo(startX, startY)
        ..cubicTo(controlX1, controlY1, controlX2, controlY2, endX, endY);

      // Filled gradient area beneath the curve
      final Path fillPath = Path.from(curvePath)
        ..lineTo(endX, size.height)
        ..lineTo(startX, size.height)
        ..close();

      final Paint fillPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.curveRed.withValues(alpha: 0.22),
            AppColors.curveRed.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      canvas.drawPath(fillPath, fillPaint);

      // Vibrant curve stroke
      final Paint strokePaint = Paint()
        ..color = AppColors.curveRed
        ..strokeWidth = 3.2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(curvePath, strokePaint);

      // Trajectory Milestone Dots
      final List<Offset> points = [
        Offset(startX, startY),
        Offset(size.width * 0.44, size.height * 0.76),
        Offset(size.width * 0.74, size.height * 0.38),
        Offset(endX, endY),
      ];

      for (int i = 0; i < points.length; i++) {
        final Offset pt = points[i];
        final bool isLast = i == points.length - 1;

        if (isLast) {
          final Paint glowPaint = Paint()
            ..color = AppColors.curveRed.withValues(alpha: 0.35);
          canvas.drawCircle(pt, 9, glowPaint);
        }

        final Paint dotPaint = Paint()..color = AppColors.curveRed;
        canvas.drawCircle(pt, isLast ? 5.5 : 4.0, dotPaint);

        final Paint innerDot = Paint()..color = Colors.white;
        canvas.drawCircle(pt, isLast ? 2.5 : 1.8, innerDot);
      }
    } else {
      // The Conventional Line: Slow Linear Rise that quickly stalls
      final double endY = size.height * 0.65;
      final double plateauStartX = size.width * 0.48;

      final Path linearPath = Path()
        ..moveTo(startX, startY)
        ..lineTo(plateauStartX, endY)
        ..lineTo(endX, endY);

      final Paint linePaint = Paint()
        ..color = (isDark ? Colors.white60 : Colors.black45)
        ..strokeWidth = 2.4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(linearPath, linePaint);

      final Paint plateauDot = Paint()
        ..color = (isDark ? Colors.white54 : Colors.black45);
      canvas
        ..drawCircle(Offset(plateauStartX, endY), 4, plateauDot)
        ..drawCircle(Offset(endX, endY), 5, plateauDot);
    }
  }

  @override
  bool shouldRepaint(covariant _TrajectoryCurvePainter oldDelegate) {
    return oldDelegate.isCurve != isCurve || oldDelegate.isDark != isDark;
  }
}

class _ComparisonBox extends StatelessWidget {
  const _ComparisonBox({
    required this.isCurve,
    required this.title,
    required this.subtitle,
    required this.items,
    this.highlighted = false,
  });

  final bool isCurve;
  final String title;
  final String subtitle;
  final List<String> items;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: const EdgeInsets.all(22),
      decoration: ShapeDecoration(
        color: isCurve
            ? (isDark ? const Color(0xFF1B1617) : const Color(0xFFFFF7F6))
            : (isDark ? const Color(0xFF121215) : const Color(0xFFF4F6F8)),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 18,
            cornerSmoothing: 0.6,
          ),
          side: BorderSide(
            color: highlighted
                ? (isCurve
                    ? AppColors.curveRed
                    : (isDark ? Colors.white60 : Colors.black54))
                : (isCurve
                    ? AppColors.curveRed.withValues(alpha: isDark ? 0.35 : 0.22)
                    : AppColors.strokeFor(context)),
            width: highlighted ? 1.6 : 1.0,
          ),
        ),
        shadows: highlighted && isCurve
            ? [
                BoxShadow(
                  color: AppColors.curveRed.withValues(alpha: isDark ? 0.25 : 0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCurve ? Icons.check_circle_rounded : Icons.cancel_outlined,
                color: isCurve ? AppColors.curveRed : AppColors.mutedFor(context),
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isCurve ? AppColors.curveRed : AppColors.textFor(context),
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: AppColors.mutedFor(context),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCurve ? '→' : '—',
                    style: TextStyle(
                      color: isCurve ? AppColors.curveRed : AppColors.mutedFor(context),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: AppColors.textFor(context),
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// =========================================================================
// SECTION 4: COMMERCIAL SPOTLIGHT (Solita's Bakehouse)
// =========================================================================
class _CommercialSpotlightSection extends StatelessWidget {
  const _CommercialSpotlightSection();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isDark = AppColors.isDark(context);
    final double horizontalPadding = isMobile ? 16 : 32;

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 28),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool stack = constraints.maxWidth < 940;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.curveRed.withValues(alpha: isDark ? 0.12 : 0.08),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: AppColors.curveRed.withValues(alpha: isDark ? 0.35 : 0.25),
                        width: 1.0,
                      ),
                    ),
                    child: const Text(
                      'FEATURED CLIENT CASE STUDY',
                      style: TextStyle(
                        color: AppColors.curveRed,
                        fontWeight: FontWeight.w800,
                        fontSize: 10.5,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => context.go('/gallery'),
                    icon: const Icon(Icons.arrow_forward_rounded, size: 15),
                    label: const Text(
                      'View All Vault Assets',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Solita’s Bakehouse Commercial Suite',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.textFor(context),
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  'End-to-end commercial culinary and brand packaging production engineered to turn artisanal food concepts into high-engagement cultural icons.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.mutedFor(context),
                        height: 1.5,
                      ),
                ),
              ),
              const SizedBox(height: 24),
              if (stack) ...[
                const AspectRatio(
                  aspectRatio: 16 / 9,
                  child: LiquidGlassImageCard(
                    path: AppAssets.portfolioCulinary,
                    title: 'Solita\'s Bakehouse & Gourmet Showcase',
                    category: 'Commercial Production',
                    description:
                        'Handcrafted croissants, golden tonkatsu, and ceremonial matcha captured with cinematic lighting and custom color grades.',
                    aspectRatio: 16 / 9,
                  ),
                ),
                const SizedBox(height: 18),
                const _ProductionScopeDetails(),
              ] else ...[
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: LiquidGlassImageCard(
                          path: AppAssets.portfolioCulinary,
                          title: 'Solita\'s Bakehouse & Gourmet Showcase',
                          category: 'Commercial Production',
                          description:
                              'Handcrafted croissants, golden tonkatsu, and ceremonial matcha captured with cinematic lighting and custom color grades.',
                          aspectRatio: 16 / 9,
                        ),
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      flex: 5,
                      child: _ProductionScopeDetails(),
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _ProductionScopeDetails extends StatelessWidget {
  const _ProductionScopeDetails();

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    return LiquidGlassPanel(
      padding: const EdgeInsets.all(24),
      borderRadius: 22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.photo_camera_rounded,
                  color: AppColors.curveRed, size: 18),
              const SizedBox(width: 8),
              Text(
                'Production Deliverables',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textFor(context),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'We combine intentional lighting, macro lens calibration, and precise food styling to deliver high-resolution assets ready for billboards, digital campaigns, and social loops.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.mutedFor(context),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Artisanal Food Styling',
              'Macro Photography',
              'Commercial Grading',
              'Packaging Suite',
              'Omnichannel Content Loops',
            ].map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : const Color(0xFFF0F2F5),
                  border: Border.all(color: AppColors.strokeFor(context), width: 1.0),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textFor(context),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: () => context.go('/services'),
            icon: const Icon(Icons.arrow_forward_rounded, size: 15),
            label: const Text('Explore All Disciplines'),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// SECTION 5: EXECUTION BLUEPRINT (4-Phase Engine)
// =========================================================================
class _ExecutionBlueprintSection extends StatelessWidget {
  const _ExecutionBlueprintSection();

  static const List<({String step, String name, String subtitle, String desc})>
      _steps = [
    (
      step: '01',
      name: 'Diagnostic & Immersion',
      subtitle: 'Audit & Market Positioning',
      desc:
          'We dissect your competitive landscape, identify market friction, and pinpoint the unique cultural angle that creates immediate asymmetry.',
    ),
    (
      step: '02',
      name: 'Strategic Architecture',
      subtitle: 'Conceptual Ideation & Tone',
      desc:
          'We establish the core brand narrative, typography guidelines, and visual language that guide all subsequent production without deviation.',
    ),
    (
      step: '03',
      name: 'High-Fidelity Production',
      subtitle: 'Media & Digital Craft',
      desc:
          'Our four specialists execute studio shoots, commercial edits, motion assets, and web applications with meticulous attention to craft.',
    ),
    (
      step: '04',
      name: 'Market Velocity & Growth',
      subtitle: 'Omnichannel Launch',
      desc:
          'We deploy synchronized content loops, campaign assets, and digital touchpoints designed for rapid consumer adoption and long-term brand equity.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isDark = AppColors.isDark(context);
    final double horizontalPadding = isMobile ? 16 : 32;

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.curveRed.withValues(alpha: isDark ? 0.12 : 0.08),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: AppColors.curveRed.withValues(alpha: isDark ? 0.35 : 0.25),
                width: 1.0,
              ),
            ),
            child: const Text(
              'EXECUTION BLUEPRINT',
              style: TextStyle(
                color: AppColors.curveRed,
                fontWeight: FontWeight.w800,
                fontSize: 10.5,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'From Concept to Market Velocity',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.textFor(context),
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'A rigorous, four-phase sprint engine that eliminates ambiguity and guarantees category-defining execution on schedule.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.mutedFor(context),
                    height: 1.5,
                  ),
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final int cols = constraints.maxWidth < 700
                  ? 1
                  : (constraints.maxWidth < 1100 ? 2 : 4);
              const double gap = 16;
              final double cardWidth =
                  (constraints.maxWidth - gap * (cols - 1)) / cols;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: _steps.map((step) {
                  return SizedBox(
                    width: cardWidth,
                    child: LiquidGlassPanel(
                      padding: const EdgeInsets.all(20),
                      borderRadius: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.curveRed
                                  .withValues(alpha: isDark ? 0.12 : 0.08),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.curveRed
                                    .withValues(alpha: isDark ? 0.35 : 0.25),
                                width: 1.0,
                              ),
                            ),
                            child: Text(
                              step.step,
                              style: const TextStyle(
                                color: AppColors.curveRed,
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            step.name,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: AppColors.textFor(context),
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            step.subtitle,
                            style: const TextStyle(
                              color: AppColors.curveRed,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            step.desc,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.mutedFor(context),
                                  height: 1.4,
                                  fontSize: 12.5,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// SECTION 6: BRAND MANIFESTO & CORE VALUES ("We Set Them")
// =========================================================================
class _BrandManifestoSection extends StatelessWidget {
  const _BrandManifestoSection();

  static const List<({String num, String title, String desc})> _values = [
    (
      num: '01',
      title: 'Transparent',
      desc: 'No fluff, no shortcuts. Just rigorous strategies that deliver real market outcomes.',
    ),
    (
      num: '02',
      title: 'Respectful',
      desc: 'Deep collaboration is fundamental. We listen, adapt, and build alongside our partners.',
    ),
    (
      num: '03',
      title: 'Data-Driven',
      desc: 'Every creative decision is rooted in clear insights. We calculate rather than speculate.',
    ),
    (
      num: '04',
      title: 'Purpose-Driven',
      desc: 'Creativity with deliberate direction. We craft stories and visual systems that matter.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isDark = AppColors.isDark(context);
    final double horizontalPadding = isMobile ? 16 : 32;

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 28),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool stack = constraints.maxWidth < 940;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.curveRed.withValues(alpha: isDark ? 0.12 : 0.08),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: AppColors.curveRed.withValues(alpha: isDark ? 0.35 : 0.25),
                    width: 1.0,
                  ),
                ),
                child: const Text(
                  'BRAND MANIFESTO',
                  style: TextStyle(
                    color: AppColors.curveRed,
                    fontWeight: FontWeight.w800,
                    fontSize: 10.5,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We Don\'t Just Follow Trends — We Set Them.',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.textFor(context),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 24),
              if (stack) ...[
                const AspectRatio(
                  aspectRatio: 16 / 9,
                  child: LiquidGlassImageCard(
                    path: AppAssets.valuesManifesto,
                    title: 'Values Manifesto',
                    category: 'Core Values',
                    description:
                        'The 4 pillars of Creative Curve: Transparent, Respectful, Data-driven, Purpose-driven.',
                    aspectRatio: 16 / 9,
                  ),
                ),
                const SizedBox(height: 18),
                const _ValuesList(values: _values),
              ] else ...[
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: LiquidGlassImageCard(
                          path: AppAssets.valuesManifesto,
                          title: 'Values Manifesto',
                          category: 'Core Values',
                          description:
                              'The 4 pillars of Creative Curve: Transparent, Respectful, Data-driven, Purpose-driven.',
                          aspectRatio: 16 / 9,
                        ),
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      flex: 5,
                      child: _ValuesList(values: _values),
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _ValuesList extends StatelessWidget {
  const _ValuesList({required this.values});

  final List<({String num, String title, String desc})> values;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: values.map((val) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: LiquidGlassPanel(
            padding: const EdgeInsets.all(16),
            borderRadius: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  val.num,
                  style: const TextStyle(
                    color: AppColors.curveRed,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        val.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textFor(context),
                              fontSize: 15,
                            ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        val.desc,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.mutedFor(context),
                              height: 1.35,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// =========================================================================
// SECTION 7: MEET THE CRAFTERS COLLECTIVE
// =========================================================================
class _CraftersSquadSection extends ConsumerWidget {
  const _CraftersSquadSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isDark = AppColors.isDark(context);
    final double horizontalPadding = isMobile ? 16 : 32;
    final List<TeamMember> members = ref.watch(teamMembersProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 28),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final int memberCols = constraints.maxWidth < 720 ? 2 : 4;
          const double gap = 16;
          final double tileWidth =
              (constraints.maxWidth - (gap * (memberCols - 1))) / memberCols;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.curveRed.withValues(alpha: isDark ? 0.12 : 0.08),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: AppColors.curveRed.withValues(alpha: isDark ? 0.35 : 0.25),
                        width: 1.0,
                      ),
                    ),
                    child: const Text(
                      'THE SPECIALISTS',
                      style: TextStyle(
                        color: AppColors.curveRed,
                        fontWeight: FontWeight.w800,
                        fontSize: 10.5,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => context.go('/team'),
                    icon: const Icon(Icons.arrow_forward_rounded, size: 15),
                    label: const Text(
                      'Meet Full Squad',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'The Specialists Behind The Curve',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.textFor(context),
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 24),

              // 4 Member Quick Previews
              Wrap(
                spacing: gap,
                runSpacing: gap,
                children: members.map((member) {
                  return SizedBox(
                    width: tileWidth,
                    child: AspectRatio(
                      aspectRatio: 1.05,
                      child: LiquidGlassImageCard(
                        path: member.imagePath,
                        title: member.name,
                        category: member.role,
                        description: member.personality,
                        aspectRatio: 16 / 9,
                        onTap: () => context.go('/team'),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =========================================================================
// SECTION 8: macOS-STYLE STUDIO TERMINAL CTA BANNER
// =========================================================================
class _StudioTerminalCtaSection extends StatelessWidget {
  const _StudioTerminalCtaSection();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isDark = AppColors.isDark(context);
    final double horizontalPadding = isMobile ? 16 : 32;

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 28),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: AppColors.surfaceFor(context),
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 24,
              cornerSmoothing: 0.6,
            ),
            side: BorderSide(
              color: AppColors.curveRed.withValues(alpha: isDark ? 0.45 : 0.3),
              width: 1.0,
            ),
          ),
          shadows: [
            BoxShadow(
              color: (isDark ? Colors.black : const Color(0xFF101216))
                  .withValues(alpha: isDark ? 0.35 : 0.05),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Window Header Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF16161B)
                    : const Color(0xFFE9ECF1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(23)),
                border: Border(
                  bottom: BorderSide(color: AppColors.strokeFor(context), width: 1.0),
                ),
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF5F56),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFBD2E),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          color: Color(0xFF27C93F),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'curve_initiative.terminal',
                    style: TextStyle(
                      color: AppColors.mutedFor(context),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Window Content
            Padding(
              padding: EdgeInsets.all(isMobile ? 22 : 36),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final bool compact = constraints.maxWidth < 760;

                  if (compact) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            AppAssets.createTheCurveSlogan,
                            height: 56,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Ready to refuse straight lines?',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: AppColors.textFor(context),
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Let\'s build a digital presence, brand system, and campaign architecture that keeps your brand undeniably ahead.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.mutedFor(context),
                                height: 1.5,
                              ),
                        ),
                        const SizedBox(height: 20),
                        FilledButton.icon(
                          onPressed: () => context.go('/contacts'),
                          icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                          label: const Text('Start Your Project'),
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                AppAssets.createTheCurveSlogan,
                                height: 56,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Ready to refuse straight lines?',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textFor(context),
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Let\'s build a digital presence, brand system, and campaign architecture that keeps your brand undeniably ahead.',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.mutedFor(context),
                                    height: 1.5,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      FilledButton.icon(
                        onPressed: () => context.go('/contacts'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 26,
                            vertical: 16,
                          ),
                        ),
                        icon: const Icon(Icons.arrow_forward_rounded, size: 17),
                        label: const Text(
                          'Start Your Project',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}