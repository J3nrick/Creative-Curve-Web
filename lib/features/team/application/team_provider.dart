import 'package:creative_curve_web/core/constants/app_assets.dart';
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
        role: 'Project Manager & Operations Lead',
        tagline:
            'Orchestrating high-impact brand delivery with disciplined strategy and collaborative leadership.',
        focus:
            'Krystal leads and manages projects from inception to final delivery, ensuring alignment with core business objectives. She specializes in streamlining creative workflows, driving interdisciplinary collaboration, and maintaining uncompromising delivery standards.',
        personality: 'Disciplined leadership paired with inspiring collaborative energy.',
        hobbies: <String>['Global Travel', 'Acoustic Music', 'Design Exploration'],
        imagePath: AppAssets.profileKrystal,
        photoTodo: 'Krystal Profile Card',
      ),
      TeamMember(
        name: 'Zyle',
        role: 'Sales & Content Strategist',
        tagline:
            'Driving client velocity and market impact through high-converting content architectures.',
        focus:
            'Zyle develops high-converting content frameworks and builds enduring client partnerships. He connects brand narratives with actionable distribution strategies that generate measurable market momentum.',
        personality: 'High-velocity operator focused on strategic growth and execution.',
        hobbies: <String>['Tennis & Golf', 'Strategic Gaming', 'Creative Conceptualization'],
        imagePath: AppAssets.profileZyle,
        photoTodo: 'Zyle Profile Card',
      ),
      TeamMember(
        name: 'Erika',
        role: 'Creative Director & Design Lead',
        tagline:
            'Crafting bespoke design systems, brand identities, and immersive visual storytelling.',
        focus:
            'Erika directs end-to-end visual vision and brand architecture across all client touchpoints. She oversees asset creation, art direction, and typography systems to ensure consistent aesthetic excellence.',
        personality: 'Curates bold visual languages with meticulous attention to craft.',
        hobbies: <String>['Tennis', 'Golf', 'Fine Art & Painting'],
        imagePath: AppAssets.profileErika,
        photoTodo: 'Erika Profile Card',
      ),
      TeamMember(
        name: 'JP',
        role: 'Media Producer & Cinematographer',
        tagline:
            'Directing cinematic visual narratives and commercial media that elevate brand prestige.',
        focus:
            'JP specializes in high-fidelity commercial photography, video direction, and cinematic post-production. From pre-production planning to precision color grading, he ensures every visual asset tells a compelling story.',
        personality: 'Cinematic visual storytelling and dynamic motion craft.',
        hobbies: <String>['Commercial Photography', 'Specialty Coffee', 'Animation Arts'],
        imagePath: AppAssets.profileJp,
        photoTodo: 'JP Profile Card',
      ),
    ];
  }
}
