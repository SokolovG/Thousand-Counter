import 'package:thousand_counter/models/player_profile.dart';

abstract class AbstractProfileRepository {
  Future<List<Profile>> getAllProfiles();
  Future<void> addPlayer(Profile player);
  Future<void> deletePlayer(String id);
  Future<Profile?> getPlayer(String id);
}
