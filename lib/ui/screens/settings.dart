import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/ui/models/settings_item.dart';
import 'package:thousand_counter/providers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool notifications = ref.watch(notificationsProvider);
    bool singleMode = ref.watch(singleModeProvider);
    bool sounds = ref.watch(soundsModeProvider);
    String language = "English";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: _buildSettingsItems(
          ref,
          notifications,
          singleMode,
          sounds,
          language,
        ).map((item) => _buildItem(item)).toList(),
      ),
    );
  }
}

List<SettingsItem> _buildSettingsItems(
  WidgetRef ref,
  bool notifications,
  bool singleMode,
  bool sounds,
  String language,
) {
  const version = "1.0.0";

  return [
    SettingsItem(
      icon: Icons.palette,
      title: 'Theme',
      subtitle: 'Default',
      type: SettingsItemType.navigation,
      onTap: () {},
    ),
    SettingsItem(
      icon: Icons.notifications,
      title: "Notifications",
      type: SettingsItemType.toggle,
      switchValue: notifications,
      onSwitchChanged: (val) =>
          ref.read(notificationsProvider.notifier).state = val,
    ),
    SettingsItem(
      icon: Icons.people_alt,
      title: "Single mode",
      type: SettingsItemType.toggle,
      switchValue: singleMode,
      onSwitchChanged: (val) =>
          ref.read(singleModeProvider.notifier).state = val,
    ),
    SettingsItem(
      icon: Icons.volume_up,
      title: "Sounds",
      type: SettingsItemType.toggle,
      switchValue: sounds,
      onSwitchChanged: (val) =>
          ref.read(soundsModeProvider.notifier).state = val,
    ),
    SettingsItem(
      icon: Icons.help_outline,
      title: 'Game rules',
      type: SettingsItemType.navigation,
      onTap: () {},
    ),
    SettingsItem(
      icon: Icons.language,
      title: 'Language',
      subtitle: language,
      type: SettingsItemType.navigation,
      onTap: () {},
    ),
    SettingsItem(
      icon: Icons.share,
      title: 'Share app',
      type: SettingsItemType.navigation,
      onTap: () {},
    ),
    SettingsItem(
      icon: Icons.app_settings_alt,
      title: 'Version',
      subtitle: version,
      type: SettingsItemType.info,
    ),
  ];
}

Widget _buildItem(SettingsItem item) {
  switch (item.type) {
    case SettingsItemType.navigation:
      return Column(
        children: [
          ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
            trailing: const Icon(Icons.chevron_right),
            onTap: item.onTap,
          ),
          const Divider(),
        ],
      );

    case SettingsItemType.toggle:
      return Column(
        children: [
          ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            trailing: Switch(
              value: item.switchValue ?? false,
              onChanged: item.onSwitchChanged,
            ),
          ),
          const Divider(),
        ],
      );

    case SettingsItemType.info:
      return Column(
        children: [
          ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
            onTap: item.onTap,
          ),
          const Divider(),
        ],
      );
  }
}
