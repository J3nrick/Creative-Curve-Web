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
    (label: 'Team', path: '/team'),
    (label: 'Performance', path: '/performance'),
    (label: 'Tools', path: '/tools'),
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
                          cornerRadius: 34,
                          cornerSmoothing: 0.6,
                        ),
                        side: BorderSide(color: AppColors.strokeFor(context)),
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
    final ThemeMode current = ref.read(themeModeProvider);
    ref.read(themeModeProvider.notifier).state = nextThemeMode(current);
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
    return Scaffold(
      backgroundColor: AppColors.backgroundFor(context),
      endDrawer: Drawer(
        backgroundColor: AppColors.surfaceFor(context),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: CurveLogo(
                  height: 30,
                  semanticLabel: 'Creative Curve logo',
                ),
              ),
              ...items.map(
                (item) => ListTile(
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 12,
                      cornerSmoothing: 0.6,
                    ),
                  ),
                  selected: currentPath == item.path,
                  selectedColor: AppColors.textFor(context),
                  iconColor: AppColors.mutedFor(context),
                  title: Text(item.label),
                  trailing: const Icon(Icons.arrow_outward_rounded),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.go(item.path);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Builder(
            builder: (BuildContext innerContext) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                child: Row(
                  children: <Widget>[
                    const CurveLogo(
                        height: 30, semanticLabel: 'Creative Curve logo'),
                    const Spacer(),
                    IconButton(
                      onPressed: onToggleTheme,
                      tooltip: themeMode == ThemeMode.dark
                          ? 'Switch to light mode'
                          : 'Switch to dark mode',
                      icon: Icon(
                        themeMode == ThemeMode.dark
                            ? Icons.wb_sunny_rounded
                            : Icons.dark_mode_rounded,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu_rounded),
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
    );
  }
}
