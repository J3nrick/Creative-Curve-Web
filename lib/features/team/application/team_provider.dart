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
        focus:
            'Growth, efficiency, and project collaboration from start to finish.',
        personality: 'Keeps teams aligned, calm, and moving with precision.',
        hobbies: <String>['Travel', 'Singing', 'Exploring new things'],
        photoTodo: 'Team Photo 1',
      ),
      TeamMember(
        name: 'Zyle',
        role: 'Sales & Content',
        focus:
            'Campaign storytelling, sales velocity, and unconventional strategy.',
        personality: 'The go-to operator for making things happen at speed.',
        hobbies: <String>['Tennis', 'Golf', 'Mobile games', 'Cooking'],
        photoTodo: 'Team Photo 2',
      ),
      TeamMember(
        name: 'Erika',
        role: 'Creative Lead',
        focus:
            'Creative vision, branding direction, and final review of assets and copy.',
        personality: 'Crafts bold visual systems with intentional detail.',
        hobbies: <String>['Tennis', 'Golf', 'Oil Painting'],
        photoTodo: 'Team Photo 3',
      ),
      TeamMember(
        name: 'JP',
        role: 'Media Producer',
        focus:
            'High-quality visual storytelling through photo and video production.',
        personality: 'Turns concepts into polished visual narratives.',
        hobbies: <String>['Photography', 'Cafe Hopping', 'Anime'],
        photoTodo: 'Team Photo 4',
      ),
    ];
  }
}
