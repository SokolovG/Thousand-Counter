import 'profile.dart';

class Player {
  final Profile profile;
  final int totalPoints;
  final int boltsCount;
  final int barrelCount;

  Player({
    required this.profile,
    this.totalPoints = 0,
    this.boltsCount = 0,
    this.barrelCount = 0,
  });

  Player copyWith({
    int? boltsCount,
    Profile? profile,
    int? totalPoints,
    int? barrelsCount,
  }) {
    return Player(
      profile: profile ?? this.profile,
      totalPoints: totalPoints ?? this.totalPoints,
      boltsCount: boltsCount ?? this.boltsCount,
      barrelCount: barrelsCount ?? barrelCount,
    );
  }
}
