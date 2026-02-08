import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thousand_counter/l10n/app_localizations.dart';

Future<String?> showProfileEditDialog(
  BuildContext context, {
  String? initialName,
}) async {
  final controller = TextEditingController(text: initialName);

  final name = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      final l10n = AppLocalizations.of(context)!;
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              initialName == null ? l10n.addNewPlayer : l10n.editPlayer,
            ),
            content: TextField(
              controller: controller,
              autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я\s]')),
              ],
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(hintText: l10n.enterPlayerName),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: controller.text.trim().isNotEmpty
                    ? () => Navigator.pop(context, controller.text.trim())
                    : null,
                child: Text(l10n.save),
              ),
            ],
          );
        },
      );
    },
  );
  await Future.delayed(Duration.zero);
  controller.dispose();
  return name;
}
