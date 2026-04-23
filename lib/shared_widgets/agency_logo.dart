import 'package:flutter/material.dart';

/// Compact brand mark used in app bars and section headers.
class AgencyLogo extends StatelessWidget {
  /// Creates a compact logo lockup with icon and wordmark.
  const AgencyLogo({this.showTagline = false, super.key});

  /// Displays a small tagline beneath the primary wordmark when true.
  final bool showTagline;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.scatter_plot_outlined,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Creative Curve', style: textTheme.titleLarge),
            if (showTagline)
              Text(
                'Studios',
                style: textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
