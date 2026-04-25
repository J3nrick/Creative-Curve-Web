import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
import 'package:flutter/material.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    const List<({String label, String value, Color tone})> cards =
        <({String label, String value, Color tone})>[
      (label: 'Clients Landed', value: '4', tone: Color(0xFFFFF5F5)),
      (
        label: 'Project Completion Rate',
        value: '100%',
        tone: Color(0xFFF4F6FF),
      ),
      (
        label: 'Average Delivery Cycle',
        value: '12 days',
        tone: Color(0xFFF3FAF7),
      ),
      (
        label: 'Revision Efficiency',
        value: '1.6 rounds',
        tone: Color(0xFFFFFAF0),
      ),
    ];

    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            isMobile ? 18 : 56, isMobile ? 24 : 36, isMobile ? 18 : 56, 44),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Performance',
                style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 8),
            Text(
              'December 2024 - February 2025',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.mutedFor(context)),
            ),
            const SizedBox(height: 22),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: cards
                  .map(
                    (card) => _MetricCard(
                      label: card.label,
                      value: card.value,
                      tone: card.tone,
                      width: isMobile ? double.infinity : 280,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surfaceFor(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.strokeFor(context)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Momentum Snapshot',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 14),
                  const _GrowthBars(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.tone,
    required this.width,
  });

  final String label;
  final String value;
  final Color tone;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.isDark(context)
            ? AppColors.elevatedSurfaceFor(context)
            : tone,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.strokeFor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.charcoal,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textFor(context),
                ),
          ),
        ],
      ),
    );
  }
}

class _GrowthBars extends StatelessWidget {
  const _GrowthBars();

  @override
  Widget build(BuildContext context) {
    const List<({String label, double score})> rows =
        <({String label, double score})>[
      (label: 'Brand Awareness Lift', score: 0.84),
      (label: 'Qualified Leads', score: 0.71),
      (label: 'Campaign Velocity', score: 0.77),
      (label: 'Retention Confidence', score: 0.88),
    ];

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool narrow = constraints.maxWidth < 460;

        return Column(
          children: rows
              .map(
                (({String label, double score}) row) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: narrow
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              row.label,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: LinearProgressIndicator(
                                value: row.score,
                                minHeight: 10,
                                backgroundColor: AppColors.isDark(context)
                                    ? Colors.white12
                                    : Colors.white,
                                color: AppColors.curveRed,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            SizedBox(
                              width: 180,
                              child: Text(
                                row.label,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(999),
                                child: LinearProgressIndicator(
                                  value: row.score,
                                  minHeight: 10,
                                  backgroundColor: AppColors.isDark(context)
                                      ? Colors.white12
                                      : Colors.white,
                                  color: AppColors.curveRed,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
