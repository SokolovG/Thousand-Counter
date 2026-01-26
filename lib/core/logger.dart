import 'package:talker/talker.dart';

class AppLogger {
  static final _talker = Talker(
    settings: TalkerSettings(
      useConsoleLogs: true,
      useHistory: true,
      maxHistoryItems: 200,
    ),
  );

  static void debug(Object msg) => _talker.debug(msg);
  static void info(Object msg) => _talker.info(msg);
  static void warning(Object msg) => _talker.warning(msg);
  static void error(Object msg, [Object? error, StackTrace? st]) {
    _talker.error(msg, error, st);
  }

  static void critical(Object msg) => _talker.critical(msg);

  static List<dynamic> getHistory() => _talker.history;
}
