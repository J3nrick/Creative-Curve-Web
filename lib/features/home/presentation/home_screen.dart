import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/widgets/curve_cta_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<(String, String)> _pillars = <(String, String)>[
    ('Transparent', 'Clear communication and honest expectations from kickoff to delivery.'),
    ('Respectful', 'Every collaboration is built on trust, empathy, and professional integrity.'),
    ('Data-driven', 'Creative choices backed by measurable insights and real performance data.'),
    ('Purpose-driven', 'Every campaign is mapped to business outcomes that matter.'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            constraints: const BoxConstraints(minHeight: 480),
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.3,
                colors: <Color>[Color(0xFF1E1E1E), AppColors.background],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 52),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.electricBlue.withValues(alpha: 0.5)),
                    color: AppColors.electricBlue.withValues(alpha: 0.08),
                  ),
                  child: const Text('Curve Deck 2026'),
                ),
                const SizedBox(height: 26),
                Text(
                  'Because straightforward\nis too predictable.',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 760,
                  child: Text(
                    'We are storytellers, strategists, and curve crafters designing kinetic digital experiences for brands that refuse to blend in.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.muted),
                  ),
                ),
                const SizedBox(height: 28),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: <Widget>[
                    CurveCtaButton(
                      label: 'Meet The Curve Crafters',
                      onPressed: () => context.go('/team'),
                    ),
                    OutlinedButton(
                      onPressed: () => context.go('/services'),
                      child: const Text('Explore Services'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final (String title, String details) = _pillars[index];
                return _PillarCard(title: title, details: details);
              },
              childCount: _pillars.length,
            ),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 360,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.25,
            ),
          ),
        ),
      ],
    );
  }
}

class _PillarCard extends StatefulWidget {
  const _PillarCard({
    required this.title,
    required this.details,
  });

  final String title;
  final String details;

  @override
  State<_PillarCard> createState() => _PillarCardState();
}

class _PillarCardState extends State<_PillarCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.white.withValues(alpha: _isHovered ? 0.13 : 0.08),
              Colors.white.withValues(alpha: _isHovered ? 0.02 : 0.01),
            ],
          ),
          border: Border.all(
            color: _isHovered
                ? AppColors.electricBlue.withValues(alpha: 0.55)
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(
              widget.details,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
