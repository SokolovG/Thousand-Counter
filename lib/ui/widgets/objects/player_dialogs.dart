import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<String?> showPlayerEditDialog(
  BuildContext context, {
  String? initialName,
}) async {
  final controller = TextEditingController(text: initialName);

  final name = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(initialName == null ? "Add new player" : "Edit player"),
            content: TextField(
              controller: controller,
              autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zа-яА-Я\s]')),
              ],
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(hintText: "Enter player name"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: controller.text.trim().isNotEmpty
                    ? () => Navigator.pop(context, controller.text.trim())
                    : null,
                child: Text("Save"),
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
