import 'package:drift/drift.dart';
import 'dart:convert';

class MapConverter extends TypeConverter<Map<String, int>, String> {
  @override
  fromSql(fromDb) {
    final decoded = json.decode(fromDb) as Map<String, dynamic>;
    return decoded.cast<String, int>();
  }

  @override
  toSql(value) {
    final data = json.encode(value);
    return data;
  }
}
