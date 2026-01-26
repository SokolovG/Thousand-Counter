import 'package:thousand_counter/models/game.dart';
import 'package:thousand_counter/core/logger.dart';
import 'package:thousand_counter/models/player_game_state.dart';
import 'package:thousand_counter/models/player_profile.dart';
import 'package:thousand_counter/services/game_service.dart';
import 'package:thousand_counter/services/rules_service.dart';
import 'package:thousand_counter/services/score_service.dart';

void main() {
  RulesService rulesService = RulesService();
  ScoreService scoreService = ScoreService();

  PlayerProfile grischaProfile = PlayerProfile(id: "1", name: "grischa");
  PlayerProfile sonyaProfile = PlayerProfile(id: "2", name: "sonya");

  PlayerGameState grischa = PlayerGameState(playerId: grischaProfile.id);
  PlayerGameState sonya = PlayerGameState(playerId: sonyaProfile.id);

  Game game = Game(
    playerStates: [sonya, grischa],
    profiles: [grischaProfile, sonyaProfile],
  );
  GameService gameS = GameService(rulesService, scoreService);
  AppLogger.info(game);
}
