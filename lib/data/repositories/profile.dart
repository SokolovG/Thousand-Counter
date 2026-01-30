import 'package:thousand_counter/data/repositories/abstract_repositories.dart';
import 'package:thousand_counter/models/profile.dart';

class ProfileRepository implements AbstractProfileRepository {
  final List<Profile> _playersProfiles = [];

  ProfileRepository() {
    _playersProfiles.addAll([
      Profile(id: '1', name: 'Sonya'),
      Profile(id: '2', name: 'Grisha'),
      Profile(id: '3', name: 'Mischa'),
      Profile(id: '4', name: 'Nastya'),
      Profile(id: '5', name: 'Marina'),
    ]);
  }

  @override
  Future<List<Profile>> getAllProfiles() async {
    return List.from(_playersProfiles);
  }

  @override
  Future addProfile(Profile player) async {
    _playersProfiles.add(player);
    return _playersProfiles;
  }

  @override
  Future<void> deleteProfile(String id) async {
    _playersProfiles.removeWhere((player) => player.id == id);
  }

  @override
  Future<Profile?> getProfile(String id) async {
    try {
      return _playersProfiles.firstWhere((player) => player.id == id);
    } catch (e) {
      return null;
    }
  }
}
