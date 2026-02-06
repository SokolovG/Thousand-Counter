import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void themaDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Thema"),
        content: SizedBox(child: Text("Choose thema:")),
      );
    },
  );
}
