import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/core/theme/curve_theme_extension.dart';
import 'package:creative_curve_web/shared/interactions/cursor_magnet_scope.dart';
import 'package:creative_curve_web/shared/interactions/studio_command_palette.dart';
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
                    const SizedBox(height: 6),

                    // Quick Command Palette Trigger (⌘K)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CursorMagnetScope(
                        maxDistance: 6.0,
                        strength: 0.22,
                        child: _SideNavCommandTrigger(
                          onTap: () => StudioCommandPalette.show(context),
                        ),
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

                    // Studio Status & Live Clock Indicator Badge
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
}// --- QUICK COMMAND TRIGGER ---

class _SideNavCommandTrigger extends StatefulWidget {
  const _SideNavCommandTrigger({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_SideNavCommandTrigger> createState() => _SideNavCommandTriggerState();
}

class _SideNavCommandTriggerState extends State<_SideNavCommandTrigger> {
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
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: ShapeDecoration(
            color: _hovered
                ? (isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : const Color(0xFFE5E8ED))
                : (isDark
                    ? Colors.white.withValues(alpha: 0.04)
                    : const Color(0xFFEDEFF3)),
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 12,
                cornerSmoothing: 0.6,
              ),
              side: BorderSide(
                color: _hovered
                    ? AppColors.curveRed.withValues(alpha: 0.5)
                    : tokens.stroke,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_rounded,
                size: 13,
                color: _hovered ? AppColors.curveRed : tokens.textMuted,
              ),
              const SizedBox(width: 4),
              Text(
                '⌘K',
                style: TextStyle(
                  color: _hovered ? tokens.textPrimary : tokens.textMuted,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- STUDIO STATUS BADGE & LIVE UTC+8 CLOCK ---

class _StudioStatusBadge extends StatefulWidget {
  const _StudioStatusBadge();

  @override
  State<_StudioStatusBadge> createState() => _StudioStatusBadgeState();
}

class _StudioStatusBadgeState extends State<_StudioStatusBadge> {
  late Timer _clockTimer;
  late DateTime _phTime;

  @override
  void initState() {
    super.initState();
    _phTime = DateTime.now().toUtc().add(const Duration(hours: 8));
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _phTime = DateTime.now().toUtc().add(const Duration(hours: 8));
      });
    });
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime dt) {
    final int hour = dt.hour;
    final int minute = dt.minute;
    final String period = hour >= 12 ? 'PM' : 'AM';
    final int displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final String minuteStr = minute.toString().padLeft(2, '0');
    return '$displayHour:$minuteStr $period';
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final CurveThemeExtension tokens = context.curveTheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => StudioCommandPalette.show(context),
        child: Tooltip(
          message: 'Creative Curve Studio HQ • UTC+8 (PH) • Open Palette (⌘K)',
          child: Container(
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
                    const _KineticSoundwave(),
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
                  _formatTime(_phTime),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.curveRed,
                    fontWeight: FontWeight.w700,
                    fontSize: 9.5,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Accepting Projects',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: tokens.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 9.5,
                        height: 1.15,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _KineticSoundwave extends StatefulWidget {
  const _KineticSoundwave();

  @override
  State<_KineticSoundwave> createState() => _KineticSoundwaveState();
}

class _KineticSoundwaveState extends State<_KineticSoundwave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double v = _controller.value;
        final double h1 = 3.0 + 5.0 * (0.5 + 0.5 * math.sin(v * 6.28));
        final double h2 = 4.0 + 7.0 * (0.5 + 0.5 * math.sin((v * 6.28) + 1.2));
        final double h3 = 3.0 + 6.0 * (0.5 + 0.5 * math.sin((v * 6.28) + 2.4));

        return SizedBox(
          width: 10,
          height: 11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _soundBar(h1),
              _soundBar(h2),
              _soundBar(h3),
            ],
          ),
        );
      },
    );
  }

  Widget _soundBar(double height) {
    return Container(
      width: 2.0,
      height: height.clamp(3.0, 11.0),
      decoration: BoxDecoration(
        color: const Color(0xFF34C759),
        borderRadius: BorderRadius.circular(1),
      ),
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
