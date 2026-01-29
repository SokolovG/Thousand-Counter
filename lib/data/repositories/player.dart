import 'package:thousand_counter/data/repositories/abstract_repositories.dart';
import 'package:thousand_counter/models/player_profile.dart';

class PlayerProfileRepository implements AbstractPlayerProfileRepository {
  final List<PlayerProfile> _playersProfiles = [];

  PlayerProfileRepository() {
    _playersProfiles.addAll([
      PlayerProfile(id: '1', name: 'Sonya'),
      PlayerProfile(id: '2', name: 'Grisha'),
    ]);
  }

  @override
  Future<List<PlayerProfile>> getAllProfiles() async {
    return List.from(_playersProfiles);
  }

  @override
  Future addPlayer(PlayerProfile player) async {
    _playersProfiles.add(player);
    return _playersProfiles;
  }

  @override
  Future<void> deletePlayer(String id) async {
    _playersProfiles.removeWhere((player) => player.id == id);
  }

  @override
  Future<PlayerProfile?> getPlayer(String id) async {
    try {
      return _playersProfiles.firstWhere((player) => player.id == id);
    } catch (e) {
      return null;
    }
  }
}
