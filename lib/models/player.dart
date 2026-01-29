import 'profile.dart';

class Player {
  final Profile profile;
  int totalPoints;
  int boltsCount;

  Player({required this.profile, this.totalPoints = 0, this.boltsCount = 0});
}
