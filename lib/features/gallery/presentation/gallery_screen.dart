import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/features/gallery/data/gallery_catalog.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
import 'package:creative_curve_web/shared/widgets/liquid_glass_image_card.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<GalleryItem> items = GalleryCatalog.items;
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
                'Gallery',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.textFor(context),
                    ),
              ),
              SizedBox(height: ResponsiveLayout.space(1)),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  'Every frame in sequence — campaign stills, culinary systems, and studio identity rendered in liquid glass.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.mutedFor(context),
                      ),
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
                    children: List<Widget>.generate(items.length, (int index) {
                      final GalleryItem item = items[index];
                      return SizedBox(
                        width: columns == 1 ? constraints.maxWidth : tileWidth,
                        child: AspectRatio(
                          aspectRatio: item.aspectRatio * 0.78,
                          child: LiquidGlassImageCard(
                            path: item.path,
                            title: item.title,
                            category: item.category,
                            aspectRatio: item.aspectRatio,
                            isNetwork: item.isNetwork,
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
