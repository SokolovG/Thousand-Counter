import 'package:thousand_counter/data/repositories/player.dart';
import 'package:thousand_counter/models/player_profile.dart';

class ProfileService {
  final PlayerProfileRepository _repository;

  ProfileService(this._repository)
  
  Future<List<PlayerProfile>> getAllProfiles () async {
    final players = await _repository.getAllProfiles();
    return players;
  }

  Future<void> addPlayer(String name) async  {
    if (name.isEmpty) {
      throw Exception('Name cannot be empty');
    }

     final playerProfile = PlayerProfile(name: name);
     await _repository.addPlayer(playerProfile);
  }

  Future<void> deletePlayer(String id) async {
    // Validate if it not finished games
    await _repository.deletePlayer(id);
  }
}
