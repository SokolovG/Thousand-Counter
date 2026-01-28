import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/providers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool notifications = ref.watch(notificationsProvider);
    bool singeMode = ref.watch(singleModeProvider);
    bool sounds = ref.watch(soundsModeProvider);
    String language = "English";
    final version = "1.0.0";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Thema"),
            subtitle: Text("Default"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
            trailing: Switch(
              value: notifications,
              onChanged: (val) {
                ref.read(notificationsProvider.notifier).state = val;
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people_alt),
            title: Text("Single mode"),
            trailing: Switch(
              value: singeMode,
              onChanged: (val) {
                ref.read(singleModeProvider.notifier).state = val;
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.volume_up),
            title: Text("Sounds"),
            trailing: Switch(
              value: sounds,
              onChanged: (val) {
                ref.read(soundsModeProvider.notifier).state = val;
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text("Game rules"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            subtitle: Text(language),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share app"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Version"),
            subtitle: Text(version),
          ),
          Divider(),
        ],
      ),
    );
  }
}
