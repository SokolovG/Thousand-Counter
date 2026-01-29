import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/player_profile.dart';

abstract class AbstractPlayerProfileRepository {
  Future<List<PlayerProfile>> getAllProfiles();
  Future<void> addPlayer(PlayerProfile player);
  Future<void> deletePlayer(String id);
  Future<PlayerProfile?> getPlayer(String id);
}

abstract class AbstractPlayerRepository {
  Future<List<Player>> getAllPlayers();
  Future<void> deletePlayer(String id);
  Future<PlayerProfile?> getPlayer(String id);
}
