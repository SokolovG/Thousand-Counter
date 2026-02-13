import 'package:flutter/material.dart';
import 'package:thousand_counter/core/enums.dart';

Widget buildEventIcons(List<SpecialGameEvent>? events) {
  if (events == null || events.isEmpty) return const SizedBox.shrink();

  return Wrap(
    spacing: 4,
    children: events.map((e) {
      switch (e) {
        case SpecialGameEvent.barrel:
          return const Icon(Icons.oil_barrel, color: Colors.brown, size: 18);
        case SpecialGameEvent.barrelFall:
          return const Icon(Icons.downhill_skiing, color: Colors.red, size: 18);
        case SpecialGameEvent.bolt:
          return const Icon(Icons.flash_on, color: Colors.amber, size: 18);
        case SpecialGameEvent.magicNumber:
          return const Icon(
            Icons.local_shipping,
            color: Colors.orange,
            size: 18,
          );
      }
    }).toList(),
  );
}
