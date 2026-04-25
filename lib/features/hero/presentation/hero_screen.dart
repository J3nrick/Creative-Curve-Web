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

    return CustomScrollView(
      controller: _scrollController,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: <Widget>[
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 24 : 56,
              vertical: compact ? 22 : 44,
            ),
            child: compact ? const _HeroCompact() : const _HeroDesktop(),
          ),
        ),
      ],
    );
  }
}

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
              imageUrl:
                  'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=1600&q=80',
              height: 620,
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
        SizedBox(height: 18),
        MacCachedImage(
          imageUrl:
              'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=1600&q=80',
          height: 340,
          width: 800,
        ),
      ],
    );
  }
}

class _EditorialCopy extends StatefulWidget {
  const _EditorialCopy({
    required this.title,
    required this.subtitle,
  });

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
        const CurveLogo(
          height: 42,
          semanticLabel: 'Creative Curve logo',
        ),
        const SizedBox(height: 10),
        Text(widget.subtitle, style: textTheme.labelLarge),
        const SizedBox(height: 14),
        Text(
          widget.title,
          style: textTheme.displayLarge,
        ),
        const SizedBox(height: 26),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            transform: Matrix4.identity()
              ..translateByDouble(0.0, _hovered ? -2.0 : 0.0, 0.0, 1.0),
            decoration: BoxDecoration(
              color: _hovered ? AppColors.curveRed : AppColors.charcoal,
              borderRadius: BorderRadius.circular(999),
              boxShadow: _hovered
                  ? const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x1AE63946),
                        blurRadius: 18,
                        offset: Offset(0, 8),
                      ),
                    ]
                  : const <BoxShadow>[],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              'VIEW THE CURVE DECK',
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
