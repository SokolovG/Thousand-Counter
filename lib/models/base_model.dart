import 'package:uuid/uuid.dart';

class Entity {
  final String id;

  Entity({String? id}) : id = id ?? const Uuid().v4();
}
