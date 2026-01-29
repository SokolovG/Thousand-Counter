import 'package:go_router/go_router.dart';
import 'package:thousand_counter/ui/screens/game.dart';
import 'package:thousand_counter/ui/screens/game_settings.dart';
import 'package:thousand_counter/ui/screens/home.dart';
import 'package:thousand_counter/ui/screens/players.dart';
import 'package:thousand_counter/ui/screens/settings.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/players',
      builder: (context, state) => const PlayersScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/recent_games',
      builder: (context, state) => const GameScreen(),
    ),
    GoRoute(
      path: '/game_settings',
      builder: (context, state) => const GameSettingsScreen(),
    ),
  ],
);
