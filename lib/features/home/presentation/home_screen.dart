import 'package:creative_curve_web/core/constants/brand_constants.dart';
import 'package:creative_curve_web/core/layout/responsive_layout.dart';
import 'package:creative_curve_web/shared_widgets/agency_logo.dart';
import 'package:creative_curve_web/shared_widgets/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Home feature entry: premium sliver-based landing page.
class HomeScreen extends StatelessWidget {
  /// Creates the home screen.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            title: const AgencyLogo(showTagline: true),
            actions: <Widget>[
              TextButton(
                onPressed: () => context.go('/team'),
                child: const Text('Team'),
              ),
              TextButton(
                onPressed: () => context.go('/services'),
                child: const Text('Services'),
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ResponsiveLayout(
                mobile: _HeroSection(maxWidth: double.infinity),
                tablet: _HeroSection(maxWidth: 700),
                desktop: _HeroSection(maxWidth: 900),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('The Curve', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 12),
                      Text(
                        BrandConstants.missionSecondary,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 320,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.3,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _ServiceTile(
                  title: BrandConstants.services[index],
                ),
                childCount: BrandConstants.services.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.maxWidth});

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Non-linear growth for ambitious brands.',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 16),
            Text(
              BrandConstants.missionPrimary,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            CurveButton(
              label: 'Meet the Curve Crafters',
              onPressed: () => context.go('/team'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceTile extends StatefulWidget {
  const _ServiceTile({required this.title});

  final String title;

  @override
  State<_ServiceTile> createState() => _ServiceTileState();
}

class _ServiceTileState extends State<_ServiceTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: _hovered
                ? const <Color>[Color(0x33FF365E), Color(0x3300A9FF)]
                : const <Color>[Color(0x1FFFFFFF), Color(0x1200A9FF)],
          ),
          border: Border.all(
            color: _hovered ? const Color(0xFF00A9FF) : const Color(0x55FFFFFF),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.auto_graph, color: Color(0xFF00A9FF)),
            const SizedBox(height: 14),
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            Text('Curve-led execution', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
