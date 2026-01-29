import 'player_profile.dart';

class Player {
  final PlayerProfile profile;
  int totalPoints;
  int boltsCount;

  Player({required this.profile, this.totalPoints = 0, this.boltsCount = 0});
}
