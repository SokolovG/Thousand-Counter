import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void languageDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text("Language")),
        content: SizedBox(child: Text("Choose language:")),
      );
    },
  );
}
