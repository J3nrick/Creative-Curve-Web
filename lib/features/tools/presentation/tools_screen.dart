import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
import 'package:flutter/material.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  static const List<({String name, String imageUrl, Color tone})> _tools =
      <({String name, String imageUrl, Color tone})>[
    (
      name: 'Google Workspace',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/320px-Google_2015_logo.svg.png',
      tone: Color(0xFFF7FAFF),
    ),
    (
      name: 'Adobe Photoshop',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Adobe_Photoshop_CC_icon.svg/240px-Adobe_Photoshop_CC_icon.svg.png',
      tone: Color(0xFFF4F8FF),
    ),
    (
      name: 'Adobe Illustrator',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Adobe_Illustrator_CC_icon.svg/240px-Adobe_Illustrator_CC_icon.svg.png',
      tone: Color(0xFFFFF8F0),
    ),
    (
      name: 'Adobe Lightroom',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Adobe_Photoshop_Lightroom_CC_logo.svg/240px-Adobe_Photoshop_Lightroom_CC_logo.svg.png',
      tone: Color(0xFFF4F9FF),
    ),
    (
      name: 'Adobe Premiere Pro',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/Adobe_Premiere_Pro_CC_icon.svg/240px-Adobe_Premiere_Pro_CC_icon.svg.png',
      tone: Color(0xFFF8F5FF),
    ),
    (
      name: 'DaVinci Resolve',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/DaVinci_Resolve_17_logo.svg/320px-DaVinci_Resolve_17_logo.svg.png',
      tone: Color(0xFFF3FAFF),
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
            Text('Tools', style: Theme.of(context).textTheme.displayMedium),
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
                final ({String name, String imageUrl, Color tone}) item =
                    _tools[index];
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
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _hovered ? -4.0 : 0.0, 0.0, 1.0),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.isDark(context)
              ? AppColors.elevatedSurfaceFor(context)
              : widget.tone,
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
                color: AppColors.isDark(context)
                    ? AppColors.surfaceDark
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.strokeFor(context)),
              ),
              child: Image.network(
                widget.imageUrl,
                width: 36,
                height: 36,
                fit: BoxFit.contain,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return const Icon(Icons.widgets_outlined,
                      color: AppColors.charcoal);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
