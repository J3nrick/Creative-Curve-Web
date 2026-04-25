import 'dart:async';

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
            ? 26
            : 34;

    final double topPadding = isMobile ? 10 : 18;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        topPadding,
        horizontalPadding,
        isMobile ? 20 : 34,
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool compact = constraints.maxWidth < 980;
          final bool tiny = constraints.maxWidth < 420;
          final double desktopHeight = constraints.maxWidth < 1180 ? 600 : 640;

          if (compact) {
            return Container(
              padding: EdgeInsets.fromLTRB(
                tiny ? 14 : 18,
                18,
                tiny ? 14 : 18,
                tiny ? 14 : 18,
              ),
              decoration: ShapeDecoration(
                color: AppColors.surfaceFor(context),
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 24,
                    cornerSmoothing: 0.6,
                  ),
                  side: BorderSide(color: AppColors.strokeFor(context)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const _HeroCopy(compact: true),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: tiny ? 220 : 250,
                    width: double.infinity,
                    child: const _HeroVisualDeck(),
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
                          cornerRadius: 30,
                          cornerSmoothing: 0.6,
                        ),
                        side: BorderSide(color: AppColors.strokeFor(context)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 30,
                  bottom: 30,
                  width: constraints.maxWidth * 0.58,
                  child: const _HeroCopy(compact: false),
                ),
                Positioned(
                  right: 22,
                  top: 22,
                  bottom: 22,
                  width: constraints.maxWidth * 0.38,
                  child: const _HeroVisualDeck(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFFF3B30), Color(0xFFF5F5F7)],
            ).createShader(bounds);
          },
          child: Text(
            'Designing momentum for brands that refuse straight lines.',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontSize: compact ? 38 : 66,
                  height: compact ? 1.04 : 0.95,
                  letterSpacing: -1.1,
                ),
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            'Creative Curve Studios fuses strategic storytelling, visual systems, and performance engineering into one polished digital arc.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.mutedFor(context),
                  height: 1.55,
                ),
          ),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: <Widget>[
            _HeroActionButton(
              label: 'View Services',
              onTap: () => context.go('/services'),
            ),
            _HeroActionButton(
              label: 'Meet Team',
              outlined: true,
              onTap: () => context.go('/team'),
            ),
          ],
        ),
        if (!compact) ...<Widget>[
          const Spacer(),
          Text(
            '60 / 40 asymmetry keeps hierarchy clear while preserving depth across desktop and mobile.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.mutedFor(context),
                ),
          ),
        ],
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 26,
            cornerSmoothing: 0.6,
          ),
          side: BorderSide(color: AppColors.strokeFor(context)),
        ),
        gradient: AppColors.isDark(context)
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF101012), Color(0xFF1A1314)],
              )
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFFECEFF3), Color(0xFFFDFDFE)],
              ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -40,
            right: -35,
            child: _GlowOrb(
              size: 190,
              color: AppColors.curveRed.withValues(alpha: 0.22),
            ),
          ),
          Positioned(
            bottom: -55,
            left: -35,
            child: _GlowOrb(
              size: 210,
              color: AppColors.textFor(context).withValues(alpha: 0.08),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroVisualDeck extends StatefulWidget {
  const _HeroVisualDeck();

  @override
  State<_HeroVisualDeck> createState() => _HeroVisualDeckState();
}

class _HeroVisualDeckState extends State<_HeroVisualDeck> {
  static const Duration _holdDuration = Duration(milliseconds: 4600);
  static const Duration _transitionDuration = Duration(milliseconds: 900);

  late final Timer _timer;
  int _index = 0;

  static const List<String> _labels = <String>[
    'Discover',
    'Brand',
    'Predictable',
    'Who Are We',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_holdDuration, (_) {
      if (!mounted) {
        return;
      }
      setState(() => _index = (_index + 1) % _labels.length);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _HeroVisual(
      child: Column(
        children: <Widget>[
          Expanded(
            child: AnimatedSwitcher(
              duration: _transitionDuration,
              reverseDuration: const Duration(milliseconds: 650),
              switchInCurve: Curves.easeOutQuart,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (Widget child, Animation<double> animation) {
                final Animation<Offset> slide = Tween<Offset>(
                  begin: const Offset(0.14, 0),
                  end: Offset.zero,
                ).animate(animation);

                final Animation<double> fade = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                );

                final Animation<double> scale = Tween<double>(
                  begin: 0.98,
                  end: 1,
                ).animate(animation);

                return FadeTransition(
                  opacity: fade,
                  child: SlideTransition(
                    position: slide,
                    child: ScaleTransition(scale: scale, child: child),
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey<int>(_index),
                child: _buildFrame(context, _index),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: List<Widget>.generate(_labels.length, (int i) {
              final bool active = i == _index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                margin: const EdgeInsets.only(right: 6),
                width: active ? 22 : 8,
                height: 6,
                decoration: BoxDecoration(
                  color: active
                      ? AppColors.curveRed
                      : AppColors.textFor(context).withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(999),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFrame(BuildContext context, int index) {
    switch (index) {
      case 0:
        return const _DiscoverCurveFrame();
      case 1:
        return const _BrandLogoFrame();
      case 2:
        return const _PredictableFrame();
      default:
        return const _WhoAreWeFrame();
    }
  }
}

class _DiscoverCurveFrame extends StatelessWidget {
  const _DiscoverCurveFrame();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool narrow = constraints.maxWidth < 260;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'discover\ncurve',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.curveRed,
                    fontSize: narrow ? 36 : 48,
                    height: 0.92,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Digital creative agency driven by storytellers and strategists.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textFor(context),
                        ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Our approach is not about taking the easy route.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.mutedFor(context),
                        ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Text.rich(
                const TextSpan(
                  children: <InlineSpan>[
                    TextSpan(text: 'A unique path that keeps '),
                    TextSpan(
                      text: 'your brand',
                      style: TextStyle(
                        color: AppColors.curveRed,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(text: ' ahead.'),
                  ],
                ),
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textFor(context),
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BrandLogoFrame extends StatelessWidget {
  const _BrandLogoFrame();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.curveRed.withValues(alpha: 0.96),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'creative',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'curve',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 92,
                    height: 0.9,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'studios',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}

class _PredictableFrame extends StatelessWidget {
  const _PredictableFrame();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 330,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'because straightforward',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.curveRed,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 1.3,
                height: 72,
                color: AppColors.curveRed.withValues(alpha: 0.8),
              ),
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'is ',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textFor(context),
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    TextSpan(
                      text: 'too',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.curveRed,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    TextSpan(
                      text: ' predictable.',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textFor(context),
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhoAreWeFrame extends StatelessWidget {
  const _WhoAreWeFrame();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'who\nare\nwe?',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.curveRed,
                  fontSize: 62,
                  height: 0.9,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text.rich(
                const TextSpan(
                  children: <InlineSpan>[
                    TextSpan(text: 'in a world where brands follow the '),
                    TextSpan(
                      text: 'same',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    TextSpan(text: ' paths'),
                  ],
                ),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textFor(context),
                    ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 64,
                height: 1.2,
                color: AppColors.curveRed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color,
            blurRadius: 80,
            spreadRadius: 8,
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
  });

  final String label;
  final VoidCallback onTap;
  final bool outlined;

  @override
  State<_HeroActionButton> createState() => _HeroActionButtonState();
}

class _HeroActionButtonState extends State<_HeroActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _hovered = true);
      },
      onExit: (_) {
        setState(() => _hovered = false);
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        scale: _hovered ? 1.02 : 1,
        child: widget.outlined
            ? OutlinedButton(onPressed: widget.onTap, child: Text(widget.label))
            : FilledButton(onPressed: widget.onTap, child: Text(widget.label)),
      ),
    );
  }
}
