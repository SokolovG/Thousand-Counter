import 'package:thousand_counter/data/repositories/abstract_repositories.dart';
import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/models/player.dart';
import 'package:thousand_counter/models/profile.dart';

class GameRepository implements AbstractRepository<Game> {
  final List<Game> _games = [];

  GameRepository() {
    Profile profile1 = Profile(name: 'Sonya');
    Profile profile2 = Profile(name: 'Grischa');
    Player player1 = Player(profile: profile1);
    Player player2 = Player(profile: profile2);
    List<Player> players = [player1, player2];
    _games.addAll([
      Game(players: players, isFinished: true),
      Game(players: players, isFinished: false),
    ]);
  }

  @override
  Future<List<Game>> add(Game game) async {
    _games.add(game);
    return _games;
  }

  @override
  Future<void> delete(String id) async {
    _games.removeWhere((game) => game.id == id);
  }

  @override
  Future<Game?> get(String id) async {
    try {
      Game game = _games.firstWhere((game) => game.id == id);
      return game;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Game>> getAll() async {
    return List.from(_games);
  }

  @override
  Future update(Game updatedGame) async {
    final index = _games.indexWhere((game) => game.id == updatedGame.id);
    if (index != -1) {
      _games[index] = updatedGame;
    }
    return updatedGame;
  }
}
