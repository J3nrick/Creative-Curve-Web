import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/widgets/liquid_glass_panel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Liquid-glass framed image with fade-in loading and 3D perspective hover tilt.
class LiquidGlassImageCard extends StatefulWidget {
  const LiquidGlassImageCard({
    required this.path,
    required this.title,
    required this.category,
    this.aspectRatio = 4 / 3,
    this.isNetwork = false,
    super.key,
  });

  final String path;
  final String title;
  final String category;
  final double aspectRatio;
  final bool isNetwork;

  @override
  State<LiquidGlassImageCard> createState() => _LiquidGlassImageCardState();
}

class _LiquidGlassImageCardState extends State<LiquidGlassImageCard> {
  bool _hovered = false;
  Offset _pointer = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final bool dark = AppColors.isDark(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pointer = Offset.zero;
      }),
      onHover: (PointerHoverEvent event) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box == null || !box.hasSize) return;
        final Size size = box.size;
        setState(() {
          _pointer = Offset(
            (event.localPosition.dx / size.width) * 2 - 1,
            (event.localPosition.dy / size.height) * 2 - 1,
          );
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        transformAlignment: Alignment.center,
        transform: _hoverMatrix(),
        child: LiquidGlassPanel(
          enableHover: false,
          padding: EdgeInsets.zero,
          borderRadius: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    DecoratedBox(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppColors.curveRed.withValues(alpha: 0.12),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(19),
                      ),
                      child: _buildImage(context),
                    ),
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 220),
                          opacity: _hovered ? 0.22 : 0.08,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(
                                  -0.8 + _pointer.dx * 0.4,
                                  -1,
                                ),
                                end: Alignment(
                                  0.8 + _pointer.dx * 0.2,
                                  1,
                                ),
                                colors: <Color>[
                                  Colors.white.withValues(
                                    alpha: dark ? 0.28 : 0.45,
                                  ),
                                  Colors.transparent,
                                  AppColors.curveRed.withValues(alpha: 0.12),
                                ],
                                stops: const <double>[0, 0.45, 1],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: IgnorePointer(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(19),
                            ),
                            border: Border.all(
                              color: Colors.white.withValues(
                                alpha: dark ? 0.18 : 0.35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.category.toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.curveRed,
                            fontSize: 11,
                            letterSpacing: 1.6,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.textFor(context),
                            fontWeight: FontWeight.w700,
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

  Matrix4 _hoverMatrix() {
    final Matrix4 m = Matrix4.identity()..setEntry(3, 2, 0.0012);
    if (!_hovered) return m;
    m
      ..rotateX((-_pointer.dy) * 0.08)
      ..rotateY(_pointer.dx * 0.1)
      ..translateByDouble(0, -4, 0, 1)
      ..scaleByDouble(1.015, 1.015, 1.015, 1);
    return m;
  }

  Widget _buildImage(BuildContext context) {
    if (widget.isNetwork) {
      return Image.network(
        widget.path,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        frameBuilder: _frameBuilder,
        errorBuilder: _errorBuilder,
      );
    }

    return Image.asset(
      widget.path,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      frameBuilder: _frameBuilder,
      errorBuilder: _errorBuilder,
    );
  }

  Widget _frameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded || frame != null) {
      return AnimatedOpacity(
        opacity: 1,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        child: child,
      );
    }
    return ColoredBox(
      color: AppColors.elevatedSurfaceFor(context).withValues(alpha: 0.6),
      child: Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.curveRed.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }

  Widget _errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stack,
  ) {
    return ColoredBox(
      color: AppColors.elevatedSurfaceFor(context),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.broken_image_outlined,
              color: AppColors.mutedFor(context),
              size: 36,
            ),
            const SizedBox(height: 8),
            Text(
              'Asset pending',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.mutedFor(context),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
