import 'package:go_router/go_router.dart';
import 'package:thousand_counter/ui/screens/game.dart';
import 'package:thousand_counter/ui/screens/game_settings.dart';
import 'package:thousand_counter/ui/screens/home.dart';
import 'package:thousand_counter/ui/screens/profiles.dart';
import 'package:thousand_counter/ui/screens/recent_games.dart';
import 'package:thousand_counter/ui/screens/settings.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/players_profiles',
      builder: (context, state) => const ProfilesScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/game/:gameId',
      builder: (context, state) {
        final gameId = state.pathParameters['gameId']!;
        return GameScreen(gameId: gameId);
      },
    ),
    GoRoute(
      path: '/recent_games',
      builder: (context, state) => const RecentGamesScreen(),
    ),
    GoRoute(
      path: '/game_settings',
      builder: (context, state) => const GameSettingsScreen(),
    ),
  ],
);
