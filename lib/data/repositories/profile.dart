import 'package:thousand_counter/data/repositories/abstract_repositories.dart';
import 'package:thousand_counter/models/profile.dart';

class ProfileRepository implements AbstractRepository<Profile> {
  final List<Profile> _playersProfiles = [];

  ProfileRepository() {
    _playersProfiles.addAll([
      Profile(name: 'Sonya'),
      Profile(name: 'Grisha'),
      Profile(name: 'Mischa'),
      Profile(name: 'Nastya'),
      Profile(name: 'Marina'),
    ]);
  }

  @override
  Future<List<Profile>> getAll() async {
    return List.from(_playersProfiles);
  }

  @override
  Future add(Profile profile) async {
    _playersProfiles.add(profile);
    return _playersProfiles;
  }

  @override
  Future update(Profile updatedProfile) async {
    final index = _playersProfiles.indexWhere((p) => p.id == updatedProfile.id);
    if (index != -1) {
      _playersProfiles[index] = updatedProfile;
    }
    return updatedProfile;
  }

  @override
  Future<void> delete(String id) async {
    _playersProfiles.removeWhere((player) => player.id == id);
  }

  @override
  Future<Profile?> get(String id) async {
    try {
      return _playersProfiles.firstWhere((player) => player.id == id);
    } catch (e) {
      return null;
    }
  }
}
