import 'player_profile.dart';

class PlayerGameState {
  final PlayerProfile profile;
  int totalPoints;
  int boltsCount;

  PlayerGameState({
    required this.profile,
    this.totalPoints = 0,
    this.boltsCount = 0,
  });
}
