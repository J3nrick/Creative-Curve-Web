import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
import 'package:creative_curve_web/shared/widgets/liquid_glass_panel.dart';
import 'package:flutter/material.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  static const List<({String label, String value, double progress})> _cards =
      <({String label, String value, double progress})>[
    (label: 'Clients Landed', value: '4', progress: 0.72),
    (label: 'Project Completion Rate', value: '100%', progress: 1.0),
    (label: 'Average Delivery Cycle', value: '12 days', progress: 0.64),
    (label: 'Revision Efficiency', value: '1.6 rounds', progress: 0.81),
  ];

  @override
  Widget build(BuildContext context) {
    final int columns = ResponsiveLayout.columnsFor(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: ContentConstraint(
        child: Padding(
          padding: ResponsiveLayout.pagePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Performance',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.textFor(context),
                    ),
              ),
              SizedBox(height: ResponsiveLayout.space(1)),
              Text(
                'December 2024 — February 2025',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.mutedFor(context),
                    ),
              ),
              SizedBox(height: ResponsiveLayout.space(3)),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double gap = ResponsiveLayout.space(2);
                  final double tileWidth =
                      (constraints.maxWidth - gap * (columns - 1)) / columns;

                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: _cards.map((card) {
                      return SizedBox(
                        width: columns == 1 ? constraints.maxWidth : tileWidth,
                        child: _MetricGlassCard(
                          label: card.label,
                          value: card.value,
                          progress: card.progress,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              SizedBox(height: ResponsiveLayout.space(3)),
              const _MomentumGlassContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricGlassCard extends StatelessWidget {
  const _MetricGlassCard({
    required this.label,
    required this.value,
    required this.progress,
  });

  final String label;
  final String value;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassPanel(
      padding: EdgeInsets.all(ResponsiveLayout.space(2.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.textFor(context),
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
          ),
          SizedBox(height: ResponsiveLayout.space(0.5)),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.mutedFor(context),
                ),
          ),
          SizedBox(height: ResponsiveLayout.space(2.5)),
          _AmbientProgressTrack(value: progress),
        ],
      ),
    );
  }
}

class _AmbientProgressTrack extends StatelessWidget {
  const _AmbientProgressTrack({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    final bool dark = AppColors.isDark(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double fill = constraints.maxWidth * value.clamp(0.0, 1.0);

        return SizedBox(
          height: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: dark
                      ? Colors.white.withValues(alpha: 0.08)
                      : AppColors.charcoal.withValues(alpha: 0.08),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                width: fill,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: LinearGradient(
                    colors: <Color>[
                      AppColors.curveRed.withValues(alpha: 0.75),
                      AppColors.curveRed,
                    ],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppColors.curveRed.withValues(alpha: 0.45),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MomentumGlassContainer extends StatelessWidget {
  const _MomentumGlassContainer();

  static const List<({String label, double score})> _rows =
      <({String label, double score})>[
    (label: 'Brand Awareness Lift', score: 0.84),
    (label: 'Qualified Leads', score: 0.71),
    (label: 'Campaign Velocity', score: 0.77),
    (label: 'Retention Confidence', score: 0.88),
  ];

  @override
  Widget build(BuildContext context) {
    return LiquidGlassPanel(
      enableHover: false,
      padding: EdgeInsets.all(ResponsiveLayout.space(2.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Momentum Snapshot',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textFor(context),
                      ),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.curveRed,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppColors.curveRed.withValues(alpha: 0.55),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveLayout.space(2)),
          ..._rows.map(
            (({String label, double score}) row) => Padding(
              padding: EdgeInsets.only(bottom: ResponsiveLayout.space(2)),
              child: _MomentumRow(label: row.label, score: row.score),
            ),
          ),
        ],
      ),
    );
  }
}

class _MomentumRow extends StatelessWidget {
  const _MomentumRow({required this.label, required this.score});

  final String label;
  final double score;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool narrow = constraints.maxWidth < 460;

        final Widget bar = _AmbientProgressTrack(value: score);
        final Widget labelText = Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textFor(context),
              ),
        );

        if (narrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              labelText,
              SizedBox(height: ResponsiveLayout.space(1)),
              bar,
            ],
          );
        }

        return Row(
          children: <Widget>[
            SizedBox(width: 180, child: labelText),
            SizedBox(width: ResponsiveLayout.space(1.5)),
            Expanded(child: bar),
            SizedBox(width: ResponsiveLayout.space(1.5)),
            Text(
              '${(score * 100).round()}%',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.curveRed,
                    letterSpacing: 0.4,
                  ),
            ),
          ],
        );
      },
    );
  }
}
