import 'package:uuid/uuid.dart';

class PlayerProfile {
  final String id;
  final String name;

  PlayerProfile({required this.name, String? id}) : id = id ?? Uuid().v4();

  @override
  String toString() {
    return "Player $name, ID: $id";
  }
}
