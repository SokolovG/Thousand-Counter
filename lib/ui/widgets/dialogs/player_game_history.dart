import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/core/constants.dart';

void playerGameHistoryDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text("Player game history:")),
        content: SizedBox(child: Text(gameRules)),
      );
    },
  );
}
