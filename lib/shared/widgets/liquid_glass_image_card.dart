import 'dart:ui';

import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/widgets/liquid_glass_panel.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Shows an ultra-premium full-screen liquid-glass lightbox for examining assets in detail.
void showImageLightbox(
  BuildContext context, {
  required String path,
  required String title,
  required String category,
  String? description,
  bool isNetwork = false,
}) {
  showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.8),
    builder: (BuildContext dialogContext) {
      final bool isDark = AppColors.isDark(dialogContext);

      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1080, maxHeight: 800),
            child: Container(
              decoration: ShapeDecoration(
                color: isDark
                    ? const Color(0xFF141418).withValues(alpha: 0.94)
                    : Colors.white.withValues(alpha: 0.94),
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 26,
                    cornerSmoothing: 0.6,
                  ),
                  side: BorderSide(
                    color: AppColors.strokeFor(dialogContext),
                    width: 1.0,
                  ),
                ),
                shadows: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.12),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Header Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 16, 14, 14),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.curveRed
                                .withValues(alpha: isDark ? 0.12 : 0.08),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: AppColors.curveRed
                                  .withValues(alpha: isDark ? 0.35 : 0.25),
                              width: 1.0,
                            ),
                          ),
                          child: Text(
                            category.toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.curveRed,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(dialogContext)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textFor(dialogContext),
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: '$title ($category) — Creative Curve Studios Vault'));
                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              SnackBar(
                                content: Text('Copied "$title" to clipboard'),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          },
                          tooltip: 'Copy Asset Name',
                          icon: Icon(
                            Icons.copy_rounded,
                            size: 17,
                            color: AppColors.mutedFor(dialogContext),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          tooltip: 'Close',
                          icon: Icon(
                            Icons.close_rounded,
                            color: AppColors.mutedFor(dialogContext),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: AppColors.strokeFor(dialogContext)),

                  // Image Display Area with Pan & Zoom
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ClipSmoothRect(
                        radius: SmoothBorderRadius(
                          cornerRadius: 16,
                          cornerSmoothing: 0.6,
                        ),
                        child: Container(
                          color: isDark
                              ? const Color(0xFF09090B)
                              : const Color(0xFFF2F4F7),
                          alignment: Alignment.center,
                          child: InteractiveViewer(
                            minScale: 0.8,
                            maxScale: 3.5,
                            child: isNetwork
                                ? Image.network(
                                    path,
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                  )
                                : Image.asset(
                                    path,
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Footer with Description & Studio Metadata Badge
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (description != null && description.isNotEmpty)
                          Expanded(
                            child: Text(
                              description,
                              style: Theme.of(dialogContext)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.mutedFor(dialogContext),
                                    height: 1.45,
                                  ),
                            ),
                          ),
                        const SizedBox(width: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : const Color(0xFFF0F2F5),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.strokeFor(dialogContext),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: AppColors.curveRed,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'CREATIVE CURVE VAULT • 4K PRO',
                                style: TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  color: AppColors.mutedFor(dialogContext),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

/// Liquid-glass framed image with fade-in loading, subtle 3D perspective hover tilt,
/// and clickable full-resolution lightbox viewer.
class LiquidGlassImageCard extends StatefulWidget {
  const LiquidGlassImageCard({
    required this.path,
    required this.title,
    required this.category,
    this.description,
    this.aspectRatio = 16 / 9,
    this.fit = BoxFit.cover,
    this.isNetwork = false,
    this.onTap,
    super.key,
  });

  final String path;
  final String title;
  final String category;
  final String? description;
  final double aspectRatio;
  final BoxFit fit;
  final bool isNetwork;
  final VoidCallback? onTap;

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
      cursor: SystemMouseCursors.click,
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
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          } else {
            showImageLightbox(
              context,
              path: widget.path,
              title: widget.title,
              category: widget.category,
              description: widget.description,
              isNetwork: widget.isNetwork,
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
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
                // Image Canvas
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: dark
                              ? const Color(0xFF0F0F12)
                              : const Color(0xFFEFF1F4),
                        ),
                      ),
                      ClipSmoothRect(
                        radius: const SmoothBorderRadius.vertical(
                          top: SmoothRadius(
                            cornerRadius: 19,
                            cornerSmoothing: 0.6,
                          ),
                        ),
                        child: _buildImage(context),
                      ),
                      // Ambient light sheen
                      Positioned.fill(
                        child: IgnorePointer(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: _hovered ? 0.16 : 0.04,
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
                                      alpha: dark ? 0.24 : 0.4,
                                    ),
                                    Colors.transparent,
                                  ],
                                  stops: const <double>[0, 0.45],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Expand / View indicator badge on hover
                      Positioned(
                        top: 10,
                        right: 10,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 180),
                          opacity: _hovered ? 1.0 : 0.0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.65),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.25),
                                width: 1.0,
                              ),
                            ),
                            child: const Icon(
                              Icons.fullscreen_rounded,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Card Details Footer
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              widget.category.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: AppColors.curveRed,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.4,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.arrow_outward_rounded,
                            size: 13,
                            color: _hovered
                                ? AppColors.curveRed
                                : AppColors.mutedFor(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textFor(context),
                              fontWeight: FontWeight.w700,
                              fontSize: 14.5,
                            ),
                      ),
                      if (widget.description != null &&
                          widget.description!.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          widget.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.mutedFor(context),
                                    height: 1.35,
                                    fontSize: 12,
                                  ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Matrix4 _hoverMatrix() {
    final Matrix4 m = Matrix4.identity()..setEntry(3, 2, 0.001);
    if (!_hovered) return m;
    m
      ..rotateX((-_pointer.dy) * 0.04)
      ..rotateY(_pointer.dx * 0.05)
      ..translateByDouble(0, -3, 0, 1)
      ..scaleByDouble(1.008, 1.008, 1.008, 1);
    return m;
  }

  Widget _buildImage(BuildContext context) {
    if (widget.isNetwork) {
      return Image.network(
        widget.path,
        fit: widget.fit,
        filterQuality: FilterQuality.high,
        frameBuilder: _frameBuilder,
        errorBuilder: _errorBuilder,
      );
    }

    return Image.asset(
      widget.path,
      fit: widget.fit,
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
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        child: child,
      );
    }
    return ColoredBox(
      color: AppColors.elevatedSurfaceFor(context).withValues(alpha: 0.6),
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.curveRed.withValues(alpha: 0.6),
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
              size: 32,
            ),
            const SizedBox(height: 6),
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
