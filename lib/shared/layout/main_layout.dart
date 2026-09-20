import 'dart:ui';

import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/core/theme/curve_theme_extension.dart';
import 'package:creative_curve_web/core/theme/theme_mode_provider.dart';
import 'package:creative_curve_web/shared/interactions/cursor_magnet_scope.dart';
import 'package:creative_curve_web/shared/layout/widgets/side_nav_bar.dart';
import 'package:creative_curve_web/shared/widgets/curve_logo.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends ConsumerStatefulWidget {
  const MainLayout({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  static const List<({String label, String path, IconData icon})> _items =
      <({String label, String path, IconData icon})>[
    (label: 'Home', path: '/', icon: Icons.home_rounded),
    (label: 'Services', path: '/services', icon: Icons.grid_view_rounded),
    (label: 'Gallery', path: '/gallery', icon: Icons.photo_library_rounded),
    (label: 'Team', path: '/team', icon: Icons.group_rounded),
    (label: 'Contacts', path: '/contacts', icon: Icons.mail_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool compact = width < 980;
    final String currentPath = GoRouterState.of(context).uri.path;
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final CurveThemeExtension tokens = context.curveTheme;

    final Widget frame = compact
        ? _MobileShell(
            currentPath: currentPath,
            items: _items,
            themeMode: themeMode,
            onToggleTheme: _toggleTheme,
            child: widget.child,
          )
        : Row(
            children: <Widget>[
              SideNavBar(
                currentPath: currentPath,
                items: _items,
                themeMode: themeMode,
                onToggleTheme: _toggleTheme,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 14, 14, 14),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: tokens.background,
                      shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(
                          cornerRadius: 32,
                          cornerSmoothing: 0.6,
                        ),
                        side: BorderSide(
                          color: tokens.stroke,
                          width: 1.0,
                        ),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: widget.child,
                  ),
                ),
              ),
            ],
          );

    return Scaffold(
      backgroundColor: tokens.background,
      body: frame,
    );
  }

  void _toggleTheme() {
    ref.read(themeModeProvider.notifier).toggle();
  }
}

/// Mobile responsive layout equipped with minimal top header and floating Liquid Glass bottom navigation bar.
class _MobileShell extends StatelessWidget {
  const _MobileShell({
    required this.currentPath,
    required this.items,
    required this.themeMode,
    required this.onToggleTheme,
    required this.child,
  });

  final String currentPath;
  final List<({String label, String path, IconData icon})> items;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final CurveThemeExtension tokens = context.curveTheme;
    final bool isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: tokens.background,
      body: Stack(
        children: <Widget>[
          // Main Scrollable Page Body
          Positioned.fill(
            child: Column(
              children: <Widget>[
                // Minimal Top Bar with Brand & Theme Switcher
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                    child: Row(
                      children: <Widget>[
                        const CurveLogo(
                          height: 28,
                          semanticLabel: 'Creative Curve logo',
                        ),
                        const Spacer(),
                        CursorMagnetScope(
                          maxDistance: 6.0,
                          strength: 0.3,
                          child: IconButton(
                            onPressed: onToggleTheme,
                            tooltip: isDark
                                ? 'Switch to light mode'
                                : 'Switch to dark mode',
                            icon: Icon(
                              isDark
                                  ? Icons.wb_sunny_rounded
                                  : Icons.dark_mode_rounded,
                              size: 19,
                              color: tokens.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Page Content with bottom insets to clear floating nav bar
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 76),
                    child: child,
                  ),
                ),
              ],
            ),
          ),

          // Floating Liquid Glass Bottom Navigation Bar
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: SafeArea(
              top: false,
              child: _ResponsiveBottomNavBar(
                currentPath: currentPath,
                items: items,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Floating Liquid Glass Bottom Navigation Bar with G2 squircle styling and specular edge
class _ResponsiveBottomNavBar extends StatelessWidget {
  const _ResponsiveBottomNavBar({
    required this.currentPath,
    required this.items,
  });

  final String currentPath;
  final List<({String label, String path, IconData icon})> items;

  static final SmoothBorderRadius _bottomRadius = SmoothBorderRadius(
    cornerRadius: 22,
    cornerSmoothing: 0.6,
  );

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final CurveThemeExtension tokens = context.curveTheme;

    return Container(
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: _bottomRadius,
          side: BorderSide(
            color: isDark ? const Color(0x33FFFFFF) : const Color(0x1F000000),
            width: 1.0,
          ),
        ),
        shadows: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.4)
                : const Color(0xFF101216).withValues(alpha: 0.1),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: SmoothRectangleBorder(borderRadius: _bottomRadius),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: tokens.glassFill,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Stack(
              children: [
                // Top Specular Highlight
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: items.map((item) {
                    final bool active = currentPath == item.path ||
                        (item.path != '/' && currentPath.startsWith(item.path));

                    return Expanded(
                      child: CursorMagnetScope(
                        maxDistance: 6.0,
                        strength: 0.25,
                        child: _BottomNavItem(
                          label: item.label,
                          icon: item.icon,
                          active: active,
                          onTap: () => context.go(item.path),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatefulWidget {
  const _BottomNavItem({
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
  State<_BottomNavItem> createState() => _BottomNavItemState();
}

class _BottomNavItemState extends State<_BottomNavItem> {
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
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: ShapeDecoration(
            color: widget.active
                ? AppColors.curveRed.withValues(alpha: isDark ? 0.18 : 0.12)
                : _hovered
                    ? tokens.textPrimary.withValues(alpha: 0.06)
                    : Colors.transparent,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 14,
                cornerSmoothing: 0.6,
              ),
              side: BorderSide(
                color: widget.active
                    ? AppColors.curveRed.withValues(alpha: 0.5)
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
                size: 18,
                color: widget.active
                    ? AppColors.curveRed
                    : _hovered
                        ? tokens.textPrimary
                        : tokens.textMuted,
              ),
              const SizedBox(height: 3),
              Text(
                widget.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: widget.active
                      ? (isDark ? Colors.white : AppColors.textLight)
                      : _hovered
                          ? tokens.textPrimary
                          : tokens.textMuted,
                  fontWeight: widget.active ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 10.5,
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
