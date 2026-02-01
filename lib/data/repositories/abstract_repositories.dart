import 'package:thousand_counter/models/profile.dart';

abstract class AbstractProfileRepository {
  Future<List<Profile>> getAllProfiles();
  Future<void> addProfile(Profile player);
  Future<void> deleteProfile(String id);
  Future<Profile?> getProfile(String id);
  Future updateProfile(String id, String newName);
}
