class Player {
  final String name;
  final String id;
  int totalPoints;

  Player({required this.id, required this.name, this.totalPoints = 0});

  @override
  String toString() {
    return name;
  }
}
