import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/presentation/screens/game_settings.dart';
import 'package:thousand_counter/presentation/screens/players.dart';
import 'package:thousand_counter/presentation/screens/settings.dart';
import 'package:thousand_counter/presentation/widgets/buttons/menu_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thousand Counter"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton(
              text: "Create new game",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameSettingsScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 40),
            MenuButton(
              text: "Continue recent games",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameSettingsScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 40),
            MenuButton(text: "Recent games", onPressed: () {}),
            SizedBox(height: 40),
            MenuButton(
              text: "Players",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayersScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
