import 'package:creative_curve_web/core/constants/app_assets.dart';
import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/widgets/liquid_glass_image_card.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServiceGridScreen extends StatelessWidget {
  const ServiceGridScreen({super.key});

  static const List<({String title, String summary, IconData icon})> _items =
      <({String title, String summary, IconData icon})>[
    (
      title: 'Design Creation & Direction',
      summary:
          'High-impact brand assets, campaign concepts, and visual design systems that stay sharp and cohesive across every touchpoint.',
      icon: Icons.palette_rounded,
    ),
    (
      title: 'Film and Video Editing',
      summary:
          'Editorial rhythm, cinematic color grading, seamless pacing, and polish for commercials, brand films, and social narratives.',
      icon: Icons.movie_filter_rounded,
    ),
    (
      title: 'Motion Graphics and Animation',
      summary:
          'High-clarity kinetic systems, title sequences, and animated brand moments crafted with deliberate tempo and elegance.',
      icon: Icons.animation_rounded,
    ),
    (
      title: 'Social Media Strategy & Loops',
      summary:
          'Calendar orchestration, platform-specific creative direction, and performance-aware content loops that sustain engagement.',
      icon: Icons.trending_up_rounded,
    ),
    (
      title: 'Website & Digital Experience',
      summary:
          'Responsive, high-speed web experiences tuned for storytelling, fluid micro-interactions, and conversion-ready clarity.',
      icon: Icons.devices_rounded,
    ),
    (
      title: 'Brand Identity and Positioning',
      summary:
          'Naming, voice frameworks, typography guidelines, and visual rules that make your message unmistakably authoritative.',
      icon: Icons.auto_awesome_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool compact = constraints.maxWidth < 980;
        final int columns = constraints.maxWidth >= 1280
            ? 3
            : constraints.maxWidth >= 780
                ? 2
                : 1;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              compact ? 20 : 44,
              compact ? 24 : 36,
              compact ? 20 : 44,
              48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Header Pill
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.curveRed.withValues(alpha: isDark ? 0.12 : 0.08),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: AppColors.curveRed.withValues(alpha: isDark ? 0.35 : 0.25),
                          width: 1.0,
                        ),
                      ),
                      child: const Text(
                        'CAPABILITIES & SERVICES',
                        style: TextStyle(
                          color: AppColors.curveRed,
                          fontWeight: FontWeight.w800,
                          fontSize: 10.5,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Minimal Form. Maximum Intent.',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.textFor(context),
                      ),
                ),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 780),
                  child: Text(
                    'We engineer end-to-end creative solutions bridging strategic positioning, high-end visual production, and flawless digital execution.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.mutedFor(context),
                          height: 1.5,
                        ),
                  ),
                ),
                const SizedBox(height: 28),

                // Connected Visual Framework Highlights
                _ServiceVisualHighlights(compact: compact),
                const SizedBox(height: 38),

                // Services Grid
                Text(
                  'Core Disciplines',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textFor(context),
                      ),
                ),
                const SizedBox(height: 18),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: columns == 1
                        ? 1.85
                        : (columns == 2 ? 1.28 : 1.18),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final item = _items[index];
                    return _ServiceOutlineCard(
                      title: item.title,
                      summary: item.summary,
                      icon: item.icon,
                    );
                  },
                ),

                const SizedBox(height: 48),

                // Footer CTA Banner
                _ServiceFooterCta(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ServiceVisualHighlights extends StatelessWidget {
  const _ServiceVisualHighlights({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return const Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: LiquidGlassImageCard(
              path: AppAssets.portfolioCulinary,
              title: 'Photo & Video Production Suite',
              category: 'Media Production',
              description:
                  'High-clarity commercial culinary and product cinematography.',
              aspectRatio: 16 / 9,
            ),
          ),
          SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: LiquidGlassImageCard(
              path: AppAssets.labPillars,
              title: 'Transformation, Momentum, Influence',
              category: 'Strategy & Growth',
              description:
                  'Our 3-pillar framework ensuring measurable ROI on creative execution.',
              aspectRatio: 16 / 9,
            ),
          ),
        ],
      );
    }

    return const Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: LiquidGlassImageCard(
              path: AppAssets.portfolioCulinary,
              title: 'Photo & Video Production Suite',
              category: 'Media Production',
              description:
                  'High-clarity commercial culinary and product cinematography.',
              aspectRatio: 16 / 9,
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: LiquidGlassImageCard(
              path: AppAssets.labPillars,
              title: 'Transformation, Momentum, Influence',
              category: 'Strategy & Growth',
              description:
                  'Our 3-pillar framework ensuring measurable ROI on creative execution.',
              aspectRatio: 16 / 9,
            ),
          ),
        ),
      ],
    );
  }
}

class _ServiceOutlineCard extends StatefulWidget {
  const _ServiceOutlineCard({
    required this.title,
    required this.summary,
    required this.icon,
  });

  final String title;
  final String summary;
  final IconData icon;

  @override
  State<_ServiceOutlineCard> createState() => _ServiceOutlineCardState();
}

class _ServiceOutlineCardState extends State<_ServiceOutlineCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go('/contacts'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translateByDouble(0.0, _hovered ? -4.0 : 0.0, 0.0, 1.0),
          padding: const EdgeInsets.all(22),
          decoration: ShapeDecoration(
            color: AppColors.elevatedSurfaceFor(context),
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 22,
                cornerSmoothing: 0.6,
              ),
              side: BorderSide(
                color: _hovered
                    ? AppColors.curveRed.withValues(alpha: isDark ? 0.6 : 0.45)
                    : AppColors.strokeFor(context),
                width: 1.0,
              ),
            ),
            shadows: [
              BoxShadow(
                color: (isDark ? Colors.black : const Color(0xFF101216))
                    .withValues(alpha: isDark ? (_hovered ? 0.35 : 0.18) : (_hovered ? 0.08 : 0.03)),
                blurRadius: _hovered ? 24 : 10,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.curveRed.withValues(alpha: isDark ? 0.12 : 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.curveRed.withValues(alpha: isDark ? 0.35 : 0.25),
                        width: 1.0,
                      ),
                    ),
                    child: Icon(
                      widget.icon,
                      color: AppColors.curveRed,
                      size: 20,
                    ),
                  ),
                  if (_hovered)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.curveRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                      height: 1.2,
                      color: AppColors.textFor(context),
                    ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  widget.summary,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.mutedFor(context),
                        height: 1.45,
                      ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Inquire Scope',
                    style: TextStyle(
                      color: _hovered
                          ? AppColors.curveRed
                          : AppColors.textFor(context),
                      fontWeight: FontWeight.w700,
                      fontSize: 12.5,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 13,
                    color: _hovered
                        ? AppColors.curveRed
                        : AppColors.mutedFor(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceFooterCta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: ShapeDecoration(
        color: AppColors.surfaceFor(context),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 22,
            cornerSmoothing: 0.6,
          ),
          side: BorderSide(color: AppColors.strokeFor(context), width: 1.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Have a custom project scope in mind?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textFor(context),
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'We assemble bespoke multidisciplinary project teams tailored to your exact business objectives.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.mutedFor(context),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          FilledButton.icon(
            onPressed: () => context.go('/contacts'),
            icon: const Icon(Icons.mail_outline_rounded, size: 15),
            label: const Text('Contact Studio'),
          ),
        ],
      ),
    );
  }
}