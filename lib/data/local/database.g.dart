// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Profile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final int id;
  final String name;
  const Profile({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(id: Value(id), name: Value(name));
  }

  factory Profile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Profile copyWith({int? id, String? name}) =>
      Profile(id: id ?? this.id, name: name ?? this.name);
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile && other.id == this.id && other.name == this.name);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required int id,
    required String name,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Profile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GamesTable extends Games with TableInfo<$GamesTable, Game> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentRoundMeta = const VerificationMeta(
    'currentRound',
  );
  @override
  late final GeneratedColumn<int> currentRound = GeneratedColumn<int>(
    'current_round',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFinishedMeta = const VerificationMeta(
    'isFinished',
  );
  @override
  late final GeneratedColumn<bool> isFinished = GeneratedColumn<bool>(
    'is_finished',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_finished" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _currentPlayerIndexMeta =
      const VerificationMeta('currentPlayerIndex');
  @override
  late final GeneratedColumn<int> currentPlayerIndex = GeneratedColumn<int>(
    'current_player_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _winnerPlayerIdMeta = const VerificationMeta(
    'winnerPlayerId',
  );
  @override
  late final GeneratedColumn<int> winnerPlayerId = GeneratedColumn<int>(
    'winner_player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    createdAt,
    currentRound,
    isFinished,
    currentPlayerIndex,
    winnerPlayerId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'games';
  @override
  VerificationContext validateIntegrity(
    Insertable<Game> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('current_round')) {
      context.handle(
        _currentRoundMeta,
        currentRound.isAcceptableOrUnknown(
          data['current_round']!,
          _currentRoundMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentRoundMeta);
    }
    if (data.containsKey('is_finished')) {
      context.handle(
        _isFinishedMeta,
        isFinished.isAcceptableOrUnknown(data['is_finished']!, _isFinishedMeta),
      );
    }
    if (data.containsKey('current_player_index')) {
      context.handle(
        _currentPlayerIndexMeta,
        currentPlayerIndex.isAcceptableOrUnknown(
          data['current_player_index']!,
          _currentPlayerIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentPlayerIndexMeta);
    }
    if (data.containsKey('winner_player_id')) {
      context.handle(
        _winnerPlayerIdMeta,
        winnerPlayerId.isAcceptableOrUnknown(
          data['winner_player_id']!,
          _winnerPlayerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_winnerPlayerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Game map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Game(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      currentRound: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_round'],
      )!,
      isFinished: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_finished'],
      )!,
      currentPlayerIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_player_index'],
      )!,
      winnerPlayerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}winner_player_id'],
      )!,
    );
  }

  @override
  $GamesTable createAlias(String alias) {
    return $GamesTable(attachedDatabase, alias);
  }
}

class Game extends DataClass implements Insertable<Game> {
  final int id;
  final String name;
  final DateTime createdAt;
  final int currentRound;
  final bool isFinished;
  final int currentPlayerIndex;
  final int winnerPlayerId;
  const Game({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.currentRound,
    required this.isFinished,
    required this.currentPlayerIndex,
    required this.winnerPlayerId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['current_round'] = Variable<int>(currentRound);
    map['is_finished'] = Variable<bool>(isFinished);
    map['current_player_index'] = Variable<int>(currentPlayerIndex);
    map['winner_player_id'] = Variable<int>(winnerPlayerId);
    return map;
  }

  GamesCompanion toCompanion(bool nullToAbsent) {
    return GamesCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      currentRound: Value(currentRound),
      isFinished: Value(isFinished),
      currentPlayerIndex: Value(currentPlayerIndex),
      winnerPlayerId: Value(winnerPlayerId),
    );
  }

  factory Game.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Game(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      currentRound: serializer.fromJson<int>(json['currentRound']),
      isFinished: serializer.fromJson<bool>(json['isFinished']),
      currentPlayerIndex: serializer.fromJson<int>(json['currentPlayerIndex']),
      winnerPlayerId: serializer.fromJson<int>(json['winnerPlayerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'currentRound': serializer.toJson<int>(currentRound),
      'isFinished': serializer.toJson<bool>(isFinished),
      'currentPlayerIndex': serializer.toJson<int>(currentPlayerIndex),
      'winnerPlayerId': serializer.toJson<int>(winnerPlayerId),
    };
  }

  Game copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    int? currentRound,
    bool? isFinished,
    int? currentPlayerIndex,
    int? winnerPlayerId,
  }) => Game(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    currentRound: currentRound ?? this.currentRound,
    isFinished: isFinished ?? this.isFinished,
    currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
    winnerPlayerId: winnerPlayerId ?? this.winnerPlayerId,
  );
  Game copyWithCompanion(GamesCompanion data) {
    return Game(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      currentRound: data.currentRound.present
          ? data.currentRound.value
          : this.currentRound,
      isFinished: data.isFinished.present
          ? data.isFinished.value
          : this.isFinished,
      currentPlayerIndex: data.currentPlayerIndex.present
          ? data.currentPlayerIndex.value
          : this.currentPlayerIndex,
      winnerPlayerId: data.winnerPlayerId.present
          ? data.winnerPlayerId.value
          : this.winnerPlayerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Game(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('currentRound: $currentRound, ')
          ..write('isFinished: $isFinished, ')
          ..write('currentPlayerIndex: $currentPlayerIndex, ')
          ..write('winnerPlayerId: $winnerPlayerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    createdAt,
    currentRound,
    isFinished,
    currentPlayerIndex,
    winnerPlayerId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Game &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.currentRound == this.currentRound &&
          other.isFinished == this.isFinished &&
          other.currentPlayerIndex == this.currentPlayerIndex &&
          other.winnerPlayerId == this.winnerPlayerId);
}

class GamesCompanion extends UpdateCompanion<Game> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<int> currentRound;
  final Value<bool> isFinished;
  final Value<int> currentPlayerIndex;
  final Value<int> winnerPlayerId;
  const GamesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.currentRound = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.currentPlayerIndex = const Value.absent(),
    this.winnerPlayerId = const Value.absent(),
  });
  GamesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime createdAt,
    required int currentRound,
    this.isFinished = const Value.absent(),
    required int currentPlayerIndex,
    required int winnerPlayerId,
  }) : name = Value(name),
       createdAt = Value(createdAt),
       currentRound = Value(currentRound),
       currentPlayerIndex = Value(currentPlayerIndex),
       winnerPlayerId = Value(winnerPlayerId);
  static Insertable<Game> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<int>? currentRound,
    Expression<bool>? isFinished,
    Expression<int>? currentPlayerIndex,
    Expression<int>? winnerPlayerId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (currentRound != null) 'current_round': currentRound,
      if (isFinished != null) 'is_finished': isFinished,
      if (currentPlayerIndex != null)
        'current_player_index': currentPlayerIndex,
      if (winnerPlayerId != null) 'winner_player_id': winnerPlayerId,
    });
  }

  GamesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<int>? currentRound,
    Value<bool>? isFinished,
    Value<int>? currentPlayerIndex,
    Value<int>? winnerPlayerId,
  }) {
    return GamesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      currentRound: currentRound ?? this.currentRound,
      isFinished: isFinished ?? this.isFinished,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
      winnerPlayerId: winnerPlayerId ?? this.winnerPlayerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (currentRound.present) {
      map['current_round'] = Variable<int>(currentRound.value);
    }
    if (isFinished.present) {
      map['is_finished'] = Variable<bool>(isFinished.value);
    }
    if (currentPlayerIndex.present) {
      map['current_player_index'] = Variable<int>(currentPlayerIndex.value);
    }
    if (winnerPlayerId.present) {
      map['winner_player_id'] = Variable<int>(winnerPlayerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GamesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('currentRound: $currentRound, ')
          ..write('isFinished: $isFinished, ')
          ..write('currentPlayerIndex: $currentPlayerIndex, ')
          ..write('winnerPlayerId: $winnerPlayerId')
          ..write(')'))
        .toString();
  }
}

class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _totalPointsMeta = const VerificationMeta(
    'totalPoints',
  );
  @override
  late final GeneratedColumn<int> totalPoints = GeneratedColumn<int>(
    'total_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _boltsCountMeta = const VerificationMeta(
    'boltsCount',
  );
  @override
  late final GeneratedColumn<int> boltsCount = GeneratedColumn<int>(
    'bolts_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _barrelAttemptsMeta = const VerificationMeta(
    'barrelAttempts',
  );
  @override
  late final GeneratedColumn<int> barrelAttempts = GeneratedColumn<int>(
    'barrel_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isOnBarrelMeta = const VerificationMeta(
    'isOnBarrel',
  );
  @override
  late final GeneratedColumn<bool> isOnBarrel = GeneratedColumn<bool>(
    'is_on_barrel',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_on_barrel" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<int> gameId = GeneratedColumn<int>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES games (id)',
    ),
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    totalPoints,
    boltsCount,
    barrelAttempts,
    name,
    isOnBarrel,
    gameId,
    profileId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(
    Insertable<Player> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('total_points')) {
      context.handle(
        _totalPointsMeta,
        totalPoints.isAcceptableOrUnknown(
          data['total_points']!,
          _totalPointsMeta,
        ),
      );
    }
    if (data.containsKey('bolts_count')) {
      context.handle(
        _boltsCountMeta,
        boltsCount.isAcceptableOrUnknown(data['bolts_count']!, _boltsCountMeta),
      );
    }
    if (data.containsKey('barrel_attempts')) {
      context.handle(
        _barrelAttemptsMeta,
        barrelAttempts.isAcceptableOrUnknown(
          data['barrel_attempts']!,
          _barrelAttemptsMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_on_barrel')) {
      context.handle(
        _isOnBarrelMeta,
        isOnBarrel.isAcceptableOrUnknown(
          data['is_on_barrel']!,
          _isOnBarrelMeta,
        ),
      );
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      totalPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_points'],
      )!,
      boltsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bolts_count'],
      )!,
      barrelAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}barrel_attempts'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isOnBarrel: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_on_barrel'],
      )!,
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}game_id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      )!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int totalPoints;
  final int boltsCount;
  final int barrelAttempts;
  final String name;
  final bool isOnBarrel;
  final int gameId;
  final int profileId;
  const Player({
    required this.totalPoints,
    required this.boltsCount,
    required this.barrelAttempts,
    required this.name,
    required this.isOnBarrel,
    required this.gameId,
    required this.profileId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['total_points'] = Variable<int>(totalPoints);
    map['bolts_count'] = Variable<int>(boltsCount);
    map['barrel_attempts'] = Variable<int>(barrelAttempts);
    map['name'] = Variable<String>(name);
    map['is_on_barrel'] = Variable<bool>(isOnBarrel);
    map['game_id'] = Variable<int>(gameId);
    map['profile_id'] = Variable<int>(profileId);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      totalPoints: Value(totalPoints),
      boltsCount: Value(boltsCount),
      barrelAttempts: Value(barrelAttempts),
      name: Value(name),
      isOnBarrel: Value(isOnBarrel),
      gameId: Value(gameId),
      profileId: Value(profileId),
    );
  }

  factory Player.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      totalPoints: serializer.fromJson<int>(json['totalPoints']),
      boltsCount: serializer.fromJson<int>(json['boltsCount']),
      barrelAttempts: serializer.fromJson<int>(json['barrelAttempts']),
      name: serializer.fromJson<String>(json['name']),
      isOnBarrel: serializer.fromJson<bool>(json['isOnBarrel']),
      gameId: serializer.fromJson<int>(json['gameId']),
      profileId: serializer.fromJson<int>(json['profileId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'totalPoints': serializer.toJson<int>(totalPoints),
      'boltsCount': serializer.toJson<int>(boltsCount),
      'barrelAttempts': serializer.toJson<int>(barrelAttempts),
      'name': serializer.toJson<String>(name),
      'isOnBarrel': serializer.toJson<bool>(isOnBarrel),
      'gameId': serializer.toJson<int>(gameId),
      'profileId': serializer.toJson<int>(profileId),
    };
  }

  Player copyWith({
    int? totalPoints,
    int? boltsCount,
    int? barrelAttempts,
    String? name,
    bool? isOnBarrel,
    int? gameId,
    int? profileId,
  }) => Player(
    totalPoints: totalPoints ?? this.totalPoints,
    boltsCount: boltsCount ?? this.boltsCount,
    barrelAttempts: barrelAttempts ?? this.barrelAttempts,
    name: name ?? this.name,
    isOnBarrel: isOnBarrel ?? this.isOnBarrel,
    gameId: gameId ?? this.gameId,
    profileId: profileId ?? this.profileId,
  );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      totalPoints: data.totalPoints.present
          ? data.totalPoints.value
          : this.totalPoints,
      boltsCount: data.boltsCount.present
          ? data.boltsCount.value
          : this.boltsCount,
      barrelAttempts: data.barrelAttempts.present
          ? data.barrelAttempts.value
          : this.barrelAttempts,
      name: data.name.present ? data.name.value : this.name,
      isOnBarrel: data.isOnBarrel.present
          ? data.isOnBarrel.value
          : this.isOnBarrel,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('totalPoints: $totalPoints, ')
          ..write('boltsCount: $boltsCount, ')
          ..write('barrelAttempts: $barrelAttempts, ')
          ..write('name: $name, ')
          ..write('isOnBarrel: $isOnBarrel, ')
          ..write('gameId: $gameId, ')
          ..write('profileId: $profileId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    totalPoints,
    boltsCount,
    barrelAttempts,
    name,
    isOnBarrel,
    gameId,
    profileId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.totalPoints == this.totalPoints &&
          other.boltsCount == this.boltsCount &&
          other.barrelAttempts == this.barrelAttempts &&
          other.name == this.name &&
          other.isOnBarrel == this.isOnBarrel &&
          other.gameId == this.gameId &&
          other.profileId == this.profileId);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int> totalPoints;
  final Value<int> boltsCount;
  final Value<int> barrelAttempts;
  final Value<String> name;
  final Value<bool> isOnBarrel;
  final Value<int> gameId;
  final Value<int> profileId;
  final Value<int> rowid;
  const PlayersCompanion({
    this.totalPoints = const Value.absent(),
    this.boltsCount = const Value.absent(),
    this.barrelAttempts = const Value.absent(),
    this.name = const Value.absent(),
    this.isOnBarrel = const Value.absent(),
    this.gameId = const Value.absent(),
    this.profileId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.totalPoints = const Value.absent(),
    this.boltsCount = const Value.absent(),
    this.barrelAttempts = const Value.absent(),
    required String name,
    this.isOnBarrel = const Value.absent(),
    required int gameId,
    required int profileId,
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       gameId = Value(gameId),
       profileId = Value(profileId);
  static Insertable<Player> custom({
    Expression<int>? totalPoints,
    Expression<int>? boltsCount,
    Expression<int>? barrelAttempts,
    Expression<String>? name,
    Expression<bool>? isOnBarrel,
    Expression<int>? gameId,
    Expression<int>? profileId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (totalPoints != null) 'total_points': totalPoints,
      if (boltsCount != null) 'bolts_count': boltsCount,
      if (barrelAttempts != null) 'barrel_attempts': barrelAttempts,
      if (name != null) 'name': name,
      if (isOnBarrel != null) 'is_on_barrel': isOnBarrel,
      if (gameId != null) 'game_id': gameId,
      if (profileId != null) 'profile_id': profileId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayersCompanion copyWith({
    Value<int>? totalPoints,
    Value<int>? boltsCount,
    Value<int>? barrelAttempts,
    Value<String>? name,
    Value<bool>? isOnBarrel,
    Value<int>? gameId,
    Value<int>? profileId,
    Value<int>? rowid,
  }) {
    return PlayersCompanion(
      totalPoints: totalPoints ?? this.totalPoints,
      boltsCount: boltsCount ?? this.boltsCount,
      barrelAttempts: barrelAttempts ?? this.barrelAttempts,
      name: name ?? this.name,
      isOnBarrel: isOnBarrel ?? this.isOnBarrel,
      gameId: gameId ?? this.gameId,
      profileId: profileId ?? this.profileId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (totalPoints.present) {
      map['total_points'] = Variable<int>(totalPoints.value);
    }
    if (boltsCount.present) {
      map['bolts_count'] = Variable<int>(boltsCount.value);
    }
    if (barrelAttempts.present) {
      map['barrel_attempts'] = Variable<int>(barrelAttempts.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isOnBarrel.present) {
      map['is_on_barrel'] = Variable<bool>(isOnBarrel.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<int>(gameId.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('totalPoints: $totalPoints, ')
          ..write('boltsCount: $boltsCount, ')
          ..write('barrelAttempts: $barrelAttempts, ')
          ..write('name: $name, ')
          ..write('isOnBarrel: $isOnBarrel, ')
          ..write('gameId: $gameId, ')
          ..write('profileId: $profileId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoundsTable extends Rounds with TableInfo<$RoundsTable, Round> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoundsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _roundNumberMeta = const VerificationMeta(
    'roundNumber',
  );
  @override
  late final GeneratedColumn<int> roundNumber = GeneratedColumn<int>(
    'round_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, int>, String>
  playerScores = GeneratedColumn<String>(
    'player_scores',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, int>>($RoundsTable.$converterplayerScores);
  @override
  late final GeneratedColumnWithTypeConverter<
    Map<String, List<SpecialGameEvent>>,
    String
  >
  specialEvents =
      GeneratedColumn<String>(
        'special_events',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Map<String, List<SpecialGameEvent>>>(
        $RoundsTable.$converterspecialEvents,
      );
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<int> gameId = GeneratedColumn<int>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES games (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    roundNumber,
    playerScores,
    specialEvents,
    gameId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rounds';
  @override
  VerificationContext validateIntegrity(
    Insertable<Round> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('round_number')) {
      context.handle(
        _roundNumberMeta,
        roundNumber.isAcceptableOrUnknown(
          data['round_number']!,
          _roundNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roundNumberMeta);
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Round map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Round(
      roundNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round_number'],
      )!,
      playerScores: $RoundsTable.$converterplayerScores.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}player_scores'],
        )!,
      ),
      specialEvents: $RoundsTable.$converterspecialEvents.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}special_events'],
        )!,
      ),
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}game_id'],
      )!,
    );
  }

  @override
  $RoundsTable createAlias(String alias) {
    return $RoundsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, int>, String> $converterplayerScores =
      MapConverter();
  static TypeConverter<Map<String, List<SpecialGameEvent>>, String>
  $converterspecialEvents = SpecialEventsConverter();
}

class Round extends DataClass implements Insertable<Round> {
  final int roundNumber;
  final Map<String, int> playerScores;
  final Map<String, List<SpecialGameEvent>> specialEvents;
  final int gameId;
  const Round({
    required this.roundNumber,
    required this.playerScores,
    required this.specialEvents,
    required this.gameId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['round_number'] = Variable<int>(roundNumber);
    {
      map['player_scores'] = Variable<String>(
        $RoundsTable.$converterplayerScores.toSql(playerScores),
      );
    }
    {
      map['special_events'] = Variable<String>(
        $RoundsTable.$converterspecialEvents.toSql(specialEvents),
      );
    }
    map['game_id'] = Variable<int>(gameId);
    return map;
  }

  RoundsCompanion toCompanion(bool nullToAbsent) {
    return RoundsCompanion(
      roundNumber: Value(roundNumber),
      playerScores: Value(playerScores),
      specialEvents: Value(specialEvents),
      gameId: Value(gameId),
    );
  }

  factory Round.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Round(
      roundNumber: serializer.fromJson<int>(json['roundNumber']),
      playerScores: serializer.fromJson<Map<String, int>>(json['playerScores']),
      specialEvents: serializer.fromJson<Map<String, List<SpecialGameEvent>>>(
        json['specialEvents'],
      ),
      gameId: serializer.fromJson<int>(json['gameId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'roundNumber': serializer.toJson<int>(roundNumber),
      'playerScores': serializer.toJson<Map<String, int>>(playerScores),
      'specialEvents': serializer.toJson<Map<String, List<SpecialGameEvent>>>(
        specialEvents,
      ),
      'gameId': serializer.toJson<int>(gameId),
    };
  }

  Round copyWith({
    int? roundNumber,
    Map<String, int>? playerScores,
    Map<String, List<SpecialGameEvent>>? specialEvents,
    int? gameId,
  }) => Round(
    roundNumber: roundNumber ?? this.roundNumber,
    playerScores: playerScores ?? this.playerScores,
    specialEvents: specialEvents ?? this.specialEvents,
    gameId: gameId ?? this.gameId,
  );
  Round copyWithCompanion(RoundsCompanion data) {
    return Round(
      roundNumber: data.roundNumber.present
          ? data.roundNumber.value
          : this.roundNumber,
      playerScores: data.playerScores.present
          ? data.playerScores.value
          : this.playerScores,
      specialEvents: data.specialEvents.present
          ? data.specialEvents.value
          : this.specialEvents,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Round(')
          ..write('roundNumber: $roundNumber, ')
          ..write('playerScores: $playerScores, ')
          ..write('specialEvents: $specialEvents, ')
          ..write('gameId: $gameId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(roundNumber, playerScores, specialEvents, gameId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Round &&
          other.roundNumber == this.roundNumber &&
          other.playerScores == this.playerScores &&
          other.specialEvents == this.specialEvents &&
          other.gameId == this.gameId);
}

class RoundsCompanion extends UpdateCompanion<Round> {
  final Value<int> roundNumber;
  final Value<Map<String, int>> playerScores;
  final Value<Map<String, List<SpecialGameEvent>>> specialEvents;
  final Value<int> gameId;
  final Value<int> rowid;
  const RoundsCompanion({
    this.roundNumber = const Value.absent(),
    this.playerScores = const Value.absent(),
    this.specialEvents = const Value.absent(),
    this.gameId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoundsCompanion.insert({
    required int roundNumber,
    required Map<String, int> playerScores,
    required Map<String, List<SpecialGameEvent>> specialEvents,
    required int gameId,
    this.rowid = const Value.absent(),
  }) : roundNumber = Value(roundNumber),
       playerScores = Value(playerScores),
       specialEvents = Value(specialEvents),
       gameId = Value(gameId);
  static Insertable<Round> custom({
    Expression<int>? roundNumber,
    Expression<String>? playerScores,
    Expression<String>? specialEvents,
    Expression<int>? gameId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (roundNumber != null) 'round_number': roundNumber,
      if (playerScores != null) 'player_scores': playerScores,
      if (specialEvents != null) 'special_events': specialEvents,
      if (gameId != null) 'game_id': gameId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoundsCompanion copyWith({
    Value<int>? roundNumber,
    Value<Map<String, int>>? playerScores,
    Value<Map<String, List<SpecialGameEvent>>>? specialEvents,
    Value<int>? gameId,
    Value<int>? rowid,
  }) {
    return RoundsCompanion(
      roundNumber: roundNumber ?? this.roundNumber,
      playerScores: playerScores ?? this.playerScores,
      specialEvents: specialEvents ?? this.specialEvents,
      gameId: gameId ?? this.gameId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (roundNumber.present) {
      map['round_number'] = Variable<int>(roundNumber.value);
    }
    if (playerScores.present) {
      map['player_scores'] = Variable<String>(
        $RoundsTable.$converterplayerScores.toSql(playerScores.value),
      );
    }
    if (specialEvents.present) {
      map['special_events'] = Variable<String>(
        $RoundsTable.$converterspecialEvents.toSql(specialEvents.value),
      );
    }
    if (gameId.present) {
      map['game_id'] = Variable<int>(gameId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoundsCompanion(')
          ..write('roundNumber: $roundNumber, ')
          ..write('playerScores: $playerScores, ')
          ..write('specialEvents: $specialEvents, ')
          ..write('gameId: $gameId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $GamesTable games = $GamesTable(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final $RoundsTable rounds = $RoundsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    games,
    players,
    rounds,
  ];
}

typedef $$ProfilesTableCreateCompanionBuilder =
    ProfilesCompanion Function({
      required int id,
      required String name,
      Value<int> rowid,
    });
typedef $$ProfilesTableUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> rowid,
    });

final class $$ProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $ProfilesTable, Profile> {
  $$ProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlayersTable, List<Player>> _playersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.players,
    aliasName: $_aliasNameGenerator(db.profiles.id, db.players.profileId),
  );

  $$PlayersTableProcessedTableManager get playersRefs {
    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_playersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> playersRefs(
    Expression<bool> Function($$PlayersTableFilterComposer f) f,
  ) {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> playersRefs<T extends Object>(
    Expression<T> Function($$PlayersTableAnnotationComposer a) f,
  ) {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          Profile,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (Profile, $$ProfilesTableReferences),
          Profile,
          PrefetchHooks Function({bool playersRefs})
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion(id: id, name: name, rowid: rowid),
          createCompanionCallback:
              ({
                required int id,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion.insert(id: id, name: name, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({playersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (playersRefs) db.players],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playersRefs)
                    await $_getPrefetchedData<Profile, $ProfilesTable, Player>(
                      currentTable: table,
                      referencedTable: $$ProfilesTableReferences
                          ._playersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProfilesTableReferences(db, table, p0).playersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.profileId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      Profile,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (Profile, $$ProfilesTableReferences),
      Profile,
      PrefetchHooks Function({bool playersRefs})
    >;
typedef $$GamesTableCreateCompanionBuilder =
    GamesCompanion Function({
      Value<int> id,
      required String name,
      required DateTime createdAt,
      required int currentRound,
      Value<bool> isFinished,
      required int currentPlayerIndex,
      required int winnerPlayerId,
    });
typedef $$GamesTableUpdateCompanionBuilder =
    GamesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<int> currentRound,
      Value<bool> isFinished,
      Value<int> currentPlayerIndex,
      Value<int> winnerPlayerId,
    });

final class $$GamesTableReferences
    extends BaseReferences<_$AppDatabase, $GamesTable, Game> {
  $$GamesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlayersTable, List<Player>> _playersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.players,
    aliasName: $_aliasNameGenerator(db.games.id, db.players.gameId),
  );

  $$PlayersTableProcessedTableManager get playersRefs {
    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.gameId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_playersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RoundsTable, List<Round>> _roundsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.rounds,
    aliasName: $_aliasNameGenerator(db.games.id, db.rounds.gameId),
  );

  $$RoundsTableProcessedTableManager get roundsRefs {
    final manager = $$RoundsTableTableManager(
      $_db,
      $_db.rounds,
    ).filter((f) => f.gameId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_roundsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GamesTableFilterComposer extends Composer<_$AppDatabase, $GamesTable> {
  $$GamesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentRound => $composableBuilder(
    column: $table.currentRound,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFinished => $composableBuilder(
    column: $table.isFinished,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentPlayerIndex => $composableBuilder(
    column: $table.currentPlayerIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get winnerPlayerId => $composableBuilder(
    column: $table.winnerPlayerId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> playersRefs(
    Expression<bool> Function($$PlayersTableFilterComposer f) f,
  ) {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> roundsRefs(
    Expression<bool> Function($$RoundsTableFilterComposer f) f,
  ) {
    final $$RoundsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rounds,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundsTableFilterComposer(
            $db: $db,
            $table: $db.rounds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GamesTableOrderingComposer
    extends Composer<_$AppDatabase, $GamesTable> {
  $$GamesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentRound => $composableBuilder(
    column: $table.currentRound,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFinished => $composableBuilder(
    column: $table.isFinished,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentPlayerIndex => $composableBuilder(
    column: $table.currentPlayerIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get winnerPlayerId => $composableBuilder(
    column: $table.winnerPlayerId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GamesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GamesTable> {
  $$GamesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get currentRound => $composableBuilder(
    column: $table.currentRound,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFinished => $composableBuilder(
    column: $table.isFinished,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentPlayerIndex => $composableBuilder(
    column: $table.currentPlayerIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get winnerPlayerId => $composableBuilder(
    column: $table.winnerPlayerId,
    builder: (column) => column,
  );

  Expression<T> playersRefs<T extends Object>(
    Expression<T> Function($$PlayersTableAnnotationComposer a) f,
  ) {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> roundsRefs<T extends Object>(
    Expression<T> Function($$RoundsTableAnnotationComposer a) f,
  ) {
    final $$RoundsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rounds,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundsTableAnnotationComposer(
            $db: $db,
            $table: $db.rounds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GamesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GamesTable,
          Game,
          $$GamesTableFilterComposer,
          $$GamesTableOrderingComposer,
          $$GamesTableAnnotationComposer,
          $$GamesTableCreateCompanionBuilder,
          $$GamesTableUpdateCompanionBuilder,
          (Game, $$GamesTableReferences),
          Game,
          PrefetchHooks Function({bool playersRefs, bool roundsRefs})
        > {
  $$GamesTableTableManager(_$AppDatabase db, $GamesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GamesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GamesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GamesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> currentRound = const Value.absent(),
                Value<bool> isFinished = const Value.absent(),
                Value<int> currentPlayerIndex = const Value.absent(),
                Value<int> winnerPlayerId = const Value.absent(),
              }) => GamesCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                currentRound: currentRound,
                isFinished: isFinished,
                currentPlayerIndex: currentPlayerIndex,
                winnerPlayerId: winnerPlayerId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required DateTime createdAt,
                required int currentRound,
                Value<bool> isFinished = const Value.absent(),
                required int currentPlayerIndex,
                required int winnerPlayerId,
              }) => GamesCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                currentRound: currentRound,
                isFinished: isFinished,
                currentPlayerIndex: currentPlayerIndex,
                winnerPlayerId: winnerPlayerId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GamesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({playersRefs = false, roundsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playersRefs) db.players,
                if (roundsRefs) db.rounds,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playersRefs)
                    await $_getPrefetchedData<Game, $GamesTable, Player>(
                      currentTable: table,
                      referencedTable: $$GamesTableReferences._playersRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$GamesTableReferences(db, table, p0).playersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.gameId == item.id),
                      typedResults: items,
                    ),
                  if (roundsRefs)
                    await $_getPrefetchedData<Game, $GamesTable, Round>(
                      currentTable: table,
                      referencedTable: $$GamesTableReferences._roundsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$GamesTableReferences(db, table, p0).roundsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.gameId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GamesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GamesTable,
      Game,
      $$GamesTableFilterComposer,
      $$GamesTableOrderingComposer,
      $$GamesTableAnnotationComposer,
      $$GamesTableCreateCompanionBuilder,
      $$GamesTableUpdateCompanionBuilder,
      (Game, $$GamesTableReferences),
      Game,
      PrefetchHooks Function({bool playersRefs, bool roundsRefs})
    >;
typedef $$PlayersTableCreateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> totalPoints,
      Value<int> boltsCount,
      Value<int> barrelAttempts,
      required String name,
      Value<bool> isOnBarrel,
      required int gameId,
      required int profileId,
      Value<int> rowid,
    });
typedef $$PlayersTableUpdateCompanionBuilder =
    PlayersCompanion Function({
      Value<int> totalPoints,
      Value<int> boltsCount,
      Value<int> barrelAttempts,
      Value<String> name,
      Value<bool> isOnBarrel,
      Value<int> gameId,
      Value<int> profileId,
      Value<int> rowid,
    });

final class $$PlayersTableReferences
    extends BaseReferences<_$AppDatabase, $PlayersTable, Player> {
  $$PlayersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GamesTable _gameIdTable(_$AppDatabase db) => db.games.createAlias(
    $_aliasNameGenerator(db.players.gameId, db.games.id),
  );

  $$GamesTableProcessedTableManager get gameId {
    final $_column = $_itemColumn<int>('game_id')!;

    final manager = $$GamesTableTableManager(
      $_db,
      $_db.games,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProfilesTable _profileIdTable(_$AppDatabase db) => db.profiles
      .createAlias($_aliasNameGenerator(db.players.profileId, db.profiles.id));

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<int>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlayersTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get boltsCount => $composableBuilder(
    column: $table.boltsCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get barrelAttempts => $composableBuilder(
    column: $table.barrelAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOnBarrel => $composableBuilder(
    column: $table.isOnBarrel,
    builder: (column) => ColumnFilters(column),
  );

  $$GamesTableFilterComposer get gameId {
    final $$GamesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.games,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GamesTableFilterComposer(
            $db: $db,
            $table: $db.games,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get boltsCount => $composableBuilder(
    column: $table.boltsCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get barrelAttempts => $composableBuilder(
    column: $table.barrelAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOnBarrel => $composableBuilder(
    column: $table.isOnBarrel,
    builder: (column) => ColumnOrderings(column),
  );

  $$GamesTableOrderingComposer get gameId {
    final $$GamesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.games,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GamesTableOrderingComposer(
            $db: $db,
            $table: $db.games,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get totalPoints => $composableBuilder(
    column: $table.totalPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get boltsCount => $composableBuilder(
    column: $table.boltsCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get barrelAttempts => $composableBuilder(
    column: $table.barrelAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isOnBarrel => $composableBuilder(
    column: $table.isOnBarrel,
    builder: (column) => column,
  );

  $$GamesTableAnnotationComposer get gameId {
    final $$GamesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.games,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GamesTableAnnotationComposer(
            $db: $db,
            $table: $db.games,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayersTable,
          Player,
          $$PlayersTableFilterComposer,
          $$PlayersTableOrderingComposer,
          $$PlayersTableAnnotationComposer,
          $$PlayersTableCreateCompanionBuilder,
          $$PlayersTableUpdateCompanionBuilder,
          (Player, $$PlayersTableReferences),
          Player,
          PrefetchHooks Function({bool gameId, bool profileId})
        > {
  $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> totalPoints = const Value.absent(),
                Value<int> boltsCount = const Value.absent(),
                Value<int> barrelAttempts = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isOnBarrel = const Value.absent(),
                Value<int> gameId = const Value.absent(),
                Value<int> profileId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayersCompanion(
                totalPoints: totalPoints,
                boltsCount: boltsCount,
                barrelAttempts: barrelAttempts,
                name: name,
                isOnBarrel: isOnBarrel,
                gameId: gameId,
                profileId: profileId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> totalPoints = const Value.absent(),
                Value<int> boltsCount = const Value.absent(),
                Value<int> barrelAttempts = const Value.absent(),
                required String name,
                Value<bool> isOnBarrel = const Value.absent(),
                required int gameId,
                required int profileId,
                Value<int> rowid = const Value.absent(),
              }) => PlayersCompanion.insert(
                totalPoints: totalPoints,
                boltsCount: boltsCount,
                barrelAttempts: barrelAttempts,
                name: name,
                isOnBarrel: isOnBarrel,
                gameId: gameId,
                profileId: profileId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlayersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gameId = false, profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (gameId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gameId,
                                referencedTable: $$PlayersTableReferences
                                    ._gameIdTable(db),
                                referencedColumn: $$PlayersTableReferences
                                    ._gameIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $$PlayersTableReferences
                                    ._profileIdTable(db),
                                referencedColumn: $$PlayersTableReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayersTable,
      Player,
      $$PlayersTableFilterComposer,
      $$PlayersTableOrderingComposer,
      $$PlayersTableAnnotationComposer,
      $$PlayersTableCreateCompanionBuilder,
      $$PlayersTableUpdateCompanionBuilder,
      (Player, $$PlayersTableReferences),
      Player,
      PrefetchHooks Function({bool gameId, bool profileId})
    >;
typedef $$RoundsTableCreateCompanionBuilder =
    RoundsCompanion Function({
      required int roundNumber,
      required Map<String, int> playerScores,
      required Map<String, List<SpecialGameEvent>> specialEvents,
      required int gameId,
      Value<int> rowid,
    });
typedef $$RoundsTableUpdateCompanionBuilder =
    RoundsCompanion Function({
      Value<int> roundNumber,
      Value<Map<String, int>> playerScores,
      Value<Map<String, List<SpecialGameEvent>>> specialEvents,
      Value<int> gameId,
      Value<int> rowid,
    });

final class $$RoundsTableReferences
    extends BaseReferences<_$AppDatabase, $RoundsTable, Round> {
  $$RoundsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GamesTable _gameIdTable(_$AppDatabase db) =>
      db.games.createAlias($_aliasNameGenerator(db.rounds.gameId, db.games.id));

  $$GamesTableProcessedTableManager get gameId {
    final $_column = $_itemColumn<int>('game_id')!;

    final manager = $$GamesTableTableManager(
      $_db,
      $_db.games,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RoundsTableFilterComposer
    extends Composer<_$AppDatabase, $RoundsTable> {
  $$RoundsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Map<String, int>, Map<String, int>, String>
  get playerScores => $composableBuilder(
    column: $table.playerScores,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, List<SpecialGameEvent>>,
    Map<String, List<SpecialGameEvent>>,
    String
  >
  get specialEvents => $composableBuilder(
    column: $table.specialEvents,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$GamesTableFilterComposer get gameId {
    final $$GamesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.games,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GamesTableFilterComposer(
            $db: $db,
            $table: $db.games,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoundsTableOrderingComposer
    extends Composer<_$AppDatabase, $RoundsTable> {
  $$RoundsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerScores => $composableBuilder(
    column: $table.playerScores,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specialEvents => $composableBuilder(
    column: $table.specialEvents,
    builder: (column) => ColumnOrderings(column),
  );

  $$GamesTableOrderingComposer get gameId {
    final $$GamesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.games,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GamesTableOrderingComposer(
            $db: $db,
            $table: $db.games,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoundsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoundsTable> {
  $$RoundsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Map<String, int>, String> get playerScores =>
      $composableBuilder(
        column: $table.playerScores,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<Map<String, List<SpecialGameEvent>>, String>
  get specialEvents => $composableBuilder(
    column: $table.specialEvents,
    builder: (column) => column,
  );

  $$GamesTableAnnotationComposer get gameId {
    final $$GamesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.games,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GamesTableAnnotationComposer(
            $db: $db,
            $table: $db.games,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoundsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoundsTable,
          Round,
          $$RoundsTableFilterComposer,
          $$RoundsTableOrderingComposer,
          $$RoundsTableAnnotationComposer,
          $$RoundsTableCreateCompanionBuilder,
          $$RoundsTableUpdateCompanionBuilder,
          (Round, $$RoundsTableReferences),
          Round,
          PrefetchHooks Function({bool gameId})
        > {
  $$RoundsTableTableManager(_$AppDatabase db, $RoundsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoundsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoundsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoundsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> roundNumber = const Value.absent(),
                Value<Map<String, int>> playerScores = const Value.absent(),
                Value<Map<String, List<SpecialGameEvent>>> specialEvents =
                    const Value.absent(),
                Value<int> gameId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoundsCompanion(
                roundNumber: roundNumber,
                playerScores: playerScores,
                specialEvents: specialEvents,
                gameId: gameId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int roundNumber,
                required Map<String, int> playerScores,
                required Map<String, List<SpecialGameEvent>> specialEvents,
                required int gameId,
                Value<int> rowid = const Value.absent(),
              }) => RoundsCompanion.insert(
                roundNumber: roundNumber,
                playerScores: playerScores,
                specialEvents: specialEvents,
                gameId: gameId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$RoundsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({gameId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (gameId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gameId,
                                referencedTable: $$RoundsTableReferences
                                    ._gameIdTable(db),
                                referencedColumn: $$RoundsTableReferences
                                    ._gameIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RoundsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoundsTable,
      Round,
      $$RoundsTableFilterComposer,
      $$RoundsTableOrderingComposer,
      $$RoundsTableAnnotationComposer,
      $$RoundsTableCreateCompanionBuilder,
      $$RoundsTableUpdateCompanionBuilder,
      (Round, $$RoundsTableReferences),
      Round,
      PrefetchHooks Function({bool gameId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$GamesTableTableManager get games =>
      $$GamesTableTableManager(_db, _db.games);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$RoundsTableTableManager get rounds =>
      $$RoundsTableTableManager(_db, _db.rounds);
}
