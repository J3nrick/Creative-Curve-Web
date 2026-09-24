import 'dart:ui';

import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/core/theme/curve_theme_extension.dart';
import 'package:creative_curve_web/core/theme/theme_mode_provider.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum _CommandCategory { navigation, disciplines, crafters, actions }

class _CommandItem {
  const _CommandItem({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    this.badge,
    this.route,
    this.action,
  });

  final String title;
  final String subtitle;
  final _CommandCategory category;
  final IconData icon;
  final String? badge;
  final String? route;
  final void Function(BuildContext context, WidgetRef ref)? action;
}

/// Apple/macOS Spotlight-grade Command Palette for Creative Curve Studios.
/// Triggered via ⌘K / Ctrl+K or studio interface buttons.
class StudioCommandPalette extends ConsumerStatefulWidget {
  const StudioCommandPalette({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => const StudioCommandPalette(),
    );
  }

  @override
  ConsumerState<StudioCommandPalette> createState() =>
      _StudioCommandPaletteState();
}

class _StudioCommandPaletteState extends ConsumerState<StudioCommandPalette> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int _selectedIndex = 0;

  static final List<_CommandItem> _allItems = <_CommandItem>[
    // NAVIGATION
    const _CommandItem(
      title: 'Studio Overview & Deck',
      subtitle: 'Home viewport, studio bento grid, and commercial showcase',
      category: _CommandCategory.navigation,
      icon: Icons.home_rounded,
      badge: '/',
      route: '/',
    ),
    const _CommandItem(
      title: 'Capabilities & Disciplines',
      subtitle: 'Full scope of creative, visual, motion, and digital services',
      category: _CommandCategory.navigation,
      icon: Icons.grid_view_rounded,
      badge: '/services',
      route: '/services',
    ),
    const _CommandItem(
      title: 'Studio Archives & Vault',
      subtitle: 'High-res photography, commercial assets, and frameworks',
      category: _CommandCategory.navigation,
      icon: Icons.photo_library_rounded,
      badge: '/gallery',
      route: '/gallery',
    ),
    const _CommandItem(
      title: 'The Crafters Collective',
      subtitle: 'Meet our interdisciplinary squad of creative specialists',
      category: _CommandCategory.navigation,
      icon: Icons.group_rounded,
      badge: '/team',
      route: '/team',
    ),
    const _CommandItem(
      title: 'Start A Project Brief',
      subtitle: 'Initiate a project intake, explore scopes and timelines',
      category: _CommandCategory.navigation,
      icon: Icons.mail_rounded,
      badge: '/contacts',
      route: '/contacts',
    ),

    // DISCIPLINES
    const _CommandItem(
      title: 'Design Creation & Direction',
      subtitle: 'Adaptive brand identity systems and kinetic motion rules',
      category: _CommandCategory.disciplines,
      icon: Icons.palette_rounded,
      badge: 'Brand',
      route: '/services',
    ),
    const _CommandItem(
      title: 'Commercial Film & Video Editing',
      subtitle: 'Cinematic pacing, color grading, and commercial polish',
      category: _CommandCategory.disciplines,
      icon: Icons.movie_filter_rounded,
      badge: 'Production',
      route: '/services',
    ),
    const _CommandItem(
      title: 'Motion Graphics & Animation',
      subtitle: 'High-clarity kinetic systems and animated title sequences',
      category: _CommandCategory.disciplines,
      icon: Icons.animation_rounded,
      badge: 'Motion',
      route: '/services',
    ),
    const _CommandItem(
      title: 'Commercial Food & Lifestyle Cinematography',
      subtitle: 'Artisanal styling, macro lighting, and packaging suites',
      category: _CommandCategory.disciplines,
      icon: Icons.camera_alt_rounded,
      badge: 'Culinary',
      route: '/services',
    ),
    const _CommandItem(
      title: 'Ultra-Fluid Digital Experiences',
      subtitle: '60fps micro-animations, squircle geometry, and high-speed web',
      category: _CommandCategory.disciplines,
      icon: Icons.devices_rounded,
      badge: 'Digital',
      route: '/services',
    ),

    // CRAFTERS
    const _CommandItem(
      title: 'Krystal — Project Management & Strategy',
      subtitle: 'Orchestration, sprint pacing, client alignment, and delivery',
      category: _CommandCategory.crafters,
      icon: Icons.person_rounded,
      badge: 'Lead',
      route: '/team',
    ),
    const _CommandItem(
      title: 'JP — Creative Direction & Video Craft',
      subtitle: 'Cinematic direction, pacing, rhythm, and narrative polish',
      category: _CommandCategory.crafters,
      icon: Icons.person_rounded,
      badge: 'Director',
      route: '/team',
    ),
    const _CommandItem(
      title: 'Zyle — Sales Velocity & Client Relations',
      subtitle: 'Commercial strategy, brand alignment, and campaign scope',
      category: _CommandCategory.crafters,
      icon: Icons.person_rounded,
      badge: 'Sales',
      route: '/team',
    ),
    const _CommandItem(
      title: 'Erika — Production & Media Specialist',
      subtitle: 'Culinary styling, lighting choreography, and editorial assets',
      category: _CommandCategory.crafters,
      icon: Icons.person_rounded,
      badge: 'Producer',
      route: '/team',
    ),

    // STUDIO ACTIONS
    _CommandItem(
      title: 'Toggle Theme Mode',
      subtitle: 'Switch instantaneously between Dark Mode and Light Mode',
      category: _CommandCategory.actions,
      icon: Icons.brightness_6_rounded,
      badge: 'Theme',
      action: (BuildContext context, WidgetRef ref) {
        ref.read(themeModeProvider.notifier).toggle();
        Navigator.of(context).pop();
      },
    ),
    _CommandItem(
      title: 'Copy Studio Email',
      subtitle: 'hello@creativecurve.ph (Direct intake inbox)',
      category: _CommandCategory.actions,
      icon: Icons.copy_rounded,
      badge: 'Email',
      action: (BuildContext context, WidgetRef ref) {
        Clipboard.setData(const ClipboardData(text: 'hello@creativecurve.ph'));
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text('Studio email copied to clipboard (hello@creativecurve.ph)'),
              ],
            ),
            backgroundColor: AppColors.curveRed,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  List<_CommandItem> _getFilteredItems() {
    final String query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      return _allItems;
    }
    return _allItems.where((_CommandItem item) {
      return item.title.toLowerCase().contains(query) ||
          item.subtitle.toLowerCase().contains(query) ||
          (item.badge != null && item.badge!.toLowerCase().contains(query));
    }).toList();
  }

  void _executeItem(_CommandItem item) {
    if (item.action != null) {
      item.action!(context, ref);
    } else if (item.route != null) {
      Navigator.of(context).pop();
      context.go(item.route!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;
    final CurveThemeExtension tokens = context.curveTheme;
    final List<_CommandItem> filtered = _getFilteredItems();

    if (_selectedIndex >= filtered.length && filtered.isNotEmpty) {
      _selectedIndex = filtered.length - 1;
    }

    final SmoothBorderRadius radius = SmoothBorderRadius(
      cornerRadius: 22,
      cornerSmoothing: 0.6,
    );

    return Focus(
      autofocus: true,
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            if (filtered.isNotEmpty) {
              setState(() {
                _selectedIndex = (_selectedIndex + 1) % filtered.length;
              });
            }
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            if (filtered.isNotEmpty) {
              setState(() {
                _selectedIndex =
                    (_selectedIndex - 1 + filtered.length) % filtered.length;
              });
            }
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.enter) {
            if (filtered.isNotEmpty && _selectedIndex < filtered.length) {
              _executeItem(filtered[_selectedIndex]);
            }
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.escape) {
            Navigator.of(context).pop();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640, maxHeight: 520),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: Container(
                decoration: ShapeDecoration(
                  color: isDark
                      ? const Color(0xFF131317).withValues(alpha: 0.94)
                      : Colors.white.withValues(alpha: 0.96),
                  shape: SmoothRectangleBorder(
                    borderRadius: radius,
                    side: BorderSide(
                      color: isDark
                          ? const Color(0x33FFFFFF)
                          : const Color(0x1F000000),
                      width: 1.0,
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.5 : 0.15),
                      blurRadius: 40,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search Input Bar
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 14, 14, 12),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search_rounded,
                            size: 20,
                            color: AppColors.curveRed,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              focusNode: _focusNode,
                              style: TextStyle(
                                color: tokens.textPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              cursorColor: AppColors.curveRed,
                              decoration: InputDecoration(
                                hintText: 'Type a command, page, or craft discipline...',
                                hintStyle: TextStyle(
                                  color: tokens.textMuted,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : const Color(0xFFE9ECF0),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'ESC',
                              style: TextStyle(
                                color: tokens.textMuted,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: tokens.stroke),

                    // Results List
                    Flexible(
                      child: filtered.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(36),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.search_off_rounded,
                                    size: 32,
                                    color: tokens.textMuted,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'No commands found',
                                    style: TextStyle(
                                      color: tokens.textPrimary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Try searching for "Brand", "Team", "Services", or "Email"',
                                    style: TextStyle(
                                      color: tokens.textMuted,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              itemCount: filtered.length,
                              itemBuilder: (BuildContext context, int index) {
                                final _CommandItem item = filtered[index];
                                final bool isSelected = index == _selectedIndex;

                                return MouseRegion(
                                  onEnter: (_) =>
                                      setState(() => _selectedIndex = index),
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () => _executeItem(item),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 140),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 9,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.curveRed.withValues(
                                                alpha: isDark ? 0.16 : 0.1,
                                              )
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColors.curveRed.withValues(
                                                  alpha: 0.45,
                                                )
                                              : Colors.transparent,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 28,
                                            height: 28,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColors.curveRed
                                                  : tokens.textPrimary.withValues(
                                                      alpha: 0.06,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Icon(
                                              item.icon,
                                              size: 15,
                                              color: isSelected
                                                  ? Colors.white
                                                  : tokens.textPrimary,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.title,
                                                  style: TextStyle(
                                                    color: isSelected
                                                        ? (isDark
                                                            ? Colors.white
                                                            : AppColors.curveRed)
                                                        : tokens.textPrimary,
                                                    fontWeight: isSelected
                                                        ? FontWeight.w700
                                                        : FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                Text(
                                                  item.subtitle,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: tokens.textMuted,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (item.badge != null) ...[
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 7,
                                                vertical: 3,
                                              ),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? AppColors.curveRed
                                                        .withValues(alpha: 0.2)
                                                    : tokens.textPrimary
                                                        .withValues(alpha: 0.05),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                item.badge!,
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? AppColors.curveRed
                                                      : tokens.textMuted,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                          if (isSelected) ...[
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.subdirectory_arrow_left_rounded,
                                              size: 14,
                                              color: AppColors.curveRed,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),

                    // Command Palette Footer
                    Divider(height: 1, color: tokens.stroke),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _FooterKeyHint(
                              keys: const ['↑', '↓'],
                              label: 'Navigate',
                              tokens: tokens,
                            ),
                            const SizedBox(width: 12),
                            _FooterKeyHint(
                              keys: const ['↵'],
                              label: 'Select',
                              tokens: tokens,
                            ),
                            const SizedBox(width: 12),
                            _FooterKeyHint(
                              keys: const ['ESC'],
                              label: 'Dismiss',
                              tokens: tokens,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Creative Curve Studios',
                              style: TextStyle(
                                color: tokens.textMuted,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterKeyHint extends StatelessWidget {
  const _FooterKeyHint({
    required this.keys,
    required this.label,
    required this.tokens,
  });

  final List<String> keys;
  final String label;
  final CurveThemeExtension tokens;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...keys.map(
          (k) => Container(
            margin: const EdgeInsets.only(right: 3),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : const Color(0xFFE9ECF0),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isDark ? const Color(0x22FFFFFF) : const Color(0x18000000),
                width: 0.8,
              ),
            ),
            child: Text(
              k,
              style: TextStyle(
                color: tokens.textPrimary,
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(
            color: tokens.textMuted,
            fontSize: 10.5,
          ),
        ),
      ],
    );
  }
}
