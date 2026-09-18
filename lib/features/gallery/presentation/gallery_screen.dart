import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/features/gallery/data/gallery_catalog.dart';
import 'package:creative_curve_web/shared/layout/responsive_layout.dart';
import 'package:creative_curve_web/shared/widgets/liquid_glass_image_card.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String _selectedCategory = 'All';

  static const List<String> _categories = <String>[
    'All',
    'Team & Squad',
    'Client Work',
    'Framework & Process',
    'Philosophy & Values',
    'Brand Identity',
  ];

  @override
  Widget build(BuildContext context) {
    const List<GalleryItem> allItems = GalleryCatalog.items;
    final List<GalleryItem> filteredItems = _selectedCategory == 'All'
        ? allItems
        : allItems.where((item) => item.category == _selectedCategory).toList();

    final int columns = ResponsiveLayout.columnsFor(context);
    final bool isDark = AppColors.isDark(context);

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
              // Category Pill Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.curveRed.withValues(alpha: isDark ? 0.12 : 0.08),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: AppColors.curveRed.withValues(alpha: isDark ? 0.35 : 0.25),
                        width: 1.0,
                      ),
                    ),
                    child: const Text(
                      'STUDIO ARCHIVES',
                      style: TextStyle(
                        color: AppColors.curveRed,
                        fontWeight: FontWeight.w800,
                        fontSize: 10.5,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Gallery & Asset Vault',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.textFor(context),
                      fontWeight: FontWeight.w900,
                    ),
              ),
              SizedBox(height: ResponsiveLayout.space(1)),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 780),
                child: Text(
                  'Explore our official studio catalog in high definition — specialist portraits, commercial client production, strategic frameworks, and brand systems.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.mutedFor(context),
                        height: 1.5,
                      ),
                ),
              ),
              SizedBox(height: ResponsiveLayout.space(2.5)),

              // Filter Category Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: _categories.map((category) {
                    final bool active = _selectedCategory == category;
                    final int count = category == 'All'
                        ? allItems.length
                        : allItems
                            .where((item) => item.category == category)
                            .length;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 4),
                      child: InkWell(
                        onTap: () =>
                            setState(() => _selectedCategory = category),
                        borderRadius: BorderRadius.circular(999),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: ShapeDecoration(
                            color: active
                                ? AppColors.curveRed
                                : AppColors.surfaceFor(context),
                            shape: SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius(
                                cornerRadius: 999,
                                cornerSmoothing: 0.6,
                              ),
                              side: BorderSide(
                                color: active
                                    ? AppColors.curveRed
                                    : AppColors.strokeFor(context),
                                width: 1.0,
                              ),
                            ),
                            shadows: active
                                ? [
                                    BoxShadow(
                                      color: AppColors.curveRed
                                          .withValues(alpha: 0.28),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                category,
                                style: TextStyle(
                                  color: active
                                      ? Colors.white
                                      : AppColors.textFor(context),
                                  fontWeight: active
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  fontSize: 12.5,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: active
                                      ? Colors.white.withValues(alpha: 0.22)
                                      : AppColors.textFor(context)
                                          .withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  '$count',
                                  style: TextStyle(
                                    color: active
                                        ? Colors.white
                                        : AppColors.mutedFor(context),
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: ResponsiveLayout.space(2.5)),

              // Grid of Visual Cards
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double gap = ResponsiveLayout.space(2.5);
                  final double tileWidth =
                      (constraints.maxWidth - gap * (columns - 1)) / columns;

                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: List<Widget>.generate(filteredItems.length,
                        (int index) {
                      final GalleryItem item = filteredItems[index];
                      return SizedBox(
                        width: columns == 1 ? constraints.maxWidth : tileWidth,
                        child: AspectRatio(
                          aspectRatio: 1.16,
                          child: LiquidGlassImageCard(
                            path: item.path,
                            title: item.title,
                            category: item.category,
                            description: item.description,
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
