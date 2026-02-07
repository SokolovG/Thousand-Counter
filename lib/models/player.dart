import 'profile.dart';

class Player {
  final Profile profile;
  final int totalPoints;
  final int boltsCount;
  final bool isOnBarrel;
  final int barrelAttempts;

  Player({
    required this.profile,
    this.totalPoints = 0,
    this.boltsCount = 0,
    this.isOnBarrel = false,
    this.barrelAttempts = 0,
  });

  Player copyWith({
    int? boltsCount,
    Profile? profile,
    int? totalPoints,
    int? barrelsCount,
    int? barrelAttempts,
    bool? isOnBarrel,
  }) {
    return Player(
      profile: profile ?? this.profile,
      totalPoints: totalPoints ?? this.totalPoints,
      boltsCount: boltsCount ?? this.boltsCount,
      barrelAttempts: barrelAttempts ?? this.barrelAttempts,
      isOnBarrel: isOnBarrel ?? this.isOnBarrel,
    );
  }
}
