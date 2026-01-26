import 'package:uuid/uuid.dart';

class PlayerProfile {
  final String id;
  final String name;
  final DateTime createdAt;

  PlayerProfile({required this.name, String? id})
    : id = id ?? Uuid().v4(),
      createdAt = DateTime.now();

  @override
  String toString() {
    return "Player $name, ID: $id";
  }
}
