import 'package:creative_curve_web/shared_widgets/agency_logo.dart';
import 'package:flutter/material.dart';

/// Team feature entry that showcases the Curve Crafters roster.
class TeamScreen extends StatelessWidget {
  /// Creates the team screen.
  const TeamScreen({super.key});

  static const List<_TeamMember> _members = <_TeamMember>[
    _TeamMember(
      name: 'Krystal',
      role: 'Project Manager',
      bio:
          'Orchestrates cross-functional delivery with a calm, outcomes-first approach to complex timelines.',
      hobbies: 'Long-form journaling, café scouting',
    ),
    _TeamMember(
      name: 'Zyle',
      role: 'Sales / Content Strategist',
      bio:
          'Translates audience behavior into campaigns that convert without losing cultural relevance.',
      hobbies: 'Street photography, trend tracking',
    ),
    _TeamMember(
      name: 'Erika',
      role: 'Creative Lead',
      bio:
          'Shapes bold visual systems and campaign concepts rooted in distinct brand narratives.',
      hobbies: 'Gallery hopping, typographic sketching',
    ),
    _TeamMember(
      name: 'JP',
      role: 'Media Producer',
      bio:
          'Builds cinematic production pipelines from pre-pro to post while protecting story quality.',
      hobbies: 'Film scoring, drone cinematography',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AgencyLogo()),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Curve Crafters', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text(
              'A multidisciplinary crew that turns strategic detours into market momentum.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: _members.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 360,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final member = _members[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(member.name, style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 4),
                          Text(member.role),
                          const SizedBox(height: 12),
                          Expanded(
                            child: Text(member.bio, style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          const SizedBox(height: 12),
                          Text('Hobbies: ${member.hobbies}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamMember {
  const _TeamMember({
    required this.name,
    required this.role,
    required this.bio,
    required this.hobbies,
  });

  final String name;
  final String role;
  final String bio;
  final String hobbies;
}
