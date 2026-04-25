import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
import 'package:flutter/material.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  static const List<({String name, String imageUrl, Color tone})> _tools =
      <({String name, String imageUrl, Color tone})>[
    (
      name: 'Google Workspace',
      imageUrl: 'https://img.icons8.com/color/512/google-logo.png',
      tone: Color(0xFFF7FAFF),
    ),
    (
      name: 'Adobe Photoshop',
      imageUrl: 'https://dl.svgcdn.com/png/logos/adobe-photoshop-800.png',
      tone: Color(0xFFF4F8FF),
    ),
    (
      name: 'Adobe Illustrator',
      imageUrl: 'https://dl.svgcdn.com/png/logos/adobe-illustrator-800.png',
      tone: Color(0xFFFFF8F0),
    ),
    (
      name: 'Adobe Lightroom',
      imageUrl: 'https://dl.svgcdn.com/png/logos/adobe-lightroom-800.png',
      tone: Color(0xFFF4F9FF),
    ),
    (
      name: 'Adobe Premiere Pro',
      imageUrl: 'https://dl.svgcdn.com/png/streamline-logos/adobe-premiere-pro-logo-800.png',
      tone: Color(0xFFF8F5FF),
    ),
    (
      name: 'DaVinci Resolve',
      imageUrl: 'https://img.icons8.com/color/512/adobe-premiere-pro.png',
      tone: Color(0xFFF3FAFF),
    ),
    (
      name: 'Procreate',
      imageUrl: 'https://img.icons8.com/color/512/davinci-resolve.png',
      tone: Color(0xFFFFF5F8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final bool isTablet = ResponsiveLayout.isTablet(context);

    final int columns = isMobile
        ? 1
        : isTablet
            ? 2
            : 3;

    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            isMobile ? 18 : 56, isMobile ? 24 : 36, isMobile ? 18 : 56, 44),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tools',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.textFor(context),
                  ),
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                'Our production stack is visual-first and built for speed, consistency, and high-quality delivery.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.mutedFor(context)),
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _tools.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: columns == 1 ? 2.8 : 1.35,
              ),
              itemBuilder: (BuildContext context, int index) {
                final item = _tools[index];
                return _ToolCard(
                  name: item.name,
                  imageUrl: item.imageUrl,
                  tone: item.tone,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolCard extends StatefulWidget {
  const _ToolCard({
    required this.name,
    required this.imageUrl,
    required this.tone,
  });

  final String name;
  final String imageUrl;
  final Color tone;

  @override
  State<_ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<_ToolCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _hovered ? -4.0 : 0.0, 0.0),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? AppColors.elevatedSurfaceFor(context) : widget.tone,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.strokeFor(context)),
          boxShadow: _hovered
              ? <BoxShadow>[
                  BoxShadow(
                    color: AppColors.curveRed.withValues(alpha: 0.1),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : const <BoxShadow>[],
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 58,
              height: 58,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.strokeFor(context)),
              ),
              child: Image.network(
                widget.imageUrl,
                width: 36,
                height: 36,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.widgets_outlined,
                    color: AppColors.textFor(context).withValues(alpha: 0.5),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textFor(context), // Fixed: Text adapts to theme
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}