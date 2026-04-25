import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/widgets/curve_logo.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({
    required this.currentPath,
    required this.items,
    required this.themeMode,
    required this.onToggleTheme,
    super.key,
  });

  final String currentPath;
  final List<({String label, String path})> items;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  static final SmoothBorderRadius _radius = SmoothBorderRadius(
    cornerRadius: 30,
    cornerSmoothing: 0.6,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 132,
      margin: const EdgeInsets.fromLTRB(14, 14, 10, 14),
      decoration: ShapeDecoration(
        color: AppColors.surfaceFor(context),
        shape: SmoothRectangleBorder(
          borderRadius: _radius,
          side: BorderSide(color: AppColors.strokeFor(context)),
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 14, 6, 6),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: CurveLogo(
                    height: 32,
                    semanticLabel: 'Creative Curve logo',
                  ),
                ),
                IconButton(
                  onPressed: onToggleTheme,
                  tooltip: themeMode == ThemeMode.dark
                      ? 'Switch to light mode'
                      : 'Switch to dark mode',
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    padding: const EdgeInsets.all(4),
                    minimumSize: const Size(24, 24),
                  ),
                  icon: Icon(
                    themeMode == ThemeMode.dark
                        ? Icons.wb_sunny_rounded
                        : Icons.dark_mode_rounded,
                    size: 18,
                    color: AppColors.textFor(context),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                final ({String label, String path}) item = items[index];
                return _SideNavButton(
                  label: item.label,
                  active: currentPath == item.path,
                  onTap: () => context.go(item.path),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _SideNavButton extends StatefulWidget {
  const _SideNavButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_SideNavButton> createState() => _SideNavButtonState();
}

class _SideNavButtonState extends State<_SideNavButton> {
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
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: ShapeDecoration(
            color: widget.active
                ? AppColors.curveRed.withValues(alpha: 0.2)
                : _hovered
                    ? AppColors.textFor(context).withValues(alpha: 0.06)
                    : Colors.transparent,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 16,
                cornerSmoothing: 0.6,
              ),
              side: BorderSide(
                color: widget.active
                    ? AppColors.curveRed.withValues(alpha: 0.7)
                    : AppColors.strokeFor(context),
              ),
            ),
          ),
          child: Text(
            widget.label,
            maxLines: 2,
            overflow: TextOverflow.visible,
            softWrap: true,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: widget.active
                      ? AppColors.textFor(context)
                      : AppColors.mutedFor(context),
                  fontWeight: widget.active ? FontWeight.w700 : FontWeight.w500,
                  letterSpacing: 0,
                ),
          ),
        ),
      ),
    );
  }
}
