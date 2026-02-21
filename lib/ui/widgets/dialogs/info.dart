import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';
import 'package:thousand_counter/ui/theme/extension.dart';

void infoDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final l10n = AppLocalizations.of(context)!;
      final appColors = Theme.of(context).extension<AppColors>()!;
      return AlertDialog(
        title: Center(child: Text(l10n.iconsInfo)),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _iconRow(Icons.offline_bolt, appColors.bolt, l10n.iconsInfoBolt),
              ListTile(
                leading: Badge(
                  label: Text("×3", style: TextStyle(fontSize: 9)),
                  backgroundColor: appColors.alert,
                  child: Icon(
                    Icons.offline_bolt,
                    color: appColors.bolt,
                    size: 24,
                  ),
                ),
                title: Text(l10n.iconsInfoBoltFall),
              ),
              _iconRow(
                Icons.oil_barrel,
                appColors.barrel,
                l10n.iconsInfoBarrel,
              ),
              _iconRow(
                Icons.downhill_skiing,
                appColors.alert,
                l10n.iconsInfoBarrelFall,
              ),
              _iconRow(
                Icons.auto_fix_high,
                appColors.warning,
                l10n.iconsInfoMagic,
              ),
              _iconRow(Icons.call_split, appColors.info, l10n.iconsInfoSplit),
            ],
          ),
        ),
      );
    },
  );
}

ListTile _iconRow(IconData icon, Color color, String text) {
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text),
  );
}
