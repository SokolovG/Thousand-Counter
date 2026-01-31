import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_counter/ui/models/menu_item.dart';
import 'package:thousand_counter/ui/widgets/buttons/menu_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const _menuItems = [
    MenuItem(
      title: 'Create new game',
      icon: Icons.add_circle,
      route: "/game_settings",
    ),
    MenuItem(
      title: 'Recent games',
      icon: Icons.add_circle,
      route: "/recent_games",
    ),
    MenuItem(
      title: 'Players',
      icon: Icons.add_circle,
      route: "/players_profiles",
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thousand Counter"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push("/settings"),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _menuItems
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: MenuButton(
                    text: item.title,
                    icon: item.icon,
                    onPressed: () => context.push(item.route),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
