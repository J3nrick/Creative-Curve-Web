import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/features/hero/application/hero_scroll_state.dart';
import 'package:creative_curve_web/shared/widgets/curve_logo.dart';
import 'package:creative_curve_web/shared/widgets/mac_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return CustomScrollView(
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

        // TRUST BAR (Client Logos / Social Proof)
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
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: horizontalPadding),
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

// --- FEATURED WORK ---

class _FeaturedPreview extends StatelessWidget {
  const _FeaturedPreview();

  @override
  Widget build(BuildContext context) {
    final bool compact = MediaQuery.sizeOf(context).width < 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Featured Work', style: Theme.of(context).textTheme.headlineMedium),
            TextButton(onPressed: () {}, child: const Text('View All Projects →')),
          ],
        ),
        const SizedBox(height: 32),
        if (compact)
          const Column(
            children: [
              _WorkCard(title: 'Cyber-Identity 2025', category: 'Branding'),
              SizedBox(height: 16),
              _WorkCard(title: 'Minimalist Motion', category: 'VFX'),
            ],
          )
        else
          const Row(
            children: [
              Expanded(child: _WorkCard(title: 'Cyber-Identity 2025', category: 'Branding')),
              SizedBox(width: 24),
              Expanded(child: _WorkCard(title: 'Minimalist Motion', category: 'VFX')),
            ],
          ),
      ],
    );
  }
}

class _WorkCard extends StatelessWidget {
  const _WorkCard({required this.title, required this.category});
  final String title;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 300,
            width: double.infinity,
            color: AppColors.mutedFor(context).withValues(alpha: 0.1),
            child: const Icon(Icons.image_outlined, size: 48),
          ),
        ),
        const SizedBox(height: 16),
        Text(category, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.curveRed)),
        Text(title, style: Theme.of(context).textTheme.titleLarge),
      ],
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
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CurveLogo(height: 42, semanticLabel: 'Creative Curve logo'),
        const SizedBox(height: 12),
        Text(widget.subtitle, style: textTheme.labelLarge?.copyWith(color: AppColors.mutedFor(context))),
        const SizedBox(height: 16),
        Text(
          widget.title,
          style: textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w900,
            height: 1.1,
            color: AppColors.textFor(context),
          ),
        ),
        const SizedBox(height: 32),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
            decoration: BoxDecoration(
              color: _hovered ? AppColors.curveRed : AppColors.charcoal,
              borderRadius: BorderRadius.circular(999),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: AppColors.curveRed.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            child: Text(
              'VIEW THE CURVE DECK',
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}