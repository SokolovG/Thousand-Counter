import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/ui/models/menu_item.dart';
import 'package:thousand_counter/ui/widgets/buttons/menu_button.dart';
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  List<MenuItem> _menuItems(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    return [
      MenuItem(
        title: l10n.createNewGame,
        route: "/game_settings?previousScreen=home",
      ),
      MenuItem(
          title: l10n.recentGames, route: "/recent_games?previousScreen=home"),
      MenuItem(
          title: l10n.players, route: "/players_profiles?previousScreen=home"),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
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
          children: _menuItems(context)
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
