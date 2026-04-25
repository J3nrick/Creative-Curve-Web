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
    // Added width constraint to prevent horizontal stretching
    width: double.infinity,
    padding: EdgeInsets.all(tiny ? 16 : 24),
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
    // WRAP IN SCROLLVIEW TO FIX OVERFLOW
    child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(), // Keeps it feeling tight
      child: Column(
        mainAxisSize: MainAxisSize.min, // Vital: takes only needed space
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _HeroCopy(compact: true),
          const SizedBox(height: 24),
          // DYNAMIC VISUAL BOX
          ConstrainedBox(
            constraints: BoxConstraints(
              // Allow the image to be smaller on tiny phones
              maxHeight: tiny ? 180 : 250, 
            ),
            child: const _HeroVisualDeck(),
          ),
        ],
      ),
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
       
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual({required this.child});

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
              color: AppColors.curveRed.withValues(alpha: 0.16),
            ),
          ),
          Positioned(
            bottom: -55,
            left: -35,
            child: _GlowOrb(
              size: 210,
              color: AppColors.textFor(context).withValues(alpha: 0.06),
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
  static const Duration _transitionDuration = Duration(milliseconds: 950);

  static const List<String> _images = <String>[
    'assets/Home1.png',
    'assets/Home2.png',
    'assets/Home3.png',
    'assets/Home4.png',
  ];

  late final Timer _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_holdDuration, (_) {
      if (!mounted) {
        return;
      }
      setState(() => _index = (_index + 1) % _images.length);
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AnimatedSwitcher(
                duration: _transitionDuration,
                reverseDuration: const Duration(milliseconds: 680),
                switchInCurve: Curves.easeOutQuart,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (
                  Widget child,
                  Animation<double> animation,
                ) {
                  final Animation<Offset> slide = Tween<Offset>(
                    begin: const Offset(0.2, 0),
                    end: Offset.zero,
                  ).animate(animation);

                  final Animation<double> fade = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  );

                  final Animation<double> tilt = Tween<double>(
                    begin: 0.02,
                    end: 0,
                  ).animate(animation);

                  return FadeTransition(
                    opacity: fade,
                    child: SlideTransition(
                      position: slide,
                      child: AnimatedBuilder(
                        animation: tilt,
                        child: child,
                        builder: (BuildContext context, Widget? inner) {
                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(tilt.value),
                            child: inner,
                          );
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  key: ValueKey<int>(_index),
                  color:
                      AppColors.backgroundFor(context).withValues(alpha: 0.2),
                  child: Center(
                    child: Image.asset(
                      _images[_index],
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
          const SizedBox(height: 8),
          Row(
            children: List<Widget>.generate(_images.length, (int i) {
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
