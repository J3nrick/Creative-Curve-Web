import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool compact = MediaQuery.sizeOf(context).width < 980;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: <Widget>[
          _TopBar(compact: compact),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: EdgeInsets.symmetric(horizontal: compact ? 20 : 28),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.stroke)),
      ),
      child: Row(
        children: <Widget>[
          Text(
            'CREATIVE CURVE',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(letterSpacing: 1.4),
          ),
          const Spacer(),
          _MenuAction(
            onTap: () => _openMenu(context),
          ),
        ],
      ),
    );
  }

  Future<void> _openMenu(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.background,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _MenuLink(label: 'Hero', path: '/'),
                _MenuLink(label: 'Services', path: '/services'),
                _MenuLink(label: 'Crafters', path: '/crafters'),
                _MenuLink(label: 'Contact', path: '/contact'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MenuAction extends StatefulWidget {
  const _MenuAction({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_MenuAction> createState() => _MenuActionState();
}

class _MenuActionState extends State<_MenuAction> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translateByDouble(0.0, _hovered ? -1.5 : 0.0, 0.0, 1.0),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.stroke),
        ),
        child: IconButton(
          onPressed: widget.onTap,
          icon: const Icon(Icons.menu_rounded),
          color: AppColors.charcoal,
        ),
      ),
    );
  }
}

class _MenuLink extends StatelessWidget {
  const _MenuLink({
    required this.label,
    required this.path,
  });

  final String label;
  final String path;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: const Icon(Icons.arrow_outward_rounded),
      onTap: () {
        Navigator.of(context).pop();
        context.go(path);
      },
    );
  }
}
