import 'package:thousand_counter/data/repositories/abstract_repositories.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/profile.dart';

class GameRepository implements AbstractRepository<Game> {
  final List<Game> _playersProfiles = [];

  GameRepository() {
    Profile profile1 = Profile(name: 'Sonya');
    Profile profile2 = Profile(name: 'Grischa');
    Player player1 = Player(profile: profile1);
    Player player2 = Player(profile: profile2);
    List<Player> players = [player1, player2];
    _playersProfiles.addAll([
      Game(players: players, isFinished: true),
      Game(players: players, isFinished: false),
    ]);
  }

  @override
  Future<void> add(Game game) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Game?> get(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Game>> getAll() {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> update(Game game) {
    throw UnimplementedError();
  }
}
