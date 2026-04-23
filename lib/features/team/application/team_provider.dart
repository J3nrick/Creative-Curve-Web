import 'package:creative_curve_web/features/team/domain/team_member.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'team_provider.g.dart';

@riverpod
class TeamMembers extends _$TeamMembers {
  @override
  List<TeamMember> build() {
    return const <TeamMember>[
      TeamMember(
        name: 'Krystal',
        role: 'Project Manager',
        tagline: 'Disney princess spirit',
        specialty: 'Growth & Efficiency',
        hobbies: <String>['Travel', 'Singing'],
      ),
      TeamMember(
        name: 'Zyle',
        role: 'Sales / Content Strategist',
        tagline: 'Making things happen',
        specialty: 'Relationship amplifier',
        hobbies: <String>['Tennis', 'Golf', 'Cooking'],
      ),
      TeamMember(
        name: 'Erika',
        role: 'Creative Lead',
        tagline: 'Creative maarteng girly',
        specialty: 'Branding visionary',
        hobbies: <String>['Tennis', 'Golf', 'Oil Painting'],
      ),
      TeamMember(
        name: 'JP',
        role: 'Media Producer',
        tagline: 'High-quality visuals and storytelling',
        specialty: 'Visual narrative systems',
        hobbies: <String>['Photography', 'Cafe Hopping', 'Anime'],
      ),
    ];
  }
}
