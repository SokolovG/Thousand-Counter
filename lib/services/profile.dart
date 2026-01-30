import 'package:thousand_counter/core/utils/validators.dart';
import 'package:thousand_counter/data/repositories/profile.dart';
import 'package:thousand_counter/models/profile.dart';

class ProfileService {
  final ProfileRepository _repository;

  ProfileService(this._repository);

  Future<List<Profile>> getAllProfiles() async {
    final players = await _repository.getAllProfiles();
    return players;
  }

  Future<void> addProfile(String name) async {
    GameValidators.validateProfileName(name);

    final playerProfile = Profile(name: name);
    await _repository.addProfile(playerProfile);
  }

  Future<void> deleteProfile(String id) async {
    // Validate if it not finished games
    await _repository.deleteProfile(id);
  }
}
