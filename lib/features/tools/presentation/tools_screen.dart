import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
import 'package:creative_curve_web/shared/widgets/liquid_glass_panel.dart';
import 'package:flutter/material.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  static const List<({String name, String imageUrl})> _tools =
      <({String name, String imageUrl})>[
    (
      name: 'Google Workspace',
      imageUrl: 'https://img.icons8.com/color/512/google-logo.png',
    ),
    (
      name: 'Adobe Photoshop',
      imageUrl: 'https://dl.svgcdn.com/png/logos/adobe-photoshop-800.png',
    ),
    (
      name: 'Adobe Illustrator',
      imageUrl: 'https://dl.svgcdn.com/png/logos/adobe-illustrator-800.png',
    ),
    (
      name: 'Adobe Lightroom',
      imageUrl: 'https://dl.svgcdn.com/png/logos/adobe-lightroom-800.png',
    ),
    (
      name: 'Adobe Premiere Pro',
      imageUrl:
          'https://dl.svgcdn.com/png/streamline-logos/adobe-premiere-pro-logo-800.png',
    ),
    (
      name: 'DaVinci Resolve',
      imageUrl: 'https://img.icons8.com/color/512/davinci-resolve.png',
    ),
    (
      name: 'Procreate',
      imageUrl: 'https://img.icons8.com/color/512/procreate.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final int columns = ResponsiveLayout.columnsFor(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: ContentConstraint(
        child: Padding(
          padding: ResponsiveLayout.pagePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Tools',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.textFor(context),
                    ),
              ),
              SizedBox(height: ResponsiveLayout.space(1.25)),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Text(
                  'Our production stack is visual-first and built for speed, consistency, and high-quality delivery.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.mutedFor(context),
                      ),
                ),
              ),
              SizedBox(height: ResponsiveLayout.space(3)),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double gap = ResponsiveLayout.space(2);
                  final double tileWidth =
                      (constraints.maxWidth - gap * (columns - 1)) / columns;
                  final double aspect = columns == 1 ? 3.2 : 2.1;

                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: List<Widget>.generate(_tools.length, (int i) {
                      final item = _tools[i];
                      return SizedBox(
                        width: columns == 1 ? constraints.maxWidth : tileWidth,
                        child: AspectRatio(
                          aspectRatio: aspect,
                          child: _ToolGlassTile(
                            name: item.name,
                            imageUrl: item.imageUrl,
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToolGlassTile extends StatelessWidget {
  const _ToolGlassTile({
    required this.name,
    required this.imageUrl,
  });

  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final bool dark = AppColors.isDark(context);

    return LiquidGlassPanel(
      padding: EdgeInsets.all(ResponsiveLayout.space(2)),
      child: Row(
        children: <Widget>[
          _FrostedIconBackdrop(
            child: Image.network(
              imageUrl,
              width: 36,
              height: 36,
              fit: BoxFit.contain,
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
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutCubic,
                    child: child,
                  );
                }
                return SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.curveRed.withValues(alpha: 0.6),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.widgets_outlined,
                  color: AppColors.textFor(context).withValues(alpha: 0.45),
                );
              },
            ),
          ),
          SizedBox(width: ResponsiveLayout.space(1.5)),
          Expanded(
            child: Text(
              name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textFor(context),
                  ),
            ),
          ),
          Icon(
            Icons.arrow_outward_rounded,
            size: 18,
            color: dark
                ? AppColors.mutedFor(context).withValues(alpha: 0.7)
                : AppColors.mutedFor(context),
          ),
        ],
      ),
    );
  }
}

class _FrostedIconBackdrop extends StatelessWidget {
  const _FrostedIconBackdrop({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool dark = AppColors.isDark(context);

    return Container(
      width: 58,
      height: 58,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: dark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.white.withValues(alpha: 0.72),
        border: Border.all(
          color: dark
              ? Colors.white.withValues(alpha: 0.18)
              : Colors.white.withValues(alpha: 0.9),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.curveRed.withValues(alpha: 0.1),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}
