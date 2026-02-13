import 'package:flutter/material.dart';
import 'package:thousand_counter/core/enums.dart';
import 'package:thousand_counter/ui/theme/extension.dart';

Widget buildEventIcons(BuildContext context, List<SpecialGameEvent>? events) {
  if (events == null || events.isEmpty) return const SizedBox.shrink();

  final appColors = Theme.of(context).extension<AppColors>()!;

  return Wrap(
    spacing: 4,
    children: events.map((e) {
      switch (e) {
        case SpecialGameEvent.barrel:
          return Icon(Icons.oil_barrel, color: appColors.barrel, size: 18);
        case SpecialGameEvent.barrelFall:
          return Icon(Icons.downhill_skiing, color: appColors.alert, size: 18);
        case SpecialGameEvent.bolt:
          return Icon(Icons.flash_on, color: appColors.bolt, size: 18);
        case SpecialGameEvent.magicNumber:
          return Icon(
            Icons.auto_fix_high,
            color: appColors.warning,
            size: 18,
          );
      }
    }).toList(),
  );
}
