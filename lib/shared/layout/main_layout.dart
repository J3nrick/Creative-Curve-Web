import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/core/theme/theme_mode_provider.dart';
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
  static const List<({String label, String path})> _items =
      <({String label, String path})>[
    (label: 'Home', path: '/'),
    (label: 'Services', path: '/services'),
    (label: 'Gallery', path: '/gallery'),
    (label: 'Team', path: '/team'),
    (label: 'Contacts', path: '/contacts'),
  ];

  @override
  Widget build(BuildContext context) {
    final bool compact = MediaQuery.sizeOf(context).width < 980;
    final String currentPath = GoRouterState.of(context).uri.path;
    final ThemeMode themeMode = ref.watch(themeModeProvider);

    final Widget frame = compact
        ? _MobileFrame(
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
                      color: AppColors.backgroundFor(context),
                      shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(
                          cornerRadius: 32,
                          cornerSmoothing: 0.6,
                        ),
                        side: BorderSide(
                          color: AppColors.strokeFor(context),
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
      backgroundColor: AppColors.backgroundFor(context),
      body: frame,
    );
  }

  void _toggleTheme() {
    ref.read(themeModeProvider.notifier).toggle();
  }
}

class _MobileFrame extends StatelessWidget {
  const _MobileFrame({
    required this.currentPath,
    required this.items,
    required this.themeMode,
    required this.onToggleTheme,
    required this.child,
  });

  final String currentPath;
  final List<({String label, String path})> items;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundFor(context),
      endDrawer: Drawer(
        backgroundColor: AppColors.surfaceFor(context),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CurveLogo(
                      height: 28,
                      semanticLabel: 'Creative Curve logo',
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              ...items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: ListTile(
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 12,
                        cornerSmoothing: 0.6,
                      ),
                      side: BorderSide(
                        color: currentPath == item.path
                            ? AppColors.curveRed.withValues(alpha: 0.5)
                            : Colors.transparent,
                      ),
                    ),
                    tileColor: currentPath == item.path
                        ? AppColors.curveRed.withValues(alpha: isDark ? 0.14 : 0.08)
                        : Colors.transparent,
                    selected: currentPath == item.path,
                    selectedColor: isDark ? Colors.white : AppColors.textLight,
                    iconColor: AppColors.mutedFor(context),
                    title: Text(
                      item.label,
                      style: TextStyle(
                        fontWeight: currentPath == item.path
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: currentPath == item.path
                          ? AppColors.curveRed
                          : AppColors.mutedFor(context),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go(item.path);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Builder(
              builder: (BuildContext innerContext) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                  child: Row(
                    children: <Widget>[
                      const CurveLogo(
                        height: 28,
                        semanticLabel: 'Creative Curve logo',
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: onToggleTheme,
                        tooltip: isDark
                            ? 'Switch to light mode'
                            : 'Switch to dark mode',
                        icon: Icon(
                          isDark
                              ? Icons.wb_sunny_rounded
                              : Icons.dark_mode_rounded,
                          size: 18,
                          color: AppColors.textFor(context),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.menu_rounded,
                          color: AppColors.textFor(context),
                        ),
                        onPressed: () =>
                            Scaffold.of(innerContext).openEndDrawer(),
                      ),
                    ],
                  ),
                );
              },
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
