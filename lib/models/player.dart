class Player {
  final String name;
  final String id;
  int totalPoints;
  int boltsCount;

  Player({
    required this.id,
    required this.name,
    this.totalPoints = 0,
    this.boltsCount = 0,
  });

  @override
  String toString() {
    return name;
  }
}
