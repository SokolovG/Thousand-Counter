import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/presentation/screens/game.dart';
import 'package:thousand_counter/presentation/widgets/buttons/menu_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thousand Counter"),
        // backgroundColor: const Color.fromARGB(255, 74, 179, 18),
      ),
      body: Padding(
        padding: const EdgeInsets.all(120.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton(
              text: "Create game",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
            ),
            SizedBox(height: 40),
            MenuButton(text: "History of games", onPressed: () {}),
            SizedBox(height: 40),
            MenuButton(text: "Players", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
