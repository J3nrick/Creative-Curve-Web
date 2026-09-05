import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/features/hero/application/hero_scroll_state.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
import 'package:creative_curve_web/shared/widgets/curve_logo.dart';
import 'package:creative_curve_web/shared/widgets/mac_cached_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HeroScreen extends ConsumerStatefulWidget {
  const HeroScreen({super.key});

  @override
  ConsumerState<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends ConsumerState<HeroScreen> {
  final ScrollController _scrollController = ScrollController();

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
    ref
        .read(heroScrollOffsetProvider.notifier)
        .setOffset(_scrollController.offset);
  }

  @override
  Widget build(BuildContext context) {
    final bool compact = MediaQuery.sizeOf(context).width < 980;
    final double horizontalPadding = compact ? 24 : 56;

    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            // HERO SECTION
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: compact ? 40 : 80,
                ),
                child: compact ? const _HeroCompact() : const _HeroDesktop(),
              ),
            ),

            // TRUST & IMPACT BAR
            SliverToBoxAdapter(child: _TrustBar(horizontalPadding: horizontalPadding)),

            // FEATURED WORK SECTION
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 80,
                ),
                child: const _FeaturedPreview(),
              ),
            ),

            // ADD BOTTOM PADDING
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        ),
        // FLOATING SCROLL INDICATOR
        const Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: Center(child: _ScrollDownIndicator()),
        ),
      ],
    );
  }
}

// --- HERO COMPONENTS ---

class _HeroDesktop extends StatelessWidget {
  const _HeroDesktop();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: _EditorialCopy(
            title: 'Because\nstraightforward\nis too\npredictable.',
            subtitle: 'Creative Curve Studios',
          ),
        ),
        SizedBox(width: 42),
        Expanded(
          flex: 6,
          child: Align(
            alignment: Alignment.centerRight,
            child: MacCachedImage(
              imageUrl: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=1600&q=80',
              height: 520,
              width: 780,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroCompact extends StatelessWidget {
  const _HeroCompact();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _EditorialCopy(
          title: 'Because straightforward\nis too predictable.',
          subtitle: 'Creative Curve Studios',
        ),
        SizedBox(height: 32),
        MacCachedImage(
          imageUrl: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=1600&q=80',
          height: 340,
          width: 800,
        ),
      ],
    );
  }
}

// --- TRUST BAR ---

class _TrustBar extends StatelessWidget {
  const _TrustBar({required this.horizontalPadding});
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 48, horizontal: horizontalPadding),
      color: AppColors.isDark(context) ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.02),
      child: Column(
        children: [
          Text(
            'TRUSTED BY INNOVATORS AT',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              letterSpacing: 2,
              color: AppColors.mutedFor(context),
            ),
          ),
          const SizedBox(height: 32),
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 48,
            runSpacing: 24,
            children: [
              _BrandPlaceholder(name: 'STARK'),
              _BrandPlaceholder(name: 'WAYNE'),
              _BrandPlaceholder(name: 'CYBER'),
              _BrandPlaceholder(name: 'NEXUS'),
            ],
          ),
          const SizedBox(height: 48),
          // IMPACT METRICS
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 32,
            runSpacing: 24,
            children: <Widget>[
              _ImpactMetric(
                metric: '50+',
                label: 'Projects Delivered',
              ),
              _ImpactMetric(
                metric: '100%',
                label: 'On-Time Completion',
              ),
              _ImpactMetric(
                metric: '12+',
                label: 'Years Experience',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BrandPlaceholder extends StatelessWidget {
  const _BrandPlaceholder({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w900,
        color: AppColors.mutedFor(context).withValues(alpha: 0.4),
      ),
    );
  }
}

// --- IMPACT METRIC ---

class _ImpactMetric extends StatelessWidget {
  const _ImpactMetric({
    required this.metric,
    required this.label,
  });

  final String metric;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          metric,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.curveRed,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppColors.mutedFor(context),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// --- FEATURED WORK ---

class _FeaturedPreview extends StatelessWidget {
  const _FeaturedPreview();

  static const List<({String path, String title, String category})> _items =
      <({String path, String title, String category})>[
    (
      path: 'assets/gallery/01_lifestyle_grid.png',
      title: 'Lifestyle & Product Stories',
      category: 'Photography',
    ),
    (
      path: 'assets/gallery/02_food_grid.png',
      title: 'Culinary Visual Systems',
      category: 'Food',
    ),
    (
      path: 'assets/gallery/07_team_group.png',
      title: 'We Take the Curve',
      category: 'Studio',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final int columns = ResponsiveLayout.columnsFor(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Featured Work',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.textFor(context),
                  ),
            ),
            TextButton(
              onPressed: () => context.go('/gallery'),
              child: const Text('View All Projects →'),
            ),
          ],
        ),
        SizedBox(height: ResponsiveLayout.space(4)),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double gap = ResponsiveLayout.space(3);
            final int cols = columns.clamp(1, 3);
            final double tileWidth =
                (constraints.maxWidth - gap * (cols - 1)) / cols;

            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: _items.map((item) {
                return SizedBox(
                  width: cols == 1 ? constraints.maxWidth : tileWidth,
                  child: _WorkCard(
                    path: item.path,
                    title: item.title,
                    category: item.category,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _WorkCard extends StatefulWidget {
  const _WorkCard({
    required this.path,
    required this.title,
    required this.category,
  });

  final String path;
  final String title;
  final String category;

  @override
  State<_WorkCard> createState() => _WorkCardState();
}

class _WorkCardState extends State<_WorkCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        scale: _hovered ? 1.02 : 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    DecoratedBox(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppColors.curveRed.withValues(alpha: 0.12),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      widget.path,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      frameBuilder: (
                        BuildContext context,
                        Widget child,
                        int? frame,
                        bool wasSynchronouslyLoaded,
                      ) {
                        if (wasSynchronouslyLoaded || frame != null) {
                          return AnimatedOpacity(
                            opacity: 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutCubic,
                            child: child,
                          );
                        }
                        return ColoredBox(
                          color: AppColors.mutedFor(context)
                              .withValues(alpha: 0.1),
                        );
                      },
                      errorBuilder: (_, __, ___) => ColoredBox(
                        color:
                            AppColors.mutedFor(context).withValues(alpha: 0.1),
                        child: Icon(
                          Icons.image_outlined,
                          size: 48,
                          color: AppColors.mutedFor(context),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(
                              alpha: AppColors.isDark(context) ? 0.18 : 0.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ResponsiveLayout.space(2)),
            Text(
              widget.category,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.curveRed,
                  ),
            ),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textFor(context),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- EDITORIAL COPY ---

class _EditorialCopy extends StatefulWidget {
  const _EditorialCopy({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  State<_EditorialCopy> createState() => _EditorialCopyState();
}

class _EditorialCopyState extends State<_EditorialCopy> {
  bool _primaryHovered = false;
  bool _secondaryHovered = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CurveLogo(height: 42, semanticLabel: 'Creative Curve logo'),
        const SizedBox(height: 12),
        Text(
          widget.subtitle,
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.mutedFor(context),
          ),
        ),
        const SizedBox(height: 24),
        // DISPLAY HEADING WITH FIXED LINE-HEIGHT
        Text(
          widget.title,
          style: textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w900,
            height: 1.15, // Fixed line-height to prevent descender overlap
            letterSpacing: -0.5,
            color: AppColors.textFor(context),
          ),
        ),
        const SizedBox(height: 40),
        // BUTTON HIERARCHY: PRIMARY + SECONDARY
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: <Widget>[
            // PRIMARY BUTTON - RED CTA
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _primaryHovered = true),
              onExit: (_) => setState(() => _primaryHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                transform: Matrix4.translationValues(0, _primaryHovered ? -6 : 0, 0),
                decoration: BoxDecoration(
                  color: AppColors.curveRed,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: _primaryHovered
                      ? [
                          BoxShadow(
                            color: AppColors.curveRed.withValues(alpha: 0.4),
                            blurRadius: 28,
                            offset: const Offset(0, 12),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: AppColors.curveRed.withValues(alpha: 0.25),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: GestureDetector(
                  onTap: () => context.go('/services'),
                  child: Text(
                    'View Services',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            // SECONDARY BUTTON - GLASS STROKE
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _secondaryHovered = true),
              onExit: (_) => setState(() => _secondaryHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                transform: Matrix4.translationValues(0, _secondaryHovered ? -6 : 0, 0),
                decoration: ShapeDecoration(
                  color: _secondaryHovered
                      ? AppColors.textFor(context).withValues(alpha: 0.08)
                      : AppColors.textFor(context).withValues(alpha: 0.04),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 16,
                      cornerSmoothing: 0.6,
                    ),
                    side: BorderSide(
                      color: AppColors.textFor(context).withValues(
                        alpha: _secondaryHovered ? 0.3 : 0.15,
                      ),
                      width: 1.5,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                child: GestureDetector(
                  onTap: () => context.go('/team'),
                  child: Text(
                    'Meet Team',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textFor(context),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// --- SCROLL DOWN INDICATOR ---

class _ScrollDownIndicator extends StatefulWidget {
  const _ScrollDownIndicator();

  @override
  State<_ScrollDownIndicator> createState() => _ScrollDownIndicatorState();
}

class _ScrollDownIndicatorState extends State<_ScrollDownIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Scroll Down',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.mutedFor(context),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: child,
            );
          },
          child: Icon(
            Icons.arrow_downward_rounded,
            size: 20,
            color: AppColors.mutedFor(context).withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}