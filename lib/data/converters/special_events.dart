import 'package:drift/drift.dart';
import 'package:thousand_counter/core/enums.dart';
import 'dart:convert';

class SpecialEventsConverter
    extends TypeConverter<Map<String, List<SpecialGameEvent>>, String> {
  @override
  Map<String, List<SpecialGameEvent>> fromSql(String fromDb) {
    // String - {"key": ['BOLT', 'BARREL']}
    final rawMap = json.decode(fromDb) as Map<String, dynamic>;
    // Map - {"key", ["BOLT", "BARREL"]}
    return rawMap.map((key, value) {
      final List<dynamic> rawList = value;
      final eventsList = rawList.map((eventName) {
        return SpecialGameEvent.values.byName(eventName);
      }).toList();
      return MapEntry(key, eventsList);
    });
  }

  @override
  String toSql(Map<String, List<SpecialGameEvent>> value) {
    final mapForJson = value.map((key, events) {
      final stringEvents = events.map((e) => e.name).toList();
      return MapEntry(key, stringEvents);
    });
    return json.encode(mapForJson);
  }
}
