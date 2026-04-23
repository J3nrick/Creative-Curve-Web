class TeamMember {
  const TeamMember({
    required this.name,
    required this.role,
    required this.tagline,
    required this.specialty,
    required this.hobbies,
  });

  final String name;
  final String role;
  final String tagline;
  final String specialty;
  final List<String> hobbies;
}
