import 'package:thousand_counter/core/utils/validators.dart';
import 'package:thousand_counter/data/repositories/profile.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/models/profile.dart';

class ProfileService {
  final ProfileRepository _repository;

  ProfileService(this._repository);

  Future<List<Profile>> getAllProfiles() async {
    final players = await _repository.getAll();
    return players;
  }

  Future<void> addProfile(String name, AppLocalizations l10n) async {
    ProfileValidators.validateProfileName(name, l10n);

    final playerProfile = Profile(name: name);
    await _repository.add(playerProfile);
  }

  Future<void> updateProfile(Profile profile, AppLocalizations l10n) async {
    ProfileValidators.validateProfileName(profile.name, l10n);

    await _repository.update(profile);
  }

  Future<void> deleteProfile(String id) async {
    await _repository.delete(id);
  }
}
