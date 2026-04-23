import 'package:creative_curve_web/core/constants/brand_constants.dart';
import 'package:creative_curve_web/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Services feature entry with interactive tiles.
class ServicesScreen extends StatelessWidget {
  /// Creates the services screen.
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Services')),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: BrandConstants.services.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 320,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.3,
        ),
        itemBuilder: (context, index) => _InteractiveTile(title: BrandConstants.services[index]),
      ),
    );
  }
}

class _InteractiveTile extends StatefulWidget {
  const _InteractiveTile({required this.title});

  final String title;

  @override
  State<_InteractiveTile> createState() => _InteractiveTileState();
}

class _InteractiveTileState extends State<_InteractiveTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTheme.tileAnimationDuration,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _isHovered ? AppTheme.tileHoverRedTint : AppTheme.tileBaseWhiteTint,
          border: Border.all(
            color: _isHovered ? AppTheme.electricBlue : AppTheme.tileBorderIdle,
          ),
        ),
        padding: const EdgeInsets.all(18),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
        ),
      ),
    );
  }
}
