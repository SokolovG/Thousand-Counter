import 'package:flutter/material.dart';
import 'package:thousand_counter/presentation/widgets/buttons/menu_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thousand Counter"),
        backgroundColor: const Color.fromARGB(255, 74, 179, 18),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton(text: "Create game", onPressed: () {}),
            SizedBox(height: 16),
            MenuButton(text: "History of games", onPressed: () {}),
            SizedBox(height: 16),
            MenuButton(text: "Players", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
