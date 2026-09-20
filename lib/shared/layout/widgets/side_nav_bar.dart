import 'dart:ui';

import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/core/theme/curve_theme_extension.dart';
import 'package:creative_curve_web/shared/interactions/cursor_magnet_scope.dart';
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
  final List<({String label, String path, IconData icon})> items;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  static final SmoothBorderRadius _radius = SmoothBorderRadius(
    cornerRadius: 28,
    cornerSmoothing: 0.6,
  );

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final CurveThemeExtension tokens = context.curveTheme;

    return Container(
      width: 116,
      margin: const EdgeInsets.fromLTRB(14, 14, 10, 14),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: _radius,
          side: BorderSide(
            color: isDark ? const Color(0x33FFFFFF) : const Color(0x1F000000),
            width: 1.0,
          ),
        ),
        shadows: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.35)
                : const Color(0xFF101216).withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: SmoothRectangleBorder(borderRadius: _radius),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: tokens.glassFill,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                // Top Specular Highlight Edge
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          tokens.specular,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    // Logo & Quick Theme Toggle
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 14, 6, 6),
                      child: Row(
                        children: <Widget>[
                          const Expanded(
                            child: CursorMagnetScope(
                              maxDistance: 6.0,
                              strength: 0.2,
                              child: CurveLogo(
                                height: 30,
                                semanticLabel: 'Creative Curve logo',
                              ),
                            ),
                          ),
                          CursorMagnetScope(
                            maxDistance: 6.0,
                            strength: 0.3,
                            child: IconButton(
                              onPressed: onToggleTheme,
                              tooltip: isDark
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
                                isDark
                                    ? Icons.wb_sunny_rounded
                                    : Icons.dark_mode_rounded,
                                size: 16,
                                color: tokens.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Navigation Links with Magnetic Hover Physics
                    Expanded(
                      child: ListView.separated(
                        itemCount: items.length,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        separatorBuilder: (_, __) => const SizedBox(height: 6),
                        itemBuilder: (BuildContext context, int index) {
                          final ({String label, String path, IconData icon})
                              item = items[index];
                          final bool active = currentPath == item.path ||
                              (item.path != '/' &&
                                  currentPath.startsWith(item.path));
                          return CursorMagnetScope(
                            maxDistance: 7.0,
                            strength: 0.24,
                            child: _SideNavButton(
                              label: item.label,
                              icon: item.icon,
                              active: active,
                              onTap: () => context.go(item.path),
                            ),
                          );
                        },
                      ),
                    ),

                    // Studio Status Indicator Badge
                    const CursorMagnetScope(
                      maxDistance: 5.0,
                      strength: 0.18,
                      child: _StudioStatusBadge(),
                    ),
                    const SizedBox(height: 8),

                    // Social Links
                    const _SocialIconButtons(),
                    const SizedBox(height: 12),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SideNavButton extends StatefulWidget {
  const _SideNavButton({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_SideNavButton> createState() => _SideNavButtonState();
}

class _SideNavButtonState extends State<_SideNavButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final CurveThemeExtension tokens = context.curveTheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          decoration: ShapeDecoration(
            color: widget.active
                ? AppColors.curveRed.withValues(alpha: isDark ? 0.16 : 0.1)
                : _hovered
                    ? tokens.textPrimary.withValues(alpha: 0.05)
                    : Colors.transparent,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 14,
                cornerSmoothing: 0.6,
              ),
              side: BorderSide(
                color: widget.active
                    ? AppColors.curveRed.withValues(alpha: 0.55)
                    : _hovered
                        ? tokens.stroke
                        : Colors.transparent,
                width: 1.0,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: widget.active
                    ? AppColors.curveRed
                    : _hovered
                        ? tokens.textPrimary
                        : tokens.textMuted,
              ),
              const SizedBox(height: 4),
              Text(
                widget.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: widget.active
                          ? (isDark ? Colors.white : AppColors.textLight)
                          : _hovered
                              ? tokens.textPrimary
                              : tokens.textMuted,
                      fontWeight:
                          widget.active ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 11,
                      letterSpacing: -0.1,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- STUDIO STATUS BADGE ---

class _StudioStatusBadge extends StatelessWidget {
  const _StudioStatusBadge();

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final CurveThemeExtension tokens = context.curveTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: ShapeDecoration(
        color: isDark ? const Color(0xFF19191D) : const Color(0xFFF3F4F6),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 14,
            cornerSmoothing: 0.6,
          ),
          side: BorderSide(
            color: tokens.stroke,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _LiveStatusDot(),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  'STUDIO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: tokens.textMuted,
                    fontWeight: FontWeight.w700,
                    fontSize: 9.5,
                    letterSpacing: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            'Accepting\nProjects',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: tokens.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  height: 1.15,
                ),
          ),
        ],
      ),
    );
  }
}

class _LiveStatusDot extends StatefulWidget {
  const _LiveStatusDot();

  @override
  State<_LiveStatusDot> createState() => _LiveStatusDotState();
}

class _LiveStatusDotState extends State<_LiveStatusDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF34C759),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF34C759)
                    .withValues(alpha: _pulseAnimation.value * 0.6),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}

// --- SOCIAL ICON BUTTONS ---

class _SocialIconButtons extends StatelessWidget {
  const _SocialIconButtons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 4,
        runSpacing: 4,
        children: [
          _SocialIconButton(
            icon: Icons.link_rounded,
            tooltip: 'LinkedIn',
            onPressed: () {},
          ),
          _SocialIconButton(
            icon: Icons.language_rounded,
            tooltip: 'Website',
            onPressed: () {},
          ),
          _SocialIconButton(
            icon: Icons.camera_alt_rounded,
            tooltip: 'Instagram',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  const _SocialIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final CurveThemeExtension tokens = context.curveTheme;

    return CursorMagnetScope(
      maxDistance: 4.0,
      strength: 0.2,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: ShapeDecoration(
            color: _hovered
                ? tokens.textPrimary.withValues(alpha: 0.07)
                : Colors.transparent,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 10,
                cornerSmoothing: 0.6,
              ),
              side: BorderSide(
                color: _hovered ? tokens.stroke : Colors.transparent,
              ),
            ),
          ),
          child: Tooltip(
            message: widget.tooltip,
            child: IconButton(
              onPressed: widget.onPressed,
              iconSize: 15,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                padding: const EdgeInsets.all(4),
                minimumSize: const Size(28, 28),
              ),
              icon: Icon(
                widget.icon,
                color: _hovered ? tokens.textPrimary : tokens.textMuted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
