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
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _searchQuery = '';

  static const List<String> _categories = <String>[
    'All',
    'Team & Squad',
    'Client Work',
    'Framework & Process',
    'Philosophy & Values',
    'Brand Identity',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim().toLowerCase();
    });
  }

  void _clearSearch() {
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    const List<GalleryItem> allItems = GalleryCatalog.items;

    final List<GalleryItem> filteredItems = allItems.where((GalleryItem item) {
      final bool matchesCategory =
          _selectedCategory == 'All' || item.category == _selectedCategory;
      if (!matchesCategory) return false;

      if (_searchQuery.isEmpty) return true;

      final bool matchesTitle = item.title.toLowerCase().contains(_searchQuery);
      final bool matchesDesc =
          item.description.toLowerCase().contains(_searchQuery);
      final bool matchesCat =
          item.category.toLowerCase().contains(_searchQuery);

      return matchesTitle || matchesDesc || matchesCat;
    }).toList();

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.06)
                          : const Color(0xFFEDEFF3),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '${filteredItems.length} of ${allItems.length} Assets',
                      style: TextStyle(
                        color: AppColors.mutedFor(context),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
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
              SizedBox(height: ResponsiveLayout.space(2)),

              // Search & Filter Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: ShapeDecoration(
                  color: AppColors.surfaceFor(context),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 16,
                      cornerSmoothing: 0.6,
                    ),
                    side: BorderSide(
                      color: AppColors.strokeFor(context),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      size: 18,
                      color: AppColors.curveRed,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(
                          color: AppColors.textFor(context),
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                        ),
                        cursorColor: AppColors.curveRed,
                        decoration: InputDecoration(
                          hintText: 'Filter vault assets (e.g. "Solita", "Matcha", "Team", "Pillars")...',
                          hintStyle: TextStyle(
                            color: AppColors.mutedFor(context),
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      IconButton(
                        onPressed: _clearSearch,
                        tooltip: 'Clear search',
                        icon: Icon(
                          Icons.cancel_rounded,
                          size: 16,
                          color: AppColors.mutedFor(context),
                        ),
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(24, 24),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: ResponsiveLayout.space(1.5)),

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

              // Grid of Visual Cards or Empty State
              if (filteredItems.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                  decoration: ShapeDecoration(
                    color: AppColors.surfaceFor(context),
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 22,
                        cornerSmoothing: 0.6,
                      ),
                      side: BorderSide(
                        color: AppColors.strokeFor(context),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                        color: AppColors.mutedFor(context),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'No Vault Assets Match "$_searchQuery"',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textFor(context),
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Try searching for different keywords or reset your category filter.',
                        style: TextStyle(
                          color: AppColors.mutedFor(context),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 18),
                      OutlinedButton.icon(
                        onPressed: () {
                          _clearSearch();
                          setState(() => _selectedCategory = 'All');
                        },
                        icon: const Icon(Icons.refresh_rounded, size: 14),
                        label: const Text('Reset Filters'),
                      ),
                    ],
                  ),
                )
              else
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
