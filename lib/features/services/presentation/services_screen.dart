import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  static const List<(String, String)> _services = <(String, String)>[
    ('Social Media Management', 'Platform strategy, content cadence, optimization, and analytics.'),
    ('Community / KOL Management', 'Relationship mapping, influencer partnerships, and engagement loops.'),
    ('Design Creation', 'Brand assets, campaign concepts, and visual systems for digital channels.'),
    ('Photo / Video Production', 'Pre-production, shoot direction, editing, and distribution-ready formats.'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(28, 30, 28, 12),
            child: Text('Services'),
          ),
        ),
        SliverList.separated(
          itemBuilder: (BuildContext context, int index) {
            final (String title, String details) = _services[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              leading: const Icon(Icons.bolt_rounded, color: AppColors.curveRed),
              title: Text(title),
              subtitle: Text(details, style: const TextStyle(color: AppColors.muted)),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Divider(color: Color(0x22FFFFFF), height: 1),
            );
          },
          itemCount: _services.length,
        ),
      ],
    );
  }
}
