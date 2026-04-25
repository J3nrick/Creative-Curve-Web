import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ServiceGridScreen extends StatelessWidget {
  const ServiceGridScreen({super.key});

  static const List<({String title, String summary})> _items =
      <({String title, String summary})>[
    (
      title: 'Design Creation',
      summary:
          'Brand assets, campaign concepts, and visual systems that stay sharp across every channel.',
    ),
    (
      title: 'Film and Video Editing',
      summary:
          'Editorial rhythm, transitions, and polish for reels, ads, and narrative brand stories.',
    ),
    (
      title: 'Motion Graphics and Animation',
      summary:
          'High-clarity motion systems, title cards, and kinetic visuals with deliberate pacing.',
    ),
    (
      title: 'Social Media Management',
      summary:
          'Calendar strategy, platform-specific creative direction, and performance-aware content loops.',
    ),
    (
      title: 'Website Development',
      summary:
          'Responsive web experiences tuned for speed, storytelling, and conversion-ready clarity.',
    ),
    (
      title: 'Brand Identity and Positioning',
      summary:
          'Naming, voice, and visual frameworks that make your message unmistakably yours.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool compact = constraints.maxWidth < 980;
        final int columns = constraints.maxWidth >= 1320
            ? 3
            : constraints.maxWidth >= 820
                ? 2
                : 1;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                compact ? 24 : 56, compact ? 28 : 44, compact ? 24 : 56, 44),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Service Grid',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'Minimal form. Maximum intent.',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 14),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Text(
                    'Hover each card to reveal a subtle lift and a Curve Red accent dot inspired by macOS notifications.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.mutedFor(context)),
                  ),
                ),
                const SizedBox(height: 28),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: columns == 1 ? 1.5 : (columns == 2 ? 1.1 : 0.95),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final item = _items[index];
                    return _ServiceOutlineCard(
                      title: item.title,
                      summary: item.summary,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ServiceOutlineCard extends StatefulWidget {
  const _ServiceOutlineCard({required this.title, required this.summary});

  final String title;
  final String summary;

  @override
  State<_ServiceOutlineCard> createState() => _ServiceOutlineCardState();
}

class _ServiceOutlineCardState extends State<_ServiceOutlineCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutQuart,
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _hovered ? -8.0 : 0.0, 0.0, 1.0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.elevatedSurfaceFor(context),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hovered ? AppColors.curveRed : AppColors.strokeFor(context),
            width: _hovered ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          height: 1.1,
                        ),
                  ),
                ),
                const SizedBox(width: 8),
                if (_hovered)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: const BoxDecoration(
                      color: AppColors.curveRed,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.mutedFor(context),
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Explore →',
              style: TextStyle(
                color: _hovered ? AppColors.textFor(context) : AppColors.mutedFor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}