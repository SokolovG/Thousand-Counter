import 'package:talker/talker.dart';

class AppLogger {
  static final _talker = Talker(
    settings: TalkerSettings(
      useConsoleLogs: true,
      useHistory: true,
      maxHistoryItems: 200,
    ),
  );

  static void debug(String msg) => _talker.debug(msg);
  static void info(String msg) => _talker.info(msg);
  static void warning(String msg) => _talker.warning(msg);
  static void error(String msg, [Object? error, StackTrace? st]) {
    _talker.error(msg, error, st);
  }

  static List<dynamic> getHistory() => _talker.history;
}
