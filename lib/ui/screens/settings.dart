import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/core/constants.dart';
import 'package:thousand_counter/core/enums.dart';
import 'package:thousand_counter/providers/core_providers.dart';
import 'package:thousand_counter/providers/settings_providers.dart';
import 'package:thousand_counter/ui/models/settings_item.dart';
import 'package:thousand_counter/ui/utils.dart';
import 'package:thousand_counter/ui/widgets/dialogs/clear_database.dart';
import 'package:thousand_counter/ui/widgets/dialogs/language.dart';
import 'package:thousand_counter/ui/widgets/dialogs/rules.dart';
import 'package:thousand_counter/ui/widgets/dialogs/thema.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String language = "English";

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: _buildSettingsItems(
          ref,
          context,
          language,
          l10n,
        ).map((item) => _buildItem(item)).toList(),
      ),
    );
  }
}

List<SettingsItem> _buildSettingsItems(
  WidgetRef ref,
  BuildContext context,
  String language,
  AppLocalizations l10n,
) {
  final currentTheme = ref.watch(themeModeProvider);
  final currentLocale = ref.watch(localeProvider);

  final themeLabel = getThemeLabel(currentTheme, l10n);
  final localeLabel = getLocaleLabel(currentLocale);

  return [
    SettingsItem(
      icon: Icons.palette,
      title: l10n.theme,
      subtitle: themeLabel,
      type: SettingsItemType.navigation,
      onTap: () {
        return themaDialog(context, ref);
      },
    ),
    SettingsItem(
      icon: Icons.help_outline,
      title: l10n.gameRules,
      type: SettingsItemType.navigation,
      onTap: () {
        return rulesDialog(context, ref);
      },
    ),
    SettingsItem(
      icon: Icons.language,
      title: l10n.language,
      subtitle: localeLabel,
      type: SettingsItemType.navigation,
      onTap: () {
        return languageDialog(context, ref);
      },
    ),

    SettingsItem(
      icon: Icons.code,
      title: l10n.sourceCode,
      type: SettingsItemType.info,
      onTap: () async {
        final uri = Uri.parse(githubUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
    ),
    SettingsItem(
      icon: Icons.delete,
      title: l10n.clearDatabase,
      type: SettingsItemType.info,
      onTap: () async {
        return clearDatabaseDialog(context, ref);
      },
    ),
    SettingsItem(
      icon: Icons.data_array,
      title: l10n.databaseView,
      type: SettingsItemType.navigation,
      onTap: () async {
        final db = ref.read(databaseProvider);
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => DriftDbViewer(db)));
      },
    ),
    SettingsItem(
      icon: Icons.app_settings_alt,
      title: l10n.version,
      subtitle: appVersion,
      type: SettingsItemType.info,
    ),
    SettingsItem(
      icon: Icons.person,
      title: l10n.author,
      subtitle: l10n.authorName,
      type: SettingsItemType.info,
      onTap: () async {
        final uri = Uri.parse(authorGithub);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
    ),

    // NEXT VERSION:

    // SettingsItem(
    //   icon: ,
    //   title: "Gold cone",
    //   type: SettingsItemType.toggle,
    //   switchValue: goldCone,
    //   onSwitchChanged: (val) =>
    // ),

    // SettingsItem(
    //   icon: Icons.share,
    //   title: 'Share app',
    //   type: SettingsItemType.navigation,
    //   onTap: () {},
    // ),
    // SettingsItem(
    //   icon: Icons.notifications,
    //   title: "Notifications",
    //   type: SettingsItemType.toggle,
    //   switchValue: notifications,
    //   onSwitchChanged: (val) =>
    //       ref.read(notificationsProvider.notifier).state = val,
    // ),
    // SettingsItem(
    //   icon: Icons.people_alt,
    //   title: "Single mode",
    //   type: SettingsItemType.toggle,
    //   switchValue: singleMode,
    //   onSwitchChanged: (val) =>
    //       ref.read(singleModeProvider.notifier).state = val,
    // ),
    // SettingsItem(
    //   icon: Icons.volume_up,
    //   title: l10n.sounds,
    //   type: SettingsItemType.toggle,
    //   switchValue: sounds,
    //   onSwitchChanged: (val) =>
    //       ref.read(soundsModeProvider.notifier).state = val,
    // ),
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
