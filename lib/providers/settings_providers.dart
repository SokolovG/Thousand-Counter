import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationsProvider = StateProvider<bool>((ref) => false);
final singleModeProvider = StateProvider<bool>((ref) => false);
final soundsModeProvider = StateProvider<bool>((ref) => false);
