import 'package:uuid/uuid.dart';

class Profile {
  final String id;
  String name;

  Profile({required this.name, String? id}) : id = id ?? Uuid().v4();

  @override
  String toString() {
    return "Player $name, ID: $id";
  }
}
