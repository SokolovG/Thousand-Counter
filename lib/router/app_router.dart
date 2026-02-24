import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_counter/ui/screens/game.dart';
import 'package:thousand_counter/ui/screens/game_settings.dart';
import 'package:thousand_counter/ui/screens/home.dart';
import 'package:thousand_counter/ui/screens/onboarding.dart';
import 'package:thousand_counter/ui/screens/profiles.dart';
import 'package:thousand_counter/ui/screens/recent_games.dart';
import 'package:thousand_counter/ui/screens/settings.dart';
import 'package:thousand_counter/providers/settings_providers.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final onboardingShown = ref.watch(onboardingShownProvider);

  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        redirect: (context, state) {
          if (state.uri.toString() == '/' && !onboardingShown) {
            return '/onboarding';
          }
          return null;
        },
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
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
});
