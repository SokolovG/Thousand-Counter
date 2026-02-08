// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Счётчик Тысячи';

  @override
  String get startGame => 'Начать игру';

  @override
  String get settings => 'Настройки';

  @override
  String get language => 'Язык';

  @override
  String get chooseLanguage => 'Выберите язык:';

  @override
  String get rules => 'Правила';

  @override
  String get game => 'Игра';

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get enterPlayerName => 'Введите имя игрока';

  @override
  String get whoIsPlaying => 'Кто играет?';

  @override
  String errorGeneric(Object error) {
    return 'Ошибка: $error';
  }

  @override
  String get theme => 'Тема';

  @override
  String get chooseTheme => 'Выберите тему:';

  @override
  String get playerGameHistory => 'История игр игрока:';

  @override
  String get gameSettings => 'Настройки игры';

  @override
  String get loadingProfiles => 'Загрузка профилей...';

  @override
  String get recentGames => 'Недавние игры';

  @override
  String get noActiveGame => 'Нет активной игры';

  @override
  String round(Object number) {
    return 'Раунд $number';
  }

  @override
  String get split => 'Расписать';

  @override
  String get confirmRound => 'Подтвердить раунд';

  @override
  String get playersProfiles => 'Профили игроков';

  @override
  String get createNewGame => 'Новая игра';

  @override
  String get players => 'Игроки';

  @override
  String get defaultTheme => 'По умолчанию';

  @override
  String get sounds => 'Звуки';

  @override
  String get gameRules => 'Правила игры';

  @override
  String get author => 'Автор';

  @override
  String get shareApp => 'Поделиться';

  @override
  String get version => 'Версия';

  @override
  String get delete => 'Удалить';

  @override
  String get addNewPlayer => 'Добавить игрока';

  @override
  String get editPlayer => 'Редактировать игрока';

  @override
  String get minPlayersError => 'Минимум 2 игрока!';

  @override
  String get maxPlayersError => 'Максимум 4 игрока!';

  @override
  String totalPoints(Object points) {
    return 'Всего: $points';
  }

  @override
  String bolts(Object count) {
    return 'Б: $count';
  }

  @override
  String defaultGameName(Object date) {
    return 'Игра от $date';
  }

  @override
  String gameDescription(Object players) {
    return 'Игра с игроками $players';
  }
}
