import 'package:thousand_counter/data/local/database.dart';
import 'package:thousand_counter/models/base_model.dart';

class Profile extends Entity {
  final String name;

  Profile({required this.name, super.id});

  @override
  String toString() {
    return "Player $name, ID: $id";
  }

  Profile copyWith({required String name}) {
    return Profile(name: name, id: id);
  }

  factory Profile.fromDb(ProfileModel model) {
    return Profile(name: model.name);
  }
}
