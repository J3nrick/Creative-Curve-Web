import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/features/team/application/team_provider.dart';
import 'package:creative_curve_web/features/team/domain/team_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamScreen extends ConsumerWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TeamMember> members = ref.watch(teamMembersProvider);

    return CustomScrollView(
      slivers: <Widget>[
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(28, 30, 28, 12),
            child: Text('The Curve Crafters'),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _MemberCard(member: members[index]);
              },
              childCount: members.length,
            ),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 420,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.12,
            ),
          ),
        ),
      ],
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
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color: _hovered
                ? AppColors.curveRed.withValues(alpha: 0.8)
                : Colors.white.withValues(alpha: 0.1),
          ),
          boxShadow: <BoxShadow>[
            if (_hovered)
              BoxShadow(
                color: AppColors.curveRed.withValues(alpha: 0.24),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.member.name, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 2),
            Text(
              widget.member.role,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.electricBlue),
            ),
            const SizedBox(height: 12),
            Text(
              widget.member.tagline,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              widget.member.specialty,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            ),
            const Spacer(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.member.hobbies
                  .map(
                    (String hobby) => Chip(
                      label: Text(hobby),
                      backgroundColor: AppColors.electricBlue.withValues(alpha: 0.2),
                      side: BorderSide(color: AppColors.electricBlue.withValues(alpha: 0.35)),
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
