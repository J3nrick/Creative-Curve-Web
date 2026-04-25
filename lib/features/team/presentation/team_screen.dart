import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/features/team/application/team_provider.dart';
import 'package:creative_curve_web/features/team/domain/team_member.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamScreen extends ConsumerWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TeamMember> members = ref.watch(teamMembersProvider);

    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool mobile = constraints.maxWidth < 900;
            final int columns = mobile
                ? 1
                : constraints.maxWidth < 1380
                    ? 2
                    : 3;
            const double spacing = 16;
            final double cardWidth =
                (constraints.maxWidth - (spacing * (columns - 1))) / columns;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('The Curve Crafters',
                    style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Text(
                    'A multi-disciplinary squad blending project execution, sales storytelling, creative strategy, and visual production.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.mutedFor(context)),
                  ),
                ),
                const SizedBox(height: 20),
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
              ],
            );
          },
        ),
      ),
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
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 230),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translateByDouble(0, _hovered ? -4 : 0, 0, 1),
        padding: const EdgeInsets.all(18),
        decoration: ShapeDecoration(
          color: AppColors.elevatedSurfaceFor(context),
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 20,
              cornerSmoothing: 0.6,
            ),
            side: BorderSide(
              color: _hovered
                  ? AppColors.curveRed.withValues(alpha: 0.75)
                  : AppColors.strokeFor(context),
            ),
          ),
          shadows: <BoxShadow>[
            BoxShadow(
              color: _hovered
                  ? AppColors.curveRed.withValues(alpha: 0.18)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: _hovered ? 20 : 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.curveRed.withValues(alpha: 0.16),
                  ),
                  child: Text(
                    widget.member.name.isEmpty
                        ? '?'
                        : widget.member.name.substring(0, 1).toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.curveRed,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.member.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.textFor(context),
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.member.role,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.electricBlue,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.member.focus,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    height: 1.2,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.member.personality,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.mutedFor(context),
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.member.hobbies
                  .map(
                    (String hobby) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: AppColors.electricBlue.withValues(alpha: 0.16),
                        border: Border.all(
                          color: AppColors.electricBlue.withValues(alpha: 0.36),
                        ),
                      ),
                      child: Text(
                        hobby,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textFor(context),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
