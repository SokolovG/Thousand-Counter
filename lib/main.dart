import 'package:flutter/material.dart';
import 'package:thousand_counter/presentation/screens/home.dart';

void main() {
  runApp(const ThousandCounterApp());
}

class ThousandCounterApp extends StatelessWidget {
  const ThousandCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thousand Counter',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.green)),
      home: const MyHomePage(title: 'Thousand Counter'),
    );
  }
}

// import 'package:thousand_counter/models/game.dart';
// import 'package:thousand_counter/core/logger.dart';
// import 'package:thousand_counter/models/player_game_state.dart';
// import 'package:thousand_counter/models/player_profile.dart';
// import 'package:thousand_counter/services/game_service.dart';
// import 'package:thousand_counter/services/rules_service.dart';
// import 'package:thousand_counter/services/score_service.dart';

// void main() {
  // runApp(ThousandCounterApp());
  // RulesService rulesService = RulesService();
  // ScoreService scoreService = ScoreService();

  // PlayerProfile grischaProfile = PlayerProfile(id: "1", name: "grischa");
  // PlayerProfile sonyaProfile = PlayerProfile(id: "2", name: "sonya");

  // PlayerGameState grischa = PlayerGameState(profile: grischaProfile);
  // PlayerGameState sonya = PlayerGameState(profile: sonyaProfile);

  // GameService gameS = GameService(rulesService, scoreService);
  // Game game = gameS.createGame([grischa, sonya]);
  // AppLogger.info(game);
// }
