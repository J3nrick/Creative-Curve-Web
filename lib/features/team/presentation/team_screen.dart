import 'package:creative_curve_web/core/constants/app_assets.dart';
import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/features/team/application/team_provider.dart';
import 'package:creative_curve_web/features/team/domain/team_member.dart';
import 'package:creative_curve_web/shared/widgets/liquid_glass_image_card.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TeamScreen extends ConsumerStatefulWidget {
  const TeamScreen({super.key});

  @override
  ConsumerState<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends ConsumerState<TeamScreen> {
  bool _showCleanPortrait = false;

  @override
  Widget build(BuildContext context) {
    final List<TeamMember> members = ref.watch(teamMembersProvider);
    final bool isDark = AppColors.isDark(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 48),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool mobile = constraints.maxWidth < 860;
            final int columns = mobile ? 1 : 2;
            const double spacing = 20;
            final double cardWidth =
                (constraints.maxWidth - (spacing * (columns - 1))) / columns;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Section Header
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
                        'THE COLLECTIVE',
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
                  'The Curve Crafters',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppColors.textFor(context),
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 780),
                  child: Text(
                    'A multidisciplinary studio team blending strategic project leadership, sales velocity, creative direction, and cinematic media production into unified momentum.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.mutedFor(context),
                          height: 1.5,
                        ),
                  ),
                ),
                const SizedBox(height: 28),

                // Team Squad Hero Feature Banner
                _TeamHeroSquadBanner(
                  showCleanPortrait: _showCleanPortrait,
                  onTogglePortrait: () {
                    setState(() => _showCleanPortrait = !_showCleanPortrait);
                  },
                ),
                const SizedBox(height: 38),

                // Individual Crafter Profile Cards Grid
                Text(
                  'Core Specialists',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.textFor(context),
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: members
                      .map(
                        (TeamMember member) => SizedBox(
                          width: cardWidth,
                          child: _MemberCard(member: member),
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 48),

                // Bottom Callout
                _TeamFooterCta(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TeamHeroSquadBanner extends StatelessWidget {
  const _TeamHeroSquadBanner({
    required this.showCleanPortrait,
    required this.onTogglePortrait,
  });

  final bool showCleanPortrait;
  final VoidCallback onTogglePortrait;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);
    final String activeImage = showCleanPortrait
        ? AppAssets.teamCleanPortrait
        : AppAssets.teamAnthemSunglasses;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double bannerHeight = constraints.maxWidth < 700 ? 320 : 440;

        return ClipSmoothRect(
          radius: SmoothBorderRadius(
            cornerRadius: 24,
            cornerSmoothing: 0.6,
          ),
          child: Container(
            height: bannerHeight,
            width: double.infinity,
            decoration: ShapeDecoration(
              color: const Color(0xFF101014),
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: 24,
                  cornerSmoothing: 0.6,
                ),
                side: BorderSide(
                  color: AppColors.strokeFor(context),
                  width: 1.0,
                ),
              ),
              shadows: [
                BoxShadow(
                  color: (isDark ? Colors.black : const Color(0xFF101216))
                      .withValues(alpha: isDark ? 0.35 : 0.08),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Squad Image
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    activeImage,
                    key: ValueKey<String>(activeImage),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                // Gradient Scrim
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.15),
                        Colors.black.withValues(alpha: 0.8),
                      ],
                      stops: const [0.45, 1.0],
                    ),
                  ),
                ),
                // Overlay Info & Toggle
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 24,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'WE TAKE THE CURVE',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.5,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Four dedicated disciplines operating with unified precision.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white70,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: onTogglePortrait,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black.withValues(alpha: 0.55),
                          side: const BorderSide(color: Colors.white30, width: 1.0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        icon: Icon(
                          showCleanPortrait
                              ? Icons.subtitles_rounded
                              : Icons.photo_library_rounded,
                          size: 15,
                        ),
                        label: Text(
                          showCleanPortrait ? 'Show Tagline' : 'Clean Portrait',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MemberCard extends StatefulWidget {
  const _MemberCard({required this.member});

  final TeamMember member;

  @override
  State<_MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<_MemberCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translateByDouble(0, _hovered ? -4 : 0, 0, 1),
        decoration: ShapeDecoration(
          color: AppColors.elevatedSurfaceFor(context),
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 22,
              cornerSmoothing: 0.6,
            ),
            side: BorderSide(
              color: _hovered
                  ? AppColors.curveRed.withValues(alpha: isDark ? 0.6 : 0.45)
                  : AppColors.strokeFor(context),
              width: 1.0,
            ),
          ),
          shadows: <BoxShadow>[
            BoxShadow(
              color: (isDark ? Colors.black : const Color(0xFF101216))
                  .withValues(alpha: isDark ? (_hovered ? 0.35 : 0.2) : (_hovered ? 0.08 : 0.03)),
              blurRadius: _hovered ? 24 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Image Preview Header with 16:9 ratio
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: isDark ? const Color(0xFF0F0F12) : const Color(0xFFE9ECEF),
                    child: Image.asset(
                      widget.member.imagePath,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.45),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black.withValues(alpha: 0.6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(5),
                        minimumSize: const Size(30, 30),
                      ),
                      tooltip: 'View Profile Card',
                      onPressed: () {
                        showImageLightbox(
                          context,
                          path: widget.member.imagePath,
                          title: '${widget.member.name} — Profile Card',
                          category: 'Team Crafter',
                          description: widget.member.focus,
                        );
                      },
                      icon: const Icon(Icons.fullscreen_rounded, size: 16),
                    ),
                  ),
                ],
              ),
            ),

            // Card Body
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Member Name & Role Pill
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.member.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: AppColors.textFor(context),
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.curveRed.withValues(alpha: isDark ? 0.12 : 0.08),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: AppColors.curveRed.withValues(alpha: isDark ? 0.35 : 0.25),
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          widget.member.role,
                          style: const TextStyle(
                            color: AppColors.curveRed,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Focus & Responsibility
                  Text(
                    widget.member.focus,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.mutedFor(context),
                          height: 1.45,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Expertise / Passion Tags
                  Text(
                    'CORE EXPERTISE & PASSIONS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                      color: AppColors.subtleFor(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.member.hobbies
                        .map(
                          (String hobby) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.05)
                                  : const Color(0xFFF0F2F5),
                              border: Border.all(
                                color: AppColors.strokeFor(context),
                                width: 1.0,
                              ),
                            ),
                            child: Text(
                              hobby,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.textFor(context),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.5,
                                  ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamFooterCta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: ShapeDecoration(
        color: AppColors.surfaceFor(context),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 22,
            cornerSmoothing: 0.6,
          ),
          side: BorderSide(color: AppColors.strokeFor(context), width: 1.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Want to build the next curve with us?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textFor(context),
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Let’s collaborate on your brand’s next breakthrough campaign.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.mutedFor(context),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          FilledButton.icon(
            onPressed: () => context.go('/contacts'),
            icon: const Icon(Icons.arrow_forward_rounded, size: 15),
            label: const Text('Start A Project'),
          ),
        ],
      ),
    );
  }
}
