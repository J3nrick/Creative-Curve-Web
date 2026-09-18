class TeamMember {
  const TeamMember({
    required this.name,
    required this.role,
    required this.focus,
    required this.personality,
    required this.hobbies,
    required this.imagePath,
    this.tagline = '',
    this.photoTodo = '',
  });

  final String name;
  final String role;
  final String focus;
  final String personality;
  final List<String> hobbies;
  final String imagePath;
  final String tagline;
  final String photoTodo;
}
