// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ChildrenTable extends Children
    with TableInfo<$ChildrenTable, ChildrenData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChildrenTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
      'avatar', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK(gender IN (\'boy\',\'girl\'))');
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<String> birthday = GeneratedColumn<String>(
      'birthday', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _starsMeta = const VerificationMeta('stars');
  @override
  late final GeneratedColumn<int> stars = GeneratedColumn<int>(
      'stars', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0 CHECK(stars >= 0)',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        avatar,
        gender,
        birthday,
        stars,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'children';
  @override
  VerificationContext validateIntegrity(Insertable<ChildrenData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    }
    if (data.containsKey('stars')) {
      context.handle(
          _starsMeta, stars.isAcceptableOrUnknown(data['stars']!, _starsMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChildrenData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChildrenData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      avatar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}birthday']),
      stars: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stars'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ChildrenTable createAlias(String alias) {
    return $ChildrenTable(attachedDatabase, alias);
  }
}

class ChildrenData extends DataClass implements Insertable<ChildrenData> {
  final int id;
  final String name;
  final String? avatar;
  final String gender;
  final String? birthday;
  final int stars;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ChildrenData(
      {required this.id,
      required this.name,
      this.avatar,
      required this.gender,
      this.birthday,
      required this.stars,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    map['gender'] = Variable<String>(gender);
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<String>(birthday);
    }
    map['stars'] = Variable<int>(stars);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChildrenCompanion toCompanion(bool nullToAbsent) {
    return ChildrenCompanion(
      id: Value(id),
      name: Value(name),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      gender: Value(gender),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      stars: Value(stars),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChildrenData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChildrenData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      gender: serializer.fromJson<String>(json['gender']),
      birthday: serializer.fromJson<String?>(json['birthday']),
      stars: serializer.fromJson<int>(json['stars']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'avatar': serializer.toJson<String?>(avatar),
      'gender': serializer.toJson<String>(gender),
      'birthday': serializer.toJson<String?>(birthday),
      'stars': serializer.toJson<int>(stars),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ChildrenData copyWith(
          {int? id,
          String? name,
          Value<String?> avatar = const Value.absent(),
          String? gender,
          Value<String?> birthday = const Value.absent(),
          int? stars,
          bool? isDeleted,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ChildrenData(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar.present ? avatar.value : this.avatar,
        gender: gender ?? this.gender,
        birthday: birthday.present ? birthday.value : this.birthday,
        stars: stars ?? this.stars,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ChildrenData copyWithCompanion(ChildrenCompanion data) {
    return ChildrenData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      gender: data.gender.present ? data.gender.value : this.gender,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      stars: data.stars.present ? data.stars.value : this.stars,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChildrenData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('gender: $gender, ')
          ..write('birthday: $birthday, ')
          ..write('stars: $stars, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, avatar, gender, birthday, stars,
      isDeleted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChildrenData &&
          other.id == this.id &&
          other.name == this.name &&
          other.avatar == this.avatar &&
          other.gender == this.gender &&
          other.birthday == this.birthday &&
          other.stars == this.stars &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChildrenCompanion extends UpdateCompanion<ChildrenData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> avatar;
  final Value<String> gender;
  final Value<String?> birthday;
  final Value<int> stars;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ChildrenCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.avatar = const Value.absent(),
    this.gender = const Value.absent(),
    this.birthday = const Value.absent(),
    this.stars = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ChildrenCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.avatar = const Value.absent(),
    required String gender,
    this.birthday = const Value.absent(),
    this.stars = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : name = Value(name),
        gender = Value(gender),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ChildrenData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? avatar,
    Expression<String>? gender,
    Expression<String>? birthday,
    Expression<int>? stars,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (gender != null) 'gender': gender,
      if (birthday != null) 'birthday': birthday,
      if (stars != null) 'stars': stars,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ChildrenCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? avatar,
      Value<String>? gender,
      Value<String?>? birthday,
      Value<int>? stars,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ChildrenCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      stars: stars ?? this.stars,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<String>(birthday.value);
    }
    if (stars.present) {
      map['stars'] = Variable<int>(stars.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChildrenCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('gender: $gender, ')
          ..write('birthday: $birthday, ')
          ..write('stars: $stars, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RulesTable extends Rules with TableInfo<$RulesTable, Rule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int> childId = GeneratedColumn<int>(
      'child_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES children (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('star'));
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
      'points', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK(points > 0)');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('reward'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isSystemMeta =
      const VerificationMeta('isSystem');
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
      'is_system', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_system" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isEditableMeta =
      const VerificationMeta('isEditable');
  @override
  late final GeneratedColumn<bool> isEditable = GeneratedColumn<bool>(
      'is_editable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_editable" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        name,
        icon,
        points,
        type,
        isActive,
        isSystem,
        isEditable,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rules';
  @override
  VerificationContext validateIntegrity(Insertable<Rule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('points')) {
      context.handle(_pointsMeta,
          points.isAcceptableOrUnknown(data['points']!, _pointsMeta));
    } else if (isInserting) {
      context.missing(_pointsMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('is_system')) {
      context.handle(_isSystemMeta,
          isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta));
    }
    if (data.containsKey('is_editable')) {
      context.handle(
          _isEditableMeta,
          isEditable.isAcceptableOrUnknown(
              data['is_editable']!, _isEditableMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Rule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Rule(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      points: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}points'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      isSystem: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_system'])!,
      isEditable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_editable'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $RulesTable createAlias(String alias) {
    return $RulesTable(attachedDatabase, alias);
  }
}

class Rule extends DataClass implements Insertable<Rule> {
  final int id;
  final int? childId;
  final String name;
  final String icon;
  final int points;
  final String type;
  final bool isActive;
  final bool isSystem;
  final bool isEditable;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Rule(
      {required this.id,
      this.childId,
      required this.name,
      required this.icon,
      required this.points,
      required this.type,
      required this.isActive,
      required this.isSystem,
      required this.isEditable,
      required this.isDeleted,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || childId != null) {
      map['child_id'] = Variable<int>(childId);
    }
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['points'] = Variable<int>(points);
    map['type'] = Variable<String>(type);
    map['is_active'] = Variable<bool>(isActive);
    map['is_system'] = Variable<bool>(isSystem);
    map['is_editable'] = Variable<bool>(isEditable);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  RulesCompanion toCompanion(bool nullToAbsent) {
    return RulesCompanion(
      id: Value(id),
      childId: childId == null && nullToAbsent
          ? const Value.absent()
          : Value(childId),
      name: Value(name),
      icon: Value(icon),
      points: Value(points),
      type: Value(type),
      isActive: Value(isActive),
      isSystem: Value(isSystem),
      isEditable: Value(isEditable),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Rule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Rule(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<int?>(json['childId']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      points: serializer.fromJson<int>(json['points']),
      type: serializer.fromJson<String>(json['type']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      isEditable: serializer.fromJson<bool>(json['isEditable']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<int?>(childId),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'points': serializer.toJson<int>(points),
      'type': serializer.toJson<String>(type),
      'isActive': serializer.toJson<bool>(isActive),
      'isSystem': serializer.toJson<bool>(isSystem),
      'isEditable': serializer.toJson<bool>(isEditable),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Rule copyWith(
          {int? id,
          Value<int?> childId = const Value.absent(),
          String? name,
          String? icon,
          int? points,
          String? type,
          bool? isActive,
          bool? isSystem,
          bool? isEditable,
          bool? isDeleted,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Rule(
        id: id ?? this.id,
        childId: childId.present ? childId.value : this.childId,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        points: points ?? this.points,
        type: type ?? this.type,
        isActive: isActive ?? this.isActive,
        isSystem: isSystem ?? this.isSystem,
        isEditable: isEditable ?? this.isEditable,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Rule copyWithCompanion(RulesCompanion data) {
    return Rule(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      points: data.points.present ? data.points.value : this.points,
      type: data.type.present ? data.type.value : this.type,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      isEditable:
          data.isEditable.present ? data.isEditable.value : this.isEditable,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Rule(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('points: $points, ')
          ..write('type: $type, ')
          ..write('isActive: $isActive, ')
          ..write('isSystem: $isSystem, ')
          ..write('isEditable: $isEditable, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, childId, name, icon, points, type,
      isActive, isSystem, isEditable, isDeleted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rule &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.points == this.points &&
          other.type == this.type &&
          other.isActive == this.isActive &&
          other.isSystem == this.isSystem &&
          other.isEditable == this.isEditable &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RulesCompanion extends UpdateCompanion<Rule> {
  final Value<int> id;
  final Value<int?> childId;
  final Value<String> name;
  final Value<String> icon;
  final Value<int> points;
  final Value<String> type;
  final Value<bool> isActive;
  final Value<bool> isSystem;
  final Value<bool> isEditable;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const RulesCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.points = const Value.absent(),
    this.type = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.isEditable = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RulesCompanion.insert({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    required String name,
    this.icon = const Value.absent(),
    required int points,
    this.type = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.isEditable = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : name = Value(name),
        points = Value(points),
        createdAt = Value(createdAt);
  static Insertable<Rule> custom({
    Expression<int>? id,
    Expression<int>? childId,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? points,
    Expression<String>? type,
    Expression<bool>? isActive,
    Expression<bool>? isSystem,
    Expression<bool>? isEditable,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (points != null) 'points': points,
      if (type != null) 'type': type,
      if (isActive != null) 'is_active': isActive,
      if (isSystem != null) 'is_system': isSystem,
      if (isEditable != null) 'is_editable': isEditable,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RulesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? childId,
      Value<String>? name,
      Value<String>? icon,
      Value<int>? points,
      Value<String>? type,
      Value<bool>? isActive,
      Value<bool>? isSystem,
      Value<bool>? isEditable,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return RulesCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      points: points ?? this.points,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      isSystem: isSystem ?? this.isSystem,
      isEditable: isEditable ?? this.isEditable,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<int>(childId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (isEditable.present) {
      map['is_editable'] = Variable<bool>(isEditable.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RulesCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('points: $points, ')
          ..write('type: $type, ')
          ..write('isActive: $isActive, ')
          ..write('isSystem: $isSystem, ')
          ..write('isEditable: $isEditable, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RewardsTable extends Rewards with TableInfo<$RewardsTable, Reward> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RewardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
      'price', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK(price > 0)');
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('other'));
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'CHECK(stock IS NULL OR stock >= 0)');
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        image,
        price,
        category,
        stock,
        isActive,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rewards';
  @override
  VerificationContext validateIntegrity(Insertable<Reward> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('stock')) {
      context.handle(
          _stockMeta, stock.isAcceptableOrUnknown(data['stock']!, _stockMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reward map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reward(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $RewardsTable createAlias(String alias) {
    return $RewardsTable(attachedDatabase, alias);
  }
}

class Reward extends DataClass implements Insertable<Reward> {
  final int id;
  final String name;
  final String? description;
  final String? image;
  final int price;
  final String category;
  final int? stock;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Reward(
      {required this.id,
      required this.name,
      this.description,
      this.image,
      required this.price,
      required this.category,
      this.stock,
      required this.isActive,
      required this.isDeleted,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    map['price'] = Variable<int>(price);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || stock != null) {
      map['stock'] = Variable<int>(stock);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  RewardsCompanion toCompanion(bool nullToAbsent) {
    return RewardsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      price: Value(price),
      category: Value(category),
      stock:
          stock == null && nullToAbsent ? const Value.absent() : Value(stock),
      isActive: Value(isActive),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Reward.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reward(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      image: serializer.fromJson<String?>(json['image']),
      price: serializer.fromJson<int>(json['price']),
      category: serializer.fromJson<String>(json['category']),
      stock: serializer.fromJson<int?>(json['stock']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'image': serializer.toJson<String?>(image),
      'price': serializer.toJson<int>(price),
      'category': serializer.toJson<String>(category),
      'stock': serializer.toJson<int?>(stock),
      'isActive': serializer.toJson<bool>(isActive),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Reward copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> image = const Value.absent(),
          int? price,
          String? category,
          Value<int?> stock = const Value.absent(),
          bool? isActive,
          bool? isDeleted,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Reward(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        image: image.present ? image.value : this.image,
        price: price ?? this.price,
        category: category ?? this.category,
        stock: stock.present ? stock.value : this.stock,
        isActive: isActive ?? this.isActive,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Reward copyWithCompanion(RewardsCompanion data) {
    return Reward(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      image: data.image.present ? data.image.value : this.image,
      price: data.price.present ? data.price.value : this.price,
      category: data.category.present ? data.category.value : this.category,
      stock: data.stock.present ? data.stock.value : this.stock,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reward(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('image: $image, ')
          ..write('price: $price, ')
          ..write('category: $category, ')
          ..write('stock: $stock, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, image, price, category,
      stock, isActive, isDeleted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reward &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.image == this.image &&
          other.price == this.price &&
          other.category == this.category &&
          other.stock == this.stock &&
          other.isActive == this.isActive &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RewardsCompanion extends UpdateCompanion<Reward> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> image;
  final Value<int> price;
  final Value<String> category;
  final Value<int?> stock;
  final Value<bool> isActive;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const RewardsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.image = const Value.absent(),
    this.price = const Value.absent(),
    this.category = const Value.absent(),
    this.stock = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RewardsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.image = const Value.absent(),
    required int price,
    this.category = const Value.absent(),
    this.stock = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : name = Value(name),
        price = Value(price),
        createdAt = Value(createdAt);
  static Insertable<Reward> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? image,
    Expression<int>? price,
    Expression<String>? category,
    Expression<int>? stock,
    Expression<bool>? isActive,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (image != null) 'image': image,
      if (price != null) 'price': price,
      if (category != null) 'category': category,
      if (stock != null) 'stock': stock,
      if (isActive != null) 'is_active': isActive,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RewardsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? image,
      Value<int>? price,
      Value<String>? category,
      Value<int?>? stock,
      Value<bool>? isActive,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return RewardsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RewardsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('image: $image, ')
          ..write('price: $price, ')
          ..write('category: $category, ')
          ..write('stock: $stock, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ExchangesTable extends Exchanges
    with TableInfo<$ExchangesTable, Exchange> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExchangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int> childId = GeneratedColumn<int>(
      'child_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES children (id)'));
  static const VerificationMeta _rewardIdMeta =
      const VerificationMeta('rewardId');
  @override
  late final GeneratedColumn<int> rewardId = GeneratedColumn<int>(
      'reward_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES rewards (id)'));
  static const VerificationMeta _rewardSnapshotMeta =
      const VerificationMeta('rewardSnapshot');
  @override
  late final GeneratedColumn<String> rewardSnapshot = GeneratedColumn<String>(
      'reward_snapshot', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pointsSpentMeta =
      const VerificationMeta('pointsSpent');
  @override
  late final GeneratedColumn<int> pointsSpent = GeneratedColumn<int>(
      'points_spent', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        rewardId,
        rewardSnapshot,
        pointsSpent,
        note,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exchanges';
  @override
  VerificationContext validateIntegrity(Insertable<Exchange> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('reward_id')) {
      context.handle(_rewardIdMeta,
          rewardId.isAcceptableOrUnknown(data['reward_id']!, _rewardIdMeta));
    } else if (isInserting) {
      context.missing(_rewardIdMeta);
    }
    if (data.containsKey('reward_snapshot')) {
      context.handle(
          _rewardSnapshotMeta,
          rewardSnapshot.isAcceptableOrUnknown(
              data['reward_snapshot']!, _rewardSnapshotMeta));
    } else if (isInserting) {
      context.missing(_rewardSnapshotMeta);
    }
    if (data.containsKey('points_spent')) {
      context.handle(
          _pointsSpentMeta,
          pointsSpent.isAcceptableOrUnknown(
              data['points_spent']!, _pointsSpentMeta));
    } else if (isInserting) {
      context.missing(_pointsSpentMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exchange map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exchange(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_id'])!,
      rewardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reward_id'])!,
      rewardSnapshot: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}reward_snapshot'])!,
      pointsSpent: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}points_spent'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ExchangesTable createAlias(String alias) {
    return $ExchangesTable(attachedDatabase, alias);
  }
}

class Exchange extends DataClass implements Insertable<Exchange> {
  final int id;
  final int childId;
  final int rewardId;
  final String rewardSnapshot;
  final int pointsSpent;
  final String? note;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Exchange(
      {required this.id,
      required this.childId,
      required this.rewardId,
      required this.rewardSnapshot,
      required this.pointsSpent,
      this.note,
      required this.isDeleted,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['child_id'] = Variable<int>(childId);
    map['reward_id'] = Variable<int>(rewardId);
    map['reward_snapshot'] = Variable<String>(rewardSnapshot);
    map['points_spent'] = Variable<int>(pointsSpent);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ExchangesCompanion toCompanion(bool nullToAbsent) {
    return ExchangesCompanion(
      id: Value(id),
      childId: Value(childId),
      rewardId: Value(rewardId),
      rewardSnapshot: Value(rewardSnapshot),
      pointsSpent: Value(pointsSpent),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Exchange.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exchange(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<int>(json['childId']),
      rewardId: serializer.fromJson<int>(json['rewardId']),
      rewardSnapshot: serializer.fromJson<String>(json['rewardSnapshot']),
      pointsSpent: serializer.fromJson<int>(json['pointsSpent']),
      note: serializer.fromJson<String?>(json['note']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<int>(childId),
      'rewardId': serializer.toJson<int>(rewardId),
      'rewardSnapshot': serializer.toJson<String>(rewardSnapshot),
      'pointsSpent': serializer.toJson<int>(pointsSpent),
      'note': serializer.toJson<String?>(note),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Exchange copyWith(
          {int? id,
          int? childId,
          int? rewardId,
          String? rewardSnapshot,
          int? pointsSpent,
          Value<String?> note = const Value.absent(),
          bool? isDeleted,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Exchange(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        rewardId: rewardId ?? this.rewardId,
        rewardSnapshot: rewardSnapshot ?? this.rewardSnapshot,
        pointsSpent: pointsSpent ?? this.pointsSpent,
        note: note.present ? note.value : this.note,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Exchange copyWithCompanion(ExchangesCompanion data) {
    return Exchange(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      rewardId: data.rewardId.present ? data.rewardId.value : this.rewardId,
      rewardSnapshot: data.rewardSnapshot.present
          ? data.rewardSnapshot.value
          : this.rewardSnapshot,
      pointsSpent:
          data.pointsSpent.present ? data.pointsSpent.value : this.pointsSpent,
      note: data.note.present ? data.note.value : this.note,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exchange(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('rewardId: $rewardId, ')
          ..write('rewardSnapshot: $rewardSnapshot, ')
          ..write('pointsSpent: $pointsSpent, ')
          ..write('note: $note, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, childId, rewardId, rewardSnapshot,
      pointsSpent, note, isDeleted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exchange &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.rewardId == this.rewardId &&
          other.rewardSnapshot == this.rewardSnapshot &&
          other.pointsSpent == this.pointsSpent &&
          other.note == this.note &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExchangesCompanion extends UpdateCompanion<Exchange> {
  final Value<int> id;
  final Value<int> childId;
  final Value<int> rewardId;
  final Value<String> rewardSnapshot;
  final Value<int> pointsSpent;
  final Value<String?> note;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const ExchangesCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.rewardId = const Value.absent(),
    this.rewardSnapshot = const Value.absent(),
    this.pointsSpent = const Value.absent(),
    this.note = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ExchangesCompanion.insert({
    this.id = const Value.absent(),
    required int childId,
    required int rewardId,
    required String rewardSnapshot,
    required int pointsSpent,
    this.note = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : childId = Value(childId),
        rewardId = Value(rewardId),
        rewardSnapshot = Value(rewardSnapshot),
        pointsSpent = Value(pointsSpent),
        createdAt = Value(createdAt);
  static Insertable<Exchange> custom({
    Expression<int>? id,
    Expression<int>? childId,
    Expression<int>? rewardId,
    Expression<String>? rewardSnapshot,
    Expression<int>? pointsSpent,
    Expression<String>? note,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (rewardId != null) 'reward_id': rewardId,
      if (rewardSnapshot != null) 'reward_snapshot': rewardSnapshot,
      if (pointsSpent != null) 'points_spent': pointsSpent,
      if (note != null) 'note': note,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ExchangesCompanion copyWith(
      {Value<int>? id,
      Value<int>? childId,
      Value<int>? rewardId,
      Value<String>? rewardSnapshot,
      Value<int>? pointsSpent,
      Value<String?>? note,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return ExchangesCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      rewardId: rewardId ?? this.rewardId,
      rewardSnapshot: rewardSnapshot ?? this.rewardSnapshot,
      pointsSpent: pointsSpent ?? this.pointsSpent,
      note: note ?? this.note,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<int>(childId.value);
    }
    if (rewardId.present) {
      map['reward_id'] = Variable<int>(rewardId.value);
    }
    if (rewardSnapshot.present) {
      map['reward_snapshot'] = Variable<String>(rewardSnapshot.value);
    }
    if (pointsSpent.present) {
      map['points_spent'] = Variable<int>(pointsSpent.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExchangesCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('rewardId: $rewardId, ')
          ..write('rewardSnapshot: $rewardSnapshot, ')
          ..write('pointsSpent: $pointsSpent, ')
          ..write('note: $note, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PointRecordsTable extends PointRecords
    with TableInfo<$PointRecordsTable, PointRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PointRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int> childId = GeneratedColumn<int>(
      'child_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES children (id)'));
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<int> ruleId = GeneratedColumn<int>(
      'rule_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES rules (id)'));
  static const VerificationMeta _ruleNameMeta =
      const VerificationMeta('ruleName');
  @override
  late final GeneratedColumn<String> ruleName = GeneratedColumn<String>(
      'rule_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _exchangeIdMeta =
      const VerificationMeta('exchangeId');
  @override
  late final GeneratedColumn<int> exchangeId = GeneratedColumn<int>(
      'exchange_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exchanges (id)'));
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
      'points', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK(type IN (\'earned\',\'deducted\',\'spent\'))');
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        ruleId,
        ruleName,
        exchangeId,
        points,
        type,
        note,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'point_records';
  @override
  VerificationContext validateIntegrity(Insertable<PointRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('rule_id')) {
      context.handle(_ruleIdMeta,
          ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta));
    }
    if (data.containsKey('rule_name')) {
      context.handle(_ruleNameMeta,
          ruleName.isAcceptableOrUnknown(data['rule_name']!, _ruleNameMeta));
    }
    if (data.containsKey('exchange_id')) {
      context.handle(
          _exchangeIdMeta,
          exchangeId.isAcceptableOrUnknown(
              data['exchange_id']!, _exchangeIdMeta));
    }
    if (data.containsKey('points')) {
      context.handle(_pointsMeta,
          points.isAcceptableOrUnknown(data['points']!, _pointsMeta));
    } else if (isInserting) {
      context.missing(_pointsMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PointRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PointRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_id'])!,
      ruleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rule_id']),
      ruleName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rule_name']),
      exchangeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exchange_id']),
      points: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}points'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $PointRecordsTable createAlias(String alias) {
    return $PointRecordsTable(attachedDatabase, alias);
  }
}

class PointRecord extends DataClass implements Insertable<PointRecord> {
  final int id;
  final int childId;
  final int? ruleId;
  final String? ruleName;
  final int? exchangeId;
  final int points;
  final String type;
  final String? note;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const PointRecord(
      {required this.id,
      required this.childId,
      this.ruleId,
      this.ruleName,
      this.exchangeId,
      required this.points,
      required this.type,
      this.note,
      required this.isDeleted,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['child_id'] = Variable<int>(childId);
    if (!nullToAbsent || ruleId != null) {
      map['rule_id'] = Variable<int>(ruleId);
    }
    if (!nullToAbsent || ruleName != null) {
      map['rule_name'] = Variable<String>(ruleName);
    }
    if (!nullToAbsent || exchangeId != null) {
      map['exchange_id'] = Variable<int>(exchangeId);
    }
    map['points'] = Variable<int>(points);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  PointRecordsCompanion toCompanion(bool nullToAbsent) {
    return PointRecordsCompanion(
      id: Value(id),
      childId: Value(childId),
      ruleId:
          ruleId == null && nullToAbsent ? const Value.absent() : Value(ruleId),
      ruleName: ruleName == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleName),
      exchangeId: exchangeId == null && nullToAbsent
          ? const Value.absent()
          : Value(exchangeId),
      points: Value(points),
      type: Value(type),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory PointRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PointRecord(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<int>(json['childId']),
      ruleId: serializer.fromJson<int?>(json['ruleId']),
      ruleName: serializer.fromJson<String?>(json['ruleName']),
      exchangeId: serializer.fromJson<int?>(json['exchangeId']),
      points: serializer.fromJson<int>(json['points']),
      type: serializer.fromJson<String>(json['type']),
      note: serializer.fromJson<String?>(json['note']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<int>(childId),
      'ruleId': serializer.toJson<int?>(ruleId),
      'ruleName': serializer.toJson<String?>(ruleName),
      'exchangeId': serializer.toJson<int?>(exchangeId),
      'points': serializer.toJson<int>(points),
      'type': serializer.toJson<String>(type),
      'note': serializer.toJson<String?>(note),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  PointRecord copyWith(
          {int? id,
          int? childId,
          Value<int?> ruleId = const Value.absent(),
          Value<String?> ruleName = const Value.absent(),
          Value<int?> exchangeId = const Value.absent(),
          int? points,
          String? type,
          Value<String?> note = const Value.absent(),
          bool? isDeleted,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      PointRecord(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        ruleId: ruleId.present ? ruleId.value : this.ruleId,
        ruleName: ruleName.present ? ruleName.value : this.ruleName,
        exchangeId: exchangeId.present ? exchangeId.value : this.exchangeId,
        points: points ?? this.points,
        type: type ?? this.type,
        note: note.present ? note.value : this.note,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  PointRecord copyWithCompanion(PointRecordsCompanion data) {
    return PointRecord(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      ruleName: data.ruleName.present ? data.ruleName.value : this.ruleName,
      exchangeId:
          data.exchangeId.present ? data.exchangeId.value : this.exchangeId,
      points: data.points.present ? data.points.value : this.points,
      type: data.type.present ? data.type.value : this.type,
      note: data.note.present ? data.note.value : this.note,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PointRecord(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('ruleId: $ruleId, ')
          ..write('ruleName: $ruleName, ')
          ..write('exchangeId: $exchangeId, ')
          ..write('points: $points, ')
          ..write('type: $type, ')
          ..write('note: $note, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, childId, ruleId, ruleName, exchangeId,
      points, type, note, isDeleted, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PointRecord &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.ruleId == this.ruleId &&
          other.ruleName == this.ruleName &&
          other.exchangeId == this.exchangeId &&
          other.points == this.points &&
          other.type == this.type &&
          other.note == this.note &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PointRecordsCompanion extends UpdateCompanion<PointRecord> {
  final Value<int> id;
  final Value<int> childId;
  final Value<int?> ruleId;
  final Value<String?> ruleName;
  final Value<int?> exchangeId;
  final Value<int> points;
  final Value<String> type;
  final Value<String?> note;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const PointRecordsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.ruleName = const Value.absent(),
    this.exchangeId = const Value.absent(),
    this.points = const Value.absent(),
    this.type = const Value.absent(),
    this.note = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PointRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int childId,
    this.ruleId = const Value.absent(),
    this.ruleName = const Value.absent(),
    this.exchangeId = const Value.absent(),
    required int points,
    required String type,
    this.note = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : childId = Value(childId),
        points = Value(points),
        type = Value(type),
        createdAt = Value(createdAt);
  static Insertable<PointRecord> custom({
    Expression<int>? id,
    Expression<int>? childId,
    Expression<int>? ruleId,
    Expression<String>? ruleName,
    Expression<int>? exchangeId,
    Expression<int>? points,
    Expression<String>? type,
    Expression<String>? note,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (ruleId != null) 'rule_id': ruleId,
      if (ruleName != null) 'rule_name': ruleName,
      if (exchangeId != null) 'exchange_id': exchangeId,
      if (points != null) 'points': points,
      if (type != null) 'type': type,
      if (note != null) 'note': note,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PointRecordsCompanion copyWith(
      {Value<int>? id,
      Value<int>? childId,
      Value<int?>? ruleId,
      Value<String?>? ruleName,
      Value<int?>? exchangeId,
      Value<int>? points,
      Value<String>? type,
      Value<String?>? note,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return PointRecordsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      ruleId: ruleId ?? this.ruleId,
      ruleName: ruleName ?? this.ruleName,
      exchangeId: exchangeId ?? this.exchangeId,
      points: points ?? this.points,
      type: type ?? this.type,
      note: note ?? this.note,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<int>(childId.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<int>(ruleId.value);
    }
    if (ruleName.present) {
      map['rule_name'] = Variable<String>(ruleName.value);
    }
    if (exchangeId.present) {
      map['exchange_id'] = Variable<int>(exchangeId.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PointRecordsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('ruleId: $ruleId, ')
          ..write('ruleName: $ruleName, ')
          ..write('exchangeId: $exchangeId, ')
          ..write('points: $points, ')
          ..write('type: $type, ')
          ..write('note: $note, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AppContentsTable extends AppContents
    with TableInfo<$AppContentsTable, AppContent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppContentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _titleEnMeta =
      const VerificationMeta('titleEn');
  @override
  late final GeneratedColumn<String> titleEn = GeneratedColumn<String>(
      'title_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleZhMeta =
      const VerificationMeta('titleZh');
  @override
  late final GeneratedColumn<String> titleZh = GeneratedColumn<String>(
      'title_zh', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentEnMeta =
      const VerificationMeta('contentEn');
  @override
  late final GeneratedColumn<String> contentEn = GeneratedColumn<String>(
      'content_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentZhMeta =
      const VerificationMeta('contentZh');
  @override
  late final GeneratedColumn<String> contentZh = GeneratedColumn<String>(
      'content_zh', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        key,
        titleEn,
        titleZh,
        contentEn,
        contentZh,
        version,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_contents';
  @override
  VerificationContext validateIntegrity(Insertable<AppContent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('title_en')) {
      context.handle(_titleEnMeta,
          titleEn.isAcceptableOrUnknown(data['title_en']!, _titleEnMeta));
    } else if (isInserting) {
      context.missing(_titleEnMeta);
    }
    if (data.containsKey('title_zh')) {
      context.handle(_titleZhMeta,
          titleZh.isAcceptableOrUnknown(data['title_zh']!, _titleZhMeta));
    } else if (isInserting) {
      context.missing(_titleZhMeta);
    }
    if (data.containsKey('content_en')) {
      context.handle(_contentEnMeta,
          contentEn.isAcceptableOrUnknown(data['content_en']!, _contentEnMeta));
    } else if (isInserting) {
      context.missing(_contentEnMeta);
    }
    if (data.containsKey('content_zh')) {
      context.handle(_contentZhMeta,
          contentZh.isAcceptableOrUnknown(data['content_zh']!, _contentZhMeta));
    } else if (isInserting) {
      context.missing(_contentZhMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppContent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppContent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      titleEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title_en'])!,
      titleZh: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title_zh'])!,
      contentEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_en'])!,
      contentZh: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_zh'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $AppContentsTable createAlias(String alias) {
    return $AppContentsTable(attachedDatabase, alias);
  }
}

class AppContent extends DataClass implements Insertable<AppContent> {
  final int id;
  final String key;
  final String titleEn;
  final String titleZh;
  final String contentEn;
  final String contentZh;
  final int version;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const AppContent(
      {required this.id,
      required this.key,
      required this.titleEn,
      required this.titleZh,
      required this.contentEn,
      required this.contentZh,
      required this.version,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['title_en'] = Variable<String>(titleEn);
    map['title_zh'] = Variable<String>(titleZh);
    map['content_en'] = Variable<String>(contentEn);
    map['content_zh'] = Variable<String>(contentZh);
    map['version'] = Variable<int>(version);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  AppContentsCompanion toCompanion(bool nullToAbsent) {
    return AppContentsCompanion(
      id: Value(id),
      key: Value(key),
      titleEn: Value(titleEn),
      titleZh: Value(titleZh),
      contentEn: Value(contentEn),
      contentZh: Value(contentZh),
      version: Value(version),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory AppContent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppContent(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      titleEn: serializer.fromJson<String>(json['titleEn']),
      titleZh: serializer.fromJson<String>(json['titleZh']),
      contentEn: serializer.fromJson<String>(json['contentEn']),
      contentZh: serializer.fromJson<String>(json['contentZh']),
      version: serializer.fromJson<int>(json['version']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'titleEn': serializer.toJson<String>(titleEn),
      'titleZh': serializer.toJson<String>(titleZh),
      'contentEn': serializer.toJson<String>(contentEn),
      'contentZh': serializer.toJson<String>(contentZh),
      'version': serializer.toJson<int>(version),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  AppContent copyWith(
          {int? id,
          String? key,
          String? titleEn,
          String? titleZh,
          String? contentEn,
          String? contentZh,
          int? version,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      AppContent(
        id: id ?? this.id,
        key: key ?? this.key,
        titleEn: titleEn ?? this.titleEn,
        titleZh: titleZh ?? this.titleZh,
        contentEn: contentEn ?? this.contentEn,
        contentZh: contentZh ?? this.contentZh,
        version: version ?? this.version,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  AppContent copyWithCompanion(AppContentsCompanion data) {
    return AppContent(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      titleEn: data.titleEn.present ? data.titleEn.value : this.titleEn,
      titleZh: data.titleZh.present ? data.titleZh.value : this.titleZh,
      contentEn: data.contentEn.present ? data.contentEn.value : this.contentEn,
      contentZh: data.contentZh.present ? data.contentZh.value : this.contentZh,
      version: data.version.present ? data.version.value : this.version,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppContent(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleZh: $titleZh, ')
          ..write('contentEn: $contentEn, ')
          ..write('contentZh: $contentZh, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, titleEn, titleZh, contentEn,
      contentZh, version, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppContent &&
          other.id == this.id &&
          other.key == this.key &&
          other.titleEn == this.titleEn &&
          other.titleZh == this.titleZh &&
          other.contentEn == this.contentEn &&
          other.contentZh == this.contentZh &&
          other.version == this.version &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppContentsCompanion extends UpdateCompanion<AppContent> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> titleEn;
  final Value<String> titleZh;
  final Value<String> contentEn;
  final Value<String> contentZh;
  final Value<int> version;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const AppContentsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.titleZh = const Value.absent(),
    this.contentEn = const Value.absent(),
    this.contentZh = const Value.absent(),
    this.version = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppContentsCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String titleEn,
    required String titleZh,
    required String contentEn,
    required String contentZh,
    this.version = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : key = Value(key),
        titleEn = Value(titleEn),
        titleZh = Value(titleZh),
        contentEn = Value(contentEn),
        contentZh = Value(contentZh),
        createdAt = Value(createdAt);
  static Insertable<AppContent> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? titleEn,
    Expression<String>? titleZh,
    Expression<String>? contentEn,
    Expression<String>? contentZh,
    Expression<int>? version,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (titleEn != null) 'title_en': titleEn,
      if (titleZh != null) 'title_zh': titleZh,
      if (contentEn != null) 'content_en': contentEn,
      if (contentZh != null) 'content_zh': contentZh,
      if (version != null) 'version': version,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppContentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? key,
      Value<String>? titleEn,
      Value<String>? titleZh,
      Value<String>? contentEn,
      Value<String>? contentZh,
      Value<int>? version,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return AppContentsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      titleEn: titleEn ?? this.titleEn,
      titleZh: titleZh ?? this.titleZh,
      contentEn: contentEn ?? this.contentEn,
      contentZh: contentZh ?? this.contentZh,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (titleEn.present) {
      map['title_en'] = Variable<String>(titleEn.value);
    }
    if (titleZh.present) {
      map['title_zh'] = Variable<String>(titleZh.value);
    }
    if (contentEn.present) {
      map['content_en'] = Variable<String>(contentEn.value);
    }
    if (contentZh.present) {
      map['content_zh'] = Variable<String>(contentZh.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppContentsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleZh: $titleZh, ')
          ..write('contentEn: $contentEn, ')
          ..write('contentZh: $contentZh, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AppLogsTable extends AppLogs with TableInfo<$AppLogsTable, AppLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
      'level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stackTraceMeta =
      const VerificationMeta('stackTrace');
  @override
  late final GeneratedColumn<String> stackTrace = GeneratedColumn<String>(
      'stack_trace', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _extraMeta = const VerificationMeta('extra');
  @override
  late final GeneratedColumn<String> extra = GeneratedColumn<String>(
      'extra', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, level, tag, message, stackTrace, extra, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_logs';
  @override
  VerificationContext validateIntegrity(Insertable<AppLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('stack_trace')) {
      context.handle(
          _stackTraceMeta,
          stackTrace.isAcceptableOrUnknown(
              data['stack_trace']!, _stackTraceMeta));
    }
    if (data.containsKey('extra')) {
      context.handle(
          _extraMeta, extra.isAcceptableOrUnknown(data['extra']!, _extraMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}level'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      stackTrace: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stack_trace']),
      extra: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}extra']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AppLogsTable createAlias(String alias) {
    return $AppLogsTable(attachedDatabase, alias);
  }
}

class AppLog extends DataClass implements Insertable<AppLog> {
  final int id;
  final String level;
  final String tag;
  final String message;
  final String? stackTrace;
  final String? extra;
  final DateTime createdAt;
  const AppLog(
      {required this.id,
      required this.level,
      required this.tag,
      required this.message,
      this.stackTrace,
      this.extra,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['level'] = Variable<String>(level);
    map['tag'] = Variable<String>(tag);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || stackTrace != null) {
      map['stack_trace'] = Variable<String>(stackTrace);
    }
    if (!nullToAbsent || extra != null) {
      map['extra'] = Variable<String>(extra);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AppLogsCompanion toCompanion(bool nullToAbsent) {
    return AppLogsCompanion(
      id: Value(id),
      level: Value(level),
      tag: Value(tag),
      message: Value(message),
      stackTrace: stackTrace == null && nullToAbsent
          ? const Value.absent()
          : Value(stackTrace),
      extra:
          extra == null && nullToAbsent ? const Value.absent() : Value(extra),
      createdAt: Value(createdAt),
    );
  }

  factory AppLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppLog(
      id: serializer.fromJson<int>(json['id']),
      level: serializer.fromJson<String>(json['level']),
      tag: serializer.fromJson<String>(json['tag']),
      message: serializer.fromJson<String>(json['message']),
      stackTrace: serializer.fromJson<String?>(json['stackTrace']),
      extra: serializer.fromJson<String?>(json['extra']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'level': serializer.toJson<String>(level),
      'tag': serializer.toJson<String>(tag),
      'message': serializer.toJson<String>(message),
      'stackTrace': serializer.toJson<String?>(stackTrace),
      'extra': serializer.toJson<String?>(extra),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AppLog copyWith(
          {int? id,
          String? level,
          String? tag,
          String? message,
          Value<String?> stackTrace = const Value.absent(),
          Value<String?> extra = const Value.absent(),
          DateTime? createdAt}) =>
      AppLog(
        id: id ?? this.id,
        level: level ?? this.level,
        tag: tag ?? this.tag,
        message: message ?? this.message,
        stackTrace: stackTrace.present ? stackTrace.value : this.stackTrace,
        extra: extra.present ? extra.value : this.extra,
        createdAt: createdAt ?? this.createdAt,
      );
  AppLog copyWithCompanion(AppLogsCompanion data) {
    return AppLog(
      id: data.id.present ? data.id.value : this.id,
      level: data.level.present ? data.level.value : this.level,
      tag: data.tag.present ? data.tag.value : this.tag,
      message: data.message.present ? data.message.value : this.message,
      stackTrace:
          data.stackTrace.present ? data.stackTrace.value : this.stackTrace,
      extra: data.extra.present ? data.extra.value : this.extra,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppLog(')
          ..write('id: $id, ')
          ..write('level: $level, ')
          ..write('tag: $tag, ')
          ..write('message: $message, ')
          ..write('stackTrace: $stackTrace, ')
          ..write('extra: $extra, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, level, tag, message, stackTrace, extra, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLog &&
          other.id == this.id &&
          other.level == this.level &&
          other.tag == this.tag &&
          other.message == this.message &&
          other.stackTrace == this.stackTrace &&
          other.extra == this.extra &&
          other.createdAt == this.createdAt);
}

class AppLogsCompanion extends UpdateCompanion<AppLog> {
  final Value<int> id;
  final Value<String> level;
  final Value<String> tag;
  final Value<String> message;
  final Value<String?> stackTrace;
  final Value<String?> extra;
  final Value<DateTime> createdAt;
  const AppLogsCompanion({
    this.id = const Value.absent(),
    this.level = const Value.absent(),
    this.tag = const Value.absent(),
    this.message = const Value.absent(),
    this.stackTrace = const Value.absent(),
    this.extra = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AppLogsCompanion.insert({
    this.id = const Value.absent(),
    required String level,
    required String tag,
    required String message,
    this.stackTrace = const Value.absent(),
    this.extra = const Value.absent(),
    required DateTime createdAt,
  })  : level = Value(level),
        tag = Value(tag),
        message = Value(message),
        createdAt = Value(createdAt);
  static Insertable<AppLog> custom({
    Expression<int>? id,
    Expression<String>? level,
    Expression<String>? tag,
    Expression<String>? message,
    Expression<String>? stackTrace,
    Expression<String>? extra,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (level != null) 'level': level,
      if (tag != null) 'tag': tag,
      if (message != null) 'message': message,
      if (stackTrace != null) 'stack_trace': stackTrace,
      if (extra != null) 'extra': extra,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AppLogsCompanion copyWith(
      {Value<int>? id,
      Value<String>? level,
      Value<String>? tag,
      Value<String>? message,
      Value<String?>? stackTrace,
      Value<String?>? extra,
      Value<DateTime>? createdAt}) {
    return AppLogsCompanion(
      id: id ?? this.id,
      level: level ?? this.level,
      tag: tag ?? this.tag,
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
      extra: extra ?? this.extra,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (stackTrace.present) {
      map['stack_trace'] = Variable<String>(stackTrace.value);
    }
    if (extra.present) {
      map['extra'] = Variable<String>(extra.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppLogsCompanion(')
          ..write('id: $id, ')
          ..write('level: $level, ')
          ..write('tag: $tag, ')
          ..write('message: $message, ')
          ..write('stackTrace: $stackTrace, ')
          ..write('extra: $extra, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BadgesTable extends Badges with TableInfo<$BadgesTable, Badge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BadgesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _triggerTypeMeta =
      const VerificationMeta('triggerType');
  @override
  late final GeneratedColumn<String> triggerType = GeneratedColumn<String>(
      'trigger_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _triggerThresholdMeta =
      const VerificationMeta('triggerThreshold');
  @override
  late final GeneratedColumn<int> triggerThreshold = GeneratedColumn<int>(
      'trigger_threshold', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _triggerConfigMeta =
      const VerificationMeta('triggerConfig');
  @override
  late final GeneratedColumn<String> triggerConfig = GeneratedColumn<String>(
      'trigger_config', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bonusPointsMeta =
      const VerificationMeta('bonusPoints');
  @override
  late final GeneratedColumn<int> bonusPoints = GeneratedColumn<int>(
      'bonus_points', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isSystemMeta =
      const VerificationMeta('isSystem');
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
      'is_system', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_system" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        icon,
        level,
        triggerType,
        triggerThreshold,
        triggerConfig,
        bonusPoints,
        sortOrder,
        isActive,
        isSystem,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'badges';
  @override
  VerificationContext validateIntegrity(Insertable<Badge> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('trigger_type')) {
      context.handle(
          _triggerTypeMeta,
          triggerType.isAcceptableOrUnknown(
              data['trigger_type']!, _triggerTypeMeta));
    } else if (isInserting) {
      context.missing(_triggerTypeMeta);
    }
    if (data.containsKey('trigger_threshold')) {
      context.handle(
          _triggerThresholdMeta,
          triggerThreshold.isAcceptableOrUnknown(
              data['trigger_threshold']!, _triggerThresholdMeta));
    } else if (isInserting) {
      context.missing(_triggerThresholdMeta);
    }
    if (data.containsKey('trigger_config')) {
      context.handle(
          _triggerConfigMeta,
          triggerConfig.isAcceptableOrUnknown(
              data['trigger_config']!, _triggerConfigMeta));
    }
    if (data.containsKey('bonus_points')) {
      context.handle(
          _bonusPointsMeta,
          bonusPoints.isAcceptableOrUnknown(
              data['bonus_points']!, _bonusPointsMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('is_system')) {
      context.handle(_isSystemMeta,
          isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Badge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Badge(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      triggerType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}trigger_type'])!,
      triggerThreshold: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trigger_threshold'])!,
      triggerConfig: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}trigger_config']),
      bonusPoints: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bonus_points'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      isSystem: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_system'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $BadgesTable createAlias(String alias) {
    return $BadgesTable(attachedDatabase, alias);
  }
}

class Badge extends DataClass implements Insertable<Badge> {
  final int id;
  final String name;
  final String? description;
  final String icon;
  final int level;
  final String triggerType;
  final int triggerThreshold;
  final String? triggerConfig;
  final int bonusPoints;
  final int sortOrder;
  final bool isActive;
  final bool isSystem;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Badge(
      {required this.id,
      required this.name,
      this.description,
      required this.icon,
      required this.level,
      required this.triggerType,
      required this.triggerThreshold,
      this.triggerConfig,
      required this.bonusPoints,
      required this.sortOrder,
      required this.isActive,
      required this.isSystem,
      required this.isDeleted,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['icon'] = Variable<String>(icon);
    map['level'] = Variable<int>(level);
    map['trigger_type'] = Variable<String>(triggerType);
    map['trigger_threshold'] = Variable<int>(triggerThreshold);
    if (!nullToAbsent || triggerConfig != null) {
      map['trigger_config'] = Variable<String>(triggerConfig);
    }
    map['bonus_points'] = Variable<int>(bonusPoints);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    map['is_system'] = Variable<bool>(isSystem);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  BadgesCompanion toCompanion(bool nullToAbsent) {
    return BadgesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      icon: Value(icon),
      level: Value(level),
      triggerType: Value(triggerType),
      triggerThreshold: Value(triggerThreshold),
      triggerConfig: triggerConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(triggerConfig),
      bonusPoints: Value(bonusPoints),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
      isSystem: Value(isSystem),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Badge.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Badge(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      icon: serializer.fromJson<String>(json['icon']),
      level: serializer.fromJson<int>(json['level']),
      triggerType: serializer.fromJson<String>(json['triggerType']),
      triggerThreshold: serializer.fromJson<int>(json['triggerThreshold']),
      triggerConfig: serializer.fromJson<String?>(json['triggerConfig']),
      bonusPoints: serializer.fromJson<int>(json['bonusPoints']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'icon': serializer.toJson<String>(icon),
      'level': serializer.toJson<int>(level),
      'triggerType': serializer.toJson<String>(triggerType),
      'triggerThreshold': serializer.toJson<int>(triggerThreshold),
      'triggerConfig': serializer.toJson<String?>(triggerConfig),
      'bonusPoints': serializer.toJson<int>(bonusPoints),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
      'isSystem': serializer.toJson<bool>(isSystem),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Badge copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          String? icon,
          int? level,
          String? triggerType,
          int? triggerThreshold,
          Value<String?> triggerConfig = const Value.absent(),
          int? bonusPoints,
          int? sortOrder,
          bool? isActive,
          bool? isSystem,
          bool? isDeleted,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Badge(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        icon: icon ?? this.icon,
        level: level ?? this.level,
        triggerType: triggerType ?? this.triggerType,
        triggerThreshold: triggerThreshold ?? this.triggerThreshold,
        triggerConfig:
            triggerConfig.present ? triggerConfig.value : this.triggerConfig,
        bonusPoints: bonusPoints ?? this.bonusPoints,
        sortOrder: sortOrder ?? this.sortOrder,
        isActive: isActive ?? this.isActive,
        isSystem: isSystem ?? this.isSystem,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Badge copyWithCompanion(BadgesCompanion data) {
    return Badge(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      level: data.level.present ? data.level.value : this.level,
      triggerType:
          data.triggerType.present ? data.triggerType.value : this.triggerType,
      triggerThreshold: data.triggerThreshold.present
          ? data.triggerThreshold.value
          : this.triggerThreshold,
      triggerConfig: data.triggerConfig.present
          ? data.triggerConfig.value
          : this.triggerConfig,
      bonusPoints:
          data.bonusPoints.present ? data.bonusPoints.value : this.bonusPoints,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Badge(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('level: $level, ')
          ..write('triggerType: $triggerType, ')
          ..write('triggerThreshold: $triggerThreshold, ')
          ..write('triggerConfig: $triggerConfig, ')
          ..write('bonusPoints: $bonusPoints, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('isSystem: $isSystem, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      description,
      icon,
      level,
      triggerType,
      triggerThreshold,
      triggerConfig,
      bonusPoints,
      sortOrder,
      isActive,
      isSystem,
      isDeleted,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Badge &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.level == this.level &&
          other.triggerType == this.triggerType &&
          other.triggerThreshold == this.triggerThreshold &&
          other.triggerConfig == this.triggerConfig &&
          other.bonusPoints == this.bonusPoints &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive &&
          other.isSystem == this.isSystem &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BadgesCompanion extends UpdateCompanion<Badge> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> icon;
  final Value<int> level;
  final Value<String> triggerType;
  final Value<int> triggerThreshold;
  final Value<String?> triggerConfig;
  final Value<int> bonusPoints;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<bool> isSystem;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const BadgesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.level = const Value.absent(),
    this.triggerType = const Value.absent(),
    this.triggerThreshold = const Value.absent(),
    this.triggerConfig = const Value.absent(),
    this.bonusPoints = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BadgesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required String icon,
    this.level = const Value.absent(),
    required String triggerType,
    required int triggerThreshold,
    this.triggerConfig = const Value.absent(),
    this.bonusPoints = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : name = Value(name),
        icon = Value(icon),
        triggerType = Value(triggerType),
        triggerThreshold = Value(triggerThreshold),
        createdAt = Value(createdAt);
  static Insertable<Badge> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<int>? level,
    Expression<String>? triggerType,
    Expression<int>? triggerThreshold,
    Expression<String>? triggerConfig,
    Expression<int>? bonusPoints,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<bool>? isSystem,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (level != null) 'level': level,
      if (triggerType != null) 'trigger_type': triggerType,
      if (triggerThreshold != null) 'trigger_threshold': triggerThreshold,
      if (triggerConfig != null) 'trigger_config': triggerConfig,
      if (bonusPoints != null) 'bonus_points': bonusPoints,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (isSystem != null) 'is_system': isSystem,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BadgesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String>? icon,
      Value<int>? level,
      Value<String>? triggerType,
      Value<int>? triggerThreshold,
      Value<String?>? triggerConfig,
      Value<int>? bonusPoints,
      Value<int>? sortOrder,
      Value<bool>? isActive,
      Value<bool>? isSystem,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return BadgesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      level: level ?? this.level,
      triggerType: triggerType ?? this.triggerType,
      triggerThreshold: triggerThreshold ?? this.triggerThreshold,
      triggerConfig: triggerConfig ?? this.triggerConfig,
      bonusPoints: bonusPoints ?? this.bonusPoints,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      isSystem: isSystem ?? this.isSystem,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (triggerType.present) {
      map['trigger_type'] = Variable<String>(triggerType.value);
    }
    if (triggerThreshold.present) {
      map['trigger_threshold'] = Variable<int>(triggerThreshold.value);
    }
    if (triggerConfig.present) {
      map['trigger_config'] = Variable<String>(triggerConfig.value);
    }
    if (bonusPoints.present) {
      map['bonus_points'] = Variable<int>(bonusPoints.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BadgesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('level: $level, ')
          ..write('triggerType: $triggerType, ')
          ..write('triggerThreshold: $triggerThreshold, ')
          ..write('triggerConfig: $triggerConfig, ')
          ..write('bonusPoints: $bonusPoints, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('isSystem: $isSystem, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BadgeAcquisitionsTable extends BadgeAcquisitions
    with TableInfo<$BadgeAcquisitionsTable, BadgeAcquisition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BadgeAcquisitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int> childId = GeneratedColumn<int>(
      'child_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES children (id)'));
  static const VerificationMeta _badgeIdMeta =
      const VerificationMeta('badgeId');
  @override
  late final GeneratedColumn<int> badgeId = GeneratedColumn<int>(
      'badge_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES badges (id)'));
  static const VerificationMeta _badgeSnapshotMeta =
      const VerificationMeta('badgeSnapshot');
  @override
  late final GeneratedColumn<String> badgeSnapshot = GeneratedColumn<String>(
      'badge_snapshot', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bonusPointsAwardedMeta =
      const VerificationMeta('bonusPointsAwarded');
  @override
  late final GeneratedColumn<int> bonusPointsAwarded = GeneratedColumn<int>(
      'bonus_points_awarded', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pointRecordIdMeta =
      const VerificationMeta('pointRecordId');
  @override
  late final GeneratedColumn<int> pointRecordId = GeneratedColumn<int>(
      'point_record_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _triggerValueMeta =
      const VerificationMeta('triggerValue');
  @override
  late final GeneratedColumn<int> triggerValue = GeneratedColumn<int>(
      'trigger_value', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        badgeId,
        badgeSnapshot,
        bonusPointsAwarded,
        pointRecordId,
        triggerValue,
        note,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'badge_acquisitions';
  @override
  VerificationContext validateIntegrity(Insertable<BadgeAcquisition> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('badge_id')) {
      context.handle(_badgeIdMeta,
          badgeId.isAcceptableOrUnknown(data['badge_id']!, _badgeIdMeta));
    } else if (isInserting) {
      context.missing(_badgeIdMeta);
    }
    if (data.containsKey('badge_snapshot')) {
      context.handle(
          _badgeSnapshotMeta,
          badgeSnapshot.isAcceptableOrUnknown(
              data['badge_snapshot']!, _badgeSnapshotMeta));
    } else if (isInserting) {
      context.missing(_badgeSnapshotMeta);
    }
    if (data.containsKey('bonus_points_awarded')) {
      context.handle(
          _bonusPointsAwardedMeta,
          bonusPointsAwarded.isAcceptableOrUnknown(
              data['bonus_points_awarded']!, _bonusPointsAwardedMeta));
    } else if (isInserting) {
      context.missing(_bonusPointsAwardedMeta);
    }
    if (data.containsKey('point_record_id')) {
      context.handle(
          _pointRecordIdMeta,
          pointRecordId.isAcceptableOrUnknown(
              data['point_record_id']!, _pointRecordIdMeta));
    }
    if (data.containsKey('trigger_value')) {
      context.handle(
          _triggerValueMeta,
          triggerValue.isAcceptableOrUnknown(
              data['trigger_value']!, _triggerValueMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BadgeAcquisition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BadgeAcquisition(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_id'])!,
      badgeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}badge_id'])!,
      badgeSnapshot: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}badge_snapshot'])!,
      bonusPointsAwarded: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}bonus_points_awarded'])!,
      pointRecordId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}point_record_id']),
      triggerValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trigger_value']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $BadgeAcquisitionsTable createAlias(String alias) {
    return $BadgeAcquisitionsTable(attachedDatabase, alias);
  }
}

class BadgeAcquisition extends DataClass
    implements Insertable<BadgeAcquisition> {
  final int id;
  final int childId;
  final int badgeId;
  final String badgeSnapshot;
  final int bonusPointsAwarded;
  final int? pointRecordId;
  final int? triggerValue;
  final String? note;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const BadgeAcquisition(
      {required this.id,
      required this.childId,
      required this.badgeId,
      required this.badgeSnapshot,
      required this.bonusPointsAwarded,
      this.pointRecordId,
      this.triggerValue,
      this.note,
      required this.isDeleted,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['child_id'] = Variable<int>(childId);
    map['badge_id'] = Variable<int>(badgeId);
    map['badge_snapshot'] = Variable<String>(badgeSnapshot);
    map['bonus_points_awarded'] = Variable<int>(bonusPointsAwarded);
    if (!nullToAbsent || pointRecordId != null) {
      map['point_record_id'] = Variable<int>(pointRecordId);
    }
    if (!nullToAbsent || triggerValue != null) {
      map['trigger_value'] = Variable<int>(triggerValue);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  BadgeAcquisitionsCompanion toCompanion(bool nullToAbsent) {
    return BadgeAcquisitionsCompanion(
      id: Value(id),
      childId: Value(childId),
      badgeId: Value(badgeId),
      badgeSnapshot: Value(badgeSnapshot),
      bonusPointsAwarded: Value(bonusPointsAwarded),
      pointRecordId: pointRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(pointRecordId),
      triggerValue: triggerValue == null && nullToAbsent
          ? const Value.absent()
          : Value(triggerValue),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory BadgeAcquisition.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BadgeAcquisition(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<int>(json['childId']),
      badgeId: serializer.fromJson<int>(json['badgeId']),
      badgeSnapshot: serializer.fromJson<String>(json['badgeSnapshot']),
      bonusPointsAwarded: serializer.fromJson<int>(json['bonusPointsAwarded']),
      pointRecordId: serializer.fromJson<int?>(json['pointRecordId']),
      triggerValue: serializer.fromJson<int?>(json['triggerValue']),
      note: serializer.fromJson<String?>(json['note']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<int>(childId),
      'badgeId': serializer.toJson<int>(badgeId),
      'badgeSnapshot': serializer.toJson<String>(badgeSnapshot),
      'bonusPointsAwarded': serializer.toJson<int>(bonusPointsAwarded),
      'pointRecordId': serializer.toJson<int?>(pointRecordId),
      'triggerValue': serializer.toJson<int?>(triggerValue),
      'note': serializer.toJson<String?>(note),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  BadgeAcquisition copyWith(
          {int? id,
          int? childId,
          int? badgeId,
          String? badgeSnapshot,
          int? bonusPointsAwarded,
          Value<int?> pointRecordId = const Value.absent(),
          Value<int?> triggerValue = const Value.absent(),
          Value<String?> note = const Value.absent(),
          bool? isDeleted,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      BadgeAcquisition(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        badgeId: badgeId ?? this.badgeId,
        badgeSnapshot: badgeSnapshot ?? this.badgeSnapshot,
        bonusPointsAwarded: bonusPointsAwarded ?? this.bonusPointsAwarded,
        pointRecordId:
            pointRecordId.present ? pointRecordId.value : this.pointRecordId,
        triggerValue:
            triggerValue.present ? triggerValue.value : this.triggerValue,
        note: note.present ? note.value : this.note,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  BadgeAcquisition copyWithCompanion(BadgeAcquisitionsCompanion data) {
    return BadgeAcquisition(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      badgeId: data.badgeId.present ? data.badgeId.value : this.badgeId,
      badgeSnapshot: data.badgeSnapshot.present
          ? data.badgeSnapshot.value
          : this.badgeSnapshot,
      bonusPointsAwarded: data.bonusPointsAwarded.present
          ? data.bonusPointsAwarded.value
          : this.bonusPointsAwarded,
      pointRecordId: data.pointRecordId.present
          ? data.pointRecordId.value
          : this.pointRecordId,
      triggerValue: data.triggerValue.present
          ? data.triggerValue.value
          : this.triggerValue,
      note: data.note.present ? data.note.value : this.note,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BadgeAcquisition(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('badgeId: $badgeId, ')
          ..write('badgeSnapshot: $badgeSnapshot, ')
          ..write('bonusPointsAwarded: $bonusPointsAwarded, ')
          ..write('pointRecordId: $pointRecordId, ')
          ..write('triggerValue: $triggerValue, ')
          ..write('note: $note, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      badgeId,
      badgeSnapshot,
      bonusPointsAwarded,
      pointRecordId,
      triggerValue,
      note,
      isDeleted,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BadgeAcquisition &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.badgeId == this.badgeId &&
          other.badgeSnapshot == this.badgeSnapshot &&
          other.bonusPointsAwarded == this.bonusPointsAwarded &&
          other.pointRecordId == this.pointRecordId &&
          other.triggerValue == this.triggerValue &&
          other.note == this.note &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BadgeAcquisitionsCompanion extends UpdateCompanion<BadgeAcquisition> {
  final Value<int> id;
  final Value<int> childId;
  final Value<int> badgeId;
  final Value<String> badgeSnapshot;
  final Value<int> bonusPointsAwarded;
  final Value<int?> pointRecordId;
  final Value<int?> triggerValue;
  final Value<String?> note;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const BadgeAcquisitionsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.badgeId = const Value.absent(),
    this.badgeSnapshot = const Value.absent(),
    this.bonusPointsAwarded = const Value.absent(),
    this.pointRecordId = const Value.absent(),
    this.triggerValue = const Value.absent(),
    this.note = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BadgeAcquisitionsCompanion.insert({
    this.id = const Value.absent(),
    required int childId,
    required int badgeId,
    required String badgeSnapshot,
    required int bonusPointsAwarded,
    this.pointRecordId = const Value.absent(),
    this.triggerValue = const Value.absent(),
    this.note = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : childId = Value(childId),
        badgeId = Value(badgeId),
        badgeSnapshot = Value(badgeSnapshot),
        bonusPointsAwarded = Value(bonusPointsAwarded),
        createdAt = Value(createdAt);
  static Insertable<BadgeAcquisition> custom({
    Expression<int>? id,
    Expression<int>? childId,
    Expression<int>? badgeId,
    Expression<String>? badgeSnapshot,
    Expression<int>? bonusPointsAwarded,
    Expression<int>? pointRecordId,
    Expression<int>? triggerValue,
    Expression<String>? note,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (badgeId != null) 'badge_id': badgeId,
      if (badgeSnapshot != null) 'badge_snapshot': badgeSnapshot,
      if (bonusPointsAwarded != null)
        'bonus_points_awarded': bonusPointsAwarded,
      if (pointRecordId != null) 'point_record_id': pointRecordId,
      if (triggerValue != null) 'trigger_value': triggerValue,
      if (note != null) 'note': note,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BadgeAcquisitionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? childId,
      Value<int>? badgeId,
      Value<String>? badgeSnapshot,
      Value<int>? bonusPointsAwarded,
      Value<int?>? pointRecordId,
      Value<int?>? triggerValue,
      Value<String?>? note,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return BadgeAcquisitionsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      badgeId: badgeId ?? this.badgeId,
      badgeSnapshot: badgeSnapshot ?? this.badgeSnapshot,
      bonusPointsAwarded: bonusPointsAwarded ?? this.bonusPointsAwarded,
      pointRecordId: pointRecordId ?? this.pointRecordId,
      triggerValue: triggerValue ?? this.triggerValue,
      note: note ?? this.note,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<int>(childId.value);
    }
    if (badgeId.present) {
      map['badge_id'] = Variable<int>(badgeId.value);
    }
    if (badgeSnapshot.present) {
      map['badge_snapshot'] = Variable<String>(badgeSnapshot.value);
    }
    if (bonusPointsAwarded.present) {
      map['bonus_points_awarded'] = Variable<int>(bonusPointsAwarded.value);
    }
    if (pointRecordId.present) {
      map['point_record_id'] = Variable<int>(pointRecordId.value);
    }
    if (triggerValue.present) {
      map['trigger_value'] = Variable<int>(triggerValue.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BadgeAcquisitionsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('badgeId: $badgeId, ')
          ..write('badgeSnapshot: $badgeSnapshot, ')
          ..write('bonusPointsAwarded: $bonusPointsAwarded, ')
          ..write('pointRecordId: $pointRecordId, ')
          ..write('triggerValue: $triggerValue, ')
          ..write('note: $note, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CheckinRecordsTable extends CheckinRecords
    with TableInfo<$CheckinRecordsTable, CheckinRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckinRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int> childId = GeneratedColumn<int>(
      'child_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES children (id)'));
  static const VerificationMeta _checkinDateMeta =
      const VerificationMeta('checkinDate');
  @override
  late final GeneratedColumn<String> checkinDate = GeneratedColumn<String>(
      'checkin_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _streakDaysMeta =
      const VerificationMeta('streakDays');
  @override
  late final GeneratedColumn<int> streakDays = GeneratedColumn<int>(
      'streak_days', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pointRecordIdMeta =
      const VerificationMeta('pointRecordId');
  @override
  late final GeneratedColumn<int> pointRecordId = GeneratedColumn<int>(
      'point_record_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        checkinDate,
        streakDays,
        pointRecordId,
        isDeleted,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checkin_records';
  @override
  VerificationContext validateIntegrity(Insertable<CheckinRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('checkin_date')) {
      context.handle(
          _checkinDateMeta,
          checkinDate.isAcceptableOrUnknown(
              data['checkin_date']!, _checkinDateMeta));
    } else if (isInserting) {
      context.missing(_checkinDateMeta);
    }
    if (data.containsKey('streak_days')) {
      context.handle(
          _streakDaysMeta,
          streakDays.isAcceptableOrUnknown(
              data['streak_days']!, _streakDaysMeta));
    } else if (isInserting) {
      context.missing(_streakDaysMeta);
    }
    if (data.containsKey('point_record_id')) {
      context.handle(
          _pointRecordIdMeta,
          pointRecordId.isAcceptableOrUnknown(
              data['point_record_id']!, _pointRecordIdMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CheckinRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckinRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_id'])!,
      checkinDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}checkin_date'])!,
      streakDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak_days'])!,
      pointRecordId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}point_record_id']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CheckinRecordsTable createAlias(String alias) {
    return $CheckinRecordsTable(attachedDatabase, alias);
  }
}

class CheckinRecord extends DataClass implements Insertable<CheckinRecord> {
  final int id;
  final int childId;
  final String checkinDate;
  final int streakDays;
  final int? pointRecordId;
  final bool isDeleted;
  final DateTime createdAt;
  const CheckinRecord(
      {required this.id,
      required this.childId,
      required this.checkinDate,
      required this.streakDays,
      this.pointRecordId,
      required this.isDeleted,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['child_id'] = Variable<int>(childId);
    map['checkin_date'] = Variable<String>(checkinDate);
    map['streak_days'] = Variable<int>(streakDays);
    if (!nullToAbsent || pointRecordId != null) {
      map['point_record_id'] = Variable<int>(pointRecordId);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CheckinRecordsCompanion toCompanion(bool nullToAbsent) {
    return CheckinRecordsCompanion(
      id: Value(id),
      childId: Value(childId),
      checkinDate: Value(checkinDate),
      streakDays: Value(streakDays),
      pointRecordId: pointRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(pointRecordId),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
    );
  }

  factory CheckinRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckinRecord(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<int>(json['childId']),
      checkinDate: serializer.fromJson<String>(json['checkinDate']),
      streakDays: serializer.fromJson<int>(json['streakDays']),
      pointRecordId: serializer.fromJson<int?>(json['pointRecordId']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<int>(childId),
      'checkinDate': serializer.toJson<String>(checkinDate),
      'streakDays': serializer.toJson<int>(streakDays),
      'pointRecordId': serializer.toJson<int?>(pointRecordId),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CheckinRecord copyWith(
          {int? id,
          int? childId,
          String? checkinDate,
          int? streakDays,
          Value<int?> pointRecordId = const Value.absent(),
          bool? isDeleted,
          DateTime? createdAt}) =>
      CheckinRecord(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        checkinDate: checkinDate ?? this.checkinDate,
        streakDays: streakDays ?? this.streakDays,
        pointRecordId:
            pointRecordId.present ? pointRecordId.value : this.pointRecordId,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
      );
  CheckinRecord copyWithCompanion(CheckinRecordsCompanion data) {
    return CheckinRecord(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      checkinDate:
          data.checkinDate.present ? data.checkinDate.value : this.checkinDate,
      streakDays:
          data.streakDays.present ? data.streakDays.value : this.streakDays,
      pointRecordId: data.pointRecordId.present
          ? data.pointRecordId.value
          : this.pointRecordId,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CheckinRecord(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('checkinDate: $checkinDate, ')
          ..write('streakDays: $streakDays, ')
          ..write('pointRecordId: $pointRecordId, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, childId, checkinDate, streakDays,
      pointRecordId, isDeleted, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckinRecord &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.checkinDate == this.checkinDate &&
          other.streakDays == this.streakDays &&
          other.pointRecordId == this.pointRecordId &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt);
}

class CheckinRecordsCompanion extends UpdateCompanion<CheckinRecord> {
  final Value<int> id;
  final Value<int> childId;
  final Value<String> checkinDate;
  final Value<int> streakDays;
  final Value<int?> pointRecordId;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  const CheckinRecordsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.checkinDate = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.pointRecordId = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CheckinRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int childId,
    required String checkinDate,
    required int streakDays,
    this.pointRecordId = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime createdAt,
  })  : childId = Value(childId),
        checkinDate = Value(checkinDate),
        streakDays = Value(streakDays),
        createdAt = Value(createdAt);
  static Insertable<CheckinRecord> custom({
    Expression<int>? id,
    Expression<int>? childId,
    Expression<String>? checkinDate,
    Expression<int>? streakDays,
    Expression<int>? pointRecordId,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (checkinDate != null) 'checkin_date': checkinDate,
      if (streakDays != null) 'streak_days': streakDays,
      if (pointRecordId != null) 'point_record_id': pointRecordId,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CheckinRecordsCompanion copyWith(
      {Value<int>? id,
      Value<int>? childId,
      Value<String>? checkinDate,
      Value<int>? streakDays,
      Value<int?>? pointRecordId,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt}) {
    return CheckinRecordsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      checkinDate: checkinDate ?? this.checkinDate,
      streakDays: streakDays ?? this.streakDays,
      pointRecordId: pointRecordId ?? this.pointRecordId,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<int>(childId.value);
    }
    if (checkinDate.present) {
      map['checkin_date'] = Variable<String>(checkinDate.value);
    }
    if (streakDays.present) {
      map['streak_days'] = Variable<int>(streakDays.value);
    }
    if (pointRecordId.present) {
      map['point_record_id'] = Variable<int>(pointRecordId.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckinRecordsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('checkinDate: $checkinDate, ')
          ..write('streakDays: $streakDays, ')
          ..write('pointRecordId: $pointRecordId, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $IdiomsTable extends Idioms with TableInfo<$IdiomsTable, Idiom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IdiomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 12),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _pinyinMeta = const VerificationMeta('pinyin');
  @override
  late final GeneratedColumn<String> pinyin = GeneratedColumn<String>(
      'pinyin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstPinyinNoToneMeta =
      const VerificationMeta('firstPinyinNoTone');
  @override
  late final GeneratedColumn<String> firstPinyinNoTone =
      GeneratedColumn<String>('first_pinyin_no_tone', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _lastPinyinNoToneMeta =
      const VerificationMeta('lastPinyinNoTone');
  @override
  late final GeneratedColumn<String> lastPinyinNoTone = GeneratedColumn<String>(
      'last_pinyin_no_tone', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _firstPinyinMeta =
      const VerificationMeta('firstPinyin');
  @override
  late final GeneratedColumn<String> firstPinyin = GeneratedColumn<String>(
      'first_pinyin', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _lastPinyinMeta =
      const VerificationMeta('lastPinyin');
  @override
  late final GeneratedColumn<String> lastPinyin = GeneratedColumn<String>(
      'last_pinyin', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _firstCharMeta =
      const VerificationMeta('firstChar');
  @override
  late final GeneratedColumn<String> firstChar = GeneratedColumn<String>(
      'first_char', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lastCharMeta =
      const VerificationMeta('lastChar');
  @override
  late final GeneratedColumn<String> lastChar = GeneratedColumn<String>(
      'last_char', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _explanationMeta =
      const VerificationMeta('explanation');
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
      'explanation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _exampleMeta =
      const VerificationMeta('example');
  @override
  late final GeneratedColumn<String> example = GeneratedColumn<String>(
      'example', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _gradeLevelMeta =
      const VerificationMeta('gradeLevel');
  @override
  late final GeneratedColumn<int> gradeLevel = GeneratedColumn<int>(
      'grade_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<int> frequency = GeneratedColumn<int>(
      'frequency', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(50));
  static const VerificationMeta _isRareMeta = const VerificationMeta('isRare');
  @override
  late final GeneratedColumn<bool> isRare = GeneratedColumn<bool>(
      'is_rare', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_rare" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        word,
        pinyin,
        firstPinyinNoTone,
        lastPinyinNoTone,
        firstPinyin,
        lastPinyin,
        firstChar,
        lastChar,
        explanation,
        source,
        example,
        gradeLevel,
        frequency,
        isRare,
        isDeleted,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'idioms';
  @override
  VerificationContext validateIntegrity(Insertable<Idiom> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('pinyin')) {
      context.handle(_pinyinMeta,
          pinyin.isAcceptableOrUnknown(data['pinyin']!, _pinyinMeta));
    } else if (isInserting) {
      context.missing(_pinyinMeta);
    }
    if (data.containsKey('first_pinyin_no_tone')) {
      context.handle(
          _firstPinyinNoToneMeta,
          firstPinyinNoTone.isAcceptableOrUnknown(
              data['first_pinyin_no_tone']!, _firstPinyinNoToneMeta));
    } else if (isInserting) {
      context.missing(_firstPinyinNoToneMeta);
    }
    if (data.containsKey('last_pinyin_no_tone')) {
      context.handle(
          _lastPinyinNoToneMeta,
          lastPinyinNoTone.isAcceptableOrUnknown(
              data['last_pinyin_no_tone']!, _lastPinyinNoToneMeta));
    } else if (isInserting) {
      context.missing(_lastPinyinNoToneMeta);
    }
    if (data.containsKey('first_pinyin')) {
      context.handle(
          _firstPinyinMeta,
          firstPinyin.isAcceptableOrUnknown(
              data['first_pinyin']!, _firstPinyinMeta));
    }
    if (data.containsKey('last_pinyin')) {
      context.handle(
          _lastPinyinMeta,
          lastPinyin.isAcceptableOrUnknown(
              data['last_pinyin']!, _lastPinyinMeta));
    }
    if (data.containsKey('first_char')) {
      context.handle(_firstCharMeta,
          firstChar.isAcceptableOrUnknown(data['first_char']!, _firstCharMeta));
    } else if (isInserting) {
      context.missing(_firstCharMeta);
    }
    if (data.containsKey('last_char')) {
      context.handle(_lastCharMeta,
          lastChar.isAcceptableOrUnknown(data['last_char']!, _lastCharMeta));
    } else if (isInserting) {
      context.missing(_lastCharMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(
          _explanationMeta,
          explanation.isAcceptableOrUnknown(
              data['explanation']!, _explanationMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('example')) {
      context.handle(_exampleMeta,
          example.isAcceptableOrUnknown(data['example']!, _exampleMeta));
    }
    if (data.containsKey('grade_level')) {
      context.handle(
          _gradeLevelMeta,
          gradeLevel.isAcceptableOrUnknown(
              data['grade_level']!, _gradeLevelMeta));
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    }
    if (data.containsKey('is_rare')) {
      context.handle(_isRareMeta,
          isRare.isAcceptableOrUnknown(data['is_rare']!, _isRareMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {word},
      ];
  @override
  Idiom map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Idiom(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      pinyin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pinyin'])!,
      firstPinyinNoTone: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}first_pinyin_no_tone'])!,
      lastPinyinNoTone: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_pinyin_no_tone'])!,
      firstPinyin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_pinyin'])!,
      lastPinyin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_pinyin'])!,
      firstChar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_char'])!,
      lastChar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_char'])!,
      explanation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explanation']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source']),
      example: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}example']),
      gradeLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}grade_level'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}frequency'])!,
      isRare: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_rare'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $IdiomsTable createAlias(String alias) {
    return $IdiomsTable(attachedDatabase, alias);
  }
}

class Idiom extends DataClass implements Insertable<Idiom> {
  final int id;
  final String word;
  final String pinyin;
  final String firstPinyinNoTone;
  final String lastPinyinNoTone;
  final String firstPinyin;
  final String lastPinyin;
  final String firstChar;
  final String lastChar;
  final String? explanation;
  final String? source;
  final String? example;
  final int gradeLevel;
  final int frequency;
  final bool isRare;
  final bool isDeleted;
  final DateTime createdAt;
  const Idiom(
      {required this.id,
      required this.word,
      required this.pinyin,
      required this.firstPinyinNoTone,
      required this.lastPinyinNoTone,
      required this.firstPinyin,
      required this.lastPinyin,
      required this.firstChar,
      required this.lastChar,
      this.explanation,
      this.source,
      this.example,
      required this.gradeLevel,
      required this.frequency,
      required this.isRare,
      required this.isDeleted,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    map['pinyin'] = Variable<String>(pinyin);
    map['first_pinyin_no_tone'] = Variable<String>(firstPinyinNoTone);
    map['last_pinyin_no_tone'] = Variable<String>(lastPinyinNoTone);
    map['first_pinyin'] = Variable<String>(firstPinyin);
    map['last_pinyin'] = Variable<String>(lastPinyin);
    map['first_char'] = Variable<String>(firstChar);
    map['last_char'] = Variable<String>(lastChar);
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || example != null) {
      map['example'] = Variable<String>(example);
    }
    map['grade_level'] = Variable<int>(gradeLevel);
    map['frequency'] = Variable<int>(frequency);
    map['is_rare'] = Variable<bool>(isRare);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  IdiomsCompanion toCompanion(bool nullToAbsent) {
    return IdiomsCompanion(
      id: Value(id),
      word: Value(word),
      pinyin: Value(pinyin),
      firstPinyinNoTone: Value(firstPinyinNoTone),
      lastPinyinNoTone: Value(lastPinyinNoTone),
      firstPinyin: Value(firstPinyin),
      lastPinyin: Value(lastPinyin),
      firstChar: Value(firstChar),
      lastChar: Value(lastChar),
      explanation: explanation == null && nullToAbsent
          ? const Value.absent()
          : Value(explanation),
      source:
          source == null && nullToAbsent ? const Value.absent() : Value(source),
      example: example == null && nullToAbsent
          ? const Value.absent()
          : Value(example),
      gradeLevel: Value(gradeLevel),
      frequency: Value(frequency),
      isRare: Value(isRare),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
    );
  }

  factory Idiom.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Idiom(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      pinyin: serializer.fromJson<String>(json['pinyin']),
      firstPinyinNoTone: serializer.fromJson<String>(json['firstPinyinNoTone']),
      lastPinyinNoTone: serializer.fromJson<String>(json['lastPinyinNoTone']),
      firstPinyin: serializer.fromJson<String>(json['firstPinyin']),
      lastPinyin: serializer.fromJson<String>(json['lastPinyin']),
      firstChar: serializer.fromJson<String>(json['firstChar']),
      lastChar: serializer.fromJson<String>(json['lastChar']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      source: serializer.fromJson<String?>(json['source']),
      example: serializer.fromJson<String?>(json['example']),
      gradeLevel: serializer.fromJson<int>(json['gradeLevel']),
      frequency: serializer.fromJson<int>(json['frequency']),
      isRare: serializer.fromJson<bool>(json['isRare']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'pinyin': serializer.toJson<String>(pinyin),
      'firstPinyinNoTone': serializer.toJson<String>(firstPinyinNoTone),
      'lastPinyinNoTone': serializer.toJson<String>(lastPinyinNoTone),
      'firstPinyin': serializer.toJson<String>(firstPinyin),
      'lastPinyin': serializer.toJson<String>(lastPinyin),
      'firstChar': serializer.toJson<String>(firstChar),
      'lastChar': serializer.toJson<String>(lastChar),
      'explanation': serializer.toJson<String?>(explanation),
      'source': serializer.toJson<String?>(source),
      'example': serializer.toJson<String?>(example),
      'gradeLevel': serializer.toJson<int>(gradeLevel),
      'frequency': serializer.toJson<int>(frequency),
      'isRare': serializer.toJson<bool>(isRare),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Idiom copyWith(
          {int? id,
          String? word,
          String? pinyin,
          String? firstPinyinNoTone,
          String? lastPinyinNoTone,
          String? firstPinyin,
          String? lastPinyin,
          String? firstChar,
          String? lastChar,
          Value<String?> explanation = const Value.absent(),
          Value<String?> source = const Value.absent(),
          Value<String?> example = const Value.absent(),
          int? gradeLevel,
          int? frequency,
          bool? isRare,
          bool? isDeleted,
          DateTime? createdAt}) =>
      Idiom(
        id: id ?? this.id,
        word: word ?? this.word,
        pinyin: pinyin ?? this.pinyin,
        firstPinyinNoTone: firstPinyinNoTone ?? this.firstPinyinNoTone,
        lastPinyinNoTone: lastPinyinNoTone ?? this.lastPinyinNoTone,
        firstPinyin: firstPinyin ?? this.firstPinyin,
        lastPinyin: lastPinyin ?? this.lastPinyin,
        firstChar: firstChar ?? this.firstChar,
        lastChar: lastChar ?? this.lastChar,
        explanation: explanation.present ? explanation.value : this.explanation,
        source: source.present ? source.value : this.source,
        example: example.present ? example.value : this.example,
        gradeLevel: gradeLevel ?? this.gradeLevel,
        frequency: frequency ?? this.frequency,
        isRare: isRare ?? this.isRare,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
      );
  Idiom copyWithCompanion(IdiomsCompanion data) {
    return Idiom(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      pinyin: data.pinyin.present ? data.pinyin.value : this.pinyin,
      firstPinyinNoTone: data.firstPinyinNoTone.present
          ? data.firstPinyinNoTone.value
          : this.firstPinyinNoTone,
      lastPinyinNoTone: data.lastPinyinNoTone.present
          ? data.lastPinyinNoTone.value
          : this.lastPinyinNoTone,
      firstPinyin:
          data.firstPinyin.present ? data.firstPinyin.value : this.firstPinyin,
      lastPinyin:
          data.lastPinyin.present ? data.lastPinyin.value : this.lastPinyin,
      firstChar: data.firstChar.present ? data.firstChar.value : this.firstChar,
      lastChar: data.lastChar.present ? data.lastChar.value : this.lastChar,
      explanation:
          data.explanation.present ? data.explanation.value : this.explanation,
      source: data.source.present ? data.source.value : this.source,
      example: data.example.present ? data.example.value : this.example,
      gradeLevel:
          data.gradeLevel.present ? data.gradeLevel.value : this.gradeLevel,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      isRare: data.isRare.present ? data.isRare.value : this.isRare,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Idiom(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('pinyin: $pinyin, ')
          ..write('firstPinyinNoTone: $firstPinyinNoTone, ')
          ..write('lastPinyinNoTone: $lastPinyinNoTone, ')
          ..write('firstPinyin: $firstPinyin, ')
          ..write('lastPinyin: $lastPinyin, ')
          ..write('firstChar: $firstChar, ')
          ..write('lastChar: $lastChar, ')
          ..write('explanation: $explanation, ')
          ..write('source: $source, ')
          ..write('example: $example, ')
          ..write('gradeLevel: $gradeLevel, ')
          ..write('frequency: $frequency, ')
          ..write('isRare: $isRare, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      word,
      pinyin,
      firstPinyinNoTone,
      lastPinyinNoTone,
      firstPinyin,
      lastPinyin,
      firstChar,
      lastChar,
      explanation,
      source,
      example,
      gradeLevel,
      frequency,
      isRare,
      isDeleted,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Idiom &&
          other.id == this.id &&
          other.word == this.word &&
          other.pinyin == this.pinyin &&
          other.firstPinyinNoTone == this.firstPinyinNoTone &&
          other.lastPinyinNoTone == this.lastPinyinNoTone &&
          other.firstPinyin == this.firstPinyin &&
          other.lastPinyin == this.lastPinyin &&
          other.firstChar == this.firstChar &&
          other.lastChar == this.lastChar &&
          other.explanation == this.explanation &&
          other.source == this.source &&
          other.example == this.example &&
          other.gradeLevel == this.gradeLevel &&
          other.frequency == this.frequency &&
          other.isRare == this.isRare &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt);
}

class IdiomsCompanion extends UpdateCompanion<Idiom> {
  final Value<int> id;
  final Value<String> word;
  final Value<String> pinyin;
  final Value<String> firstPinyinNoTone;
  final Value<String> lastPinyinNoTone;
  final Value<String> firstPinyin;
  final Value<String> lastPinyin;
  final Value<String> firstChar;
  final Value<String> lastChar;
  final Value<String?> explanation;
  final Value<String?> source;
  final Value<String?> example;
  final Value<int> gradeLevel;
  final Value<int> frequency;
  final Value<bool> isRare;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  const IdiomsCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.pinyin = const Value.absent(),
    this.firstPinyinNoTone = const Value.absent(),
    this.lastPinyinNoTone = const Value.absent(),
    this.firstPinyin = const Value.absent(),
    this.lastPinyin = const Value.absent(),
    this.firstChar = const Value.absent(),
    this.lastChar = const Value.absent(),
    this.explanation = const Value.absent(),
    this.source = const Value.absent(),
    this.example = const Value.absent(),
    this.gradeLevel = const Value.absent(),
    this.frequency = const Value.absent(),
    this.isRare = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  IdiomsCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    required String pinyin,
    required String firstPinyinNoTone,
    required String lastPinyinNoTone,
    this.firstPinyin = const Value.absent(),
    this.lastPinyin = const Value.absent(),
    required String firstChar,
    required String lastChar,
    this.explanation = const Value.absent(),
    this.source = const Value.absent(),
    this.example = const Value.absent(),
    this.gradeLevel = const Value.absent(),
    this.frequency = const Value.absent(),
    this.isRare = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime createdAt,
  })  : word = Value(word),
        pinyin = Value(pinyin),
        firstPinyinNoTone = Value(firstPinyinNoTone),
        lastPinyinNoTone = Value(lastPinyinNoTone),
        firstChar = Value(firstChar),
        lastChar = Value(lastChar),
        createdAt = Value(createdAt);
  static Insertable<Idiom> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? pinyin,
    Expression<String>? firstPinyinNoTone,
    Expression<String>? lastPinyinNoTone,
    Expression<String>? firstPinyin,
    Expression<String>? lastPinyin,
    Expression<String>? firstChar,
    Expression<String>? lastChar,
    Expression<String>? explanation,
    Expression<String>? source,
    Expression<String>? example,
    Expression<int>? gradeLevel,
    Expression<int>? frequency,
    Expression<bool>? isRare,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (pinyin != null) 'pinyin': pinyin,
      if (firstPinyinNoTone != null) 'first_pinyin_no_tone': firstPinyinNoTone,
      if (lastPinyinNoTone != null) 'last_pinyin_no_tone': lastPinyinNoTone,
      if (firstPinyin != null) 'first_pinyin': firstPinyin,
      if (lastPinyin != null) 'last_pinyin': lastPinyin,
      if (firstChar != null) 'first_char': firstChar,
      if (lastChar != null) 'last_char': lastChar,
      if (explanation != null) 'explanation': explanation,
      if (source != null) 'source': source,
      if (example != null) 'example': example,
      if (gradeLevel != null) 'grade_level': gradeLevel,
      if (frequency != null) 'frequency': frequency,
      if (isRare != null) 'is_rare': isRare,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  IdiomsCompanion copyWith(
      {Value<int>? id,
      Value<String>? word,
      Value<String>? pinyin,
      Value<String>? firstPinyinNoTone,
      Value<String>? lastPinyinNoTone,
      Value<String>? firstPinyin,
      Value<String>? lastPinyin,
      Value<String>? firstChar,
      Value<String>? lastChar,
      Value<String?>? explanation,
      Value<String?>? source,
      Value<String?>? example,
      Value<int>? gradeLevel,
      Value<int>? frequency,
      Value<bool>? isRare,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt}) {
    return IdiomsCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      pinyin: pinyin ?? this.pinyin,
      firstPinyinNoTone: firstPinyinNoTone ?? this.firstPinyinNoTone,
      lastPinyinNoTone: lastPinyinNoTone ?? this.lastPinyinNoTone,
      firstPinyin: firstPinyin ?? this.firstPinyin,
      lastPinyin: lastPinyin ?? this.lastPinyin,
      firstChar: firstChar ?? this.firstChar,
      lastChar: lastChar ?? this.lastChar,
      explanation: explanation ?? this.explanation,
      source: source ?? this.source,
      example: example ?? this.example,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      frequency: frequency ?? this.frequency,
      isRare: isRare ?? this.isRare,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (pinyin.present) {
      map['pinyin'] = Variable<String>(pinyin.value);
    }
    if (firstPinyinNoTone.present) {
      map['first_pinyin_no_tone'] = Variable<String>(firstPinyinNoTone.value);
    }
    if (lastPinyinNoTone.present) {
      map['last_pinyin_no_tone'] = Variable<String>(lastPinyinNoTone.value);
    }
    if (firstPinyin.present) {
      map['first_pinyin'] = Variable<String>(firstPinyin.value);
    }
    if (lastPinyin.present) {
      map['last_pinyin'] = Variable<String>(lastPinyin.value);
    }
    if (firstChar.present) {
      map['first_char'] = Variable<String>(firstChar.value);
    }
    if (lastChar.present) {
      map['last_char'] = Variable<String>(lastChar.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (example.present) {
      map['example'] = Variable<String>(example.value);
    }
    if (gradeLevel.present) {
      map['grade_level'] = Variable<int>(gradeLevel.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<int>(frequency.value);
    }
    if (isRare.present) {
      map['is_rare'] = Variable<bool>(isRare.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdiomsCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('pinyin: $pinyin, ')
          ..write('firstPinyinNoTone: $firstPinyinNoTone, ')
          ..write('lastPinyinNoTone: $lastPinyinNoTone, ')
          ..write('firstPinyin: $firstPinyin, ')
          ..write('lastPinyin: $lastPinyin, ')
          ..write('firstChar: $firstChar, ')
          ..write('lastChar: $lastChar, ')
          ..write('explanation: $explanation, ')
          ..write('source: $source, ')
          ..write('example: $example, ')
          ..write('gradeLevel: $gradeLevel, ')
          ..write('frequency: $frequency, ')
          ..write('isRare: $isRare, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $IdiomGameSettingsTable extends IdiomGameSettings
    with TableInfo<$IdiomGameSettingsTable, IdiomGameSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IdiomGameSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int> childId = GeneratedColumn<int>(
      'child_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES children (id)'));
  static const VerificationMeta _currentGradeMeta =
      const VerificationMeta('currentGrade');
  @override
  late final GeneratedColumn<int> currentGrade = GeneratedColumn<int>(
      'current_grade', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _customCountdownMeta =
      const VerificationMeta('customCountdown');
  @override
  late final GeneratedColumn<int> customCountdown = GeneratedColumn<int>(
      'custom_countdown', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _customFreeHintsMeta =
      const VerificationMeta('customFreeHints');
  @override
  late final GeneratedColumn<int> customFreeHints = GeneratedColumn<int>(
      'custom_free_hints', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _matchModeMeta =
      const VerificationMeta('matchMode');
  @override
  late final GeneratedColumn<int> matchMode = GeneratedColumn<int>(
      'match_mode', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _soundEnabledMeta =
      const VerificationMeta('soundEnabled');
  @override
  late final GeneratedColumn<bool> soundEnabled = GeneratedColumn<bool>(
      'sound_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sound_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _includeRareIdiomsMeta =
      const VerificationMeta('includeRareIdioms');
  @override
  late final GeneratedColumn<bool> includeRareIdioms = GeneratedColumn<bool>(
      'include_rare_idioms', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("include_rare_idioms" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        currentGrade,
        customCountdown,
        customFreeHints,
        matchMode,
        soundEnabled,
        includeRareIdioms,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'idiom_game_settings';
  @override
  VerificationContext validateIntegrity(Insertable<IdiomGameSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('current_grade')) {
      context.handle(
          _currentGradeMeta,
          currentGrade.isAcceptableOrUnknown(
              data['current_grade']!, _currentGradeMeta));
    }
    if (data.containsKey('custom_countdown')) {
      context.handle(
          _customCountdownMeta,
          customCountdown.isAcceptableOrUnknown(
              data['custom_countdown']!, _customCountdownMeta));
    }
    if (data.containsKey('custom_free_hints')) {
      context.handle(
          _customFreeHintsMeta,
          customFreeHints.isAcceptableOrUnknown(
              data['custom_free_hints']!, _customFreeHintsMeta));
    }
    if (data.containsKey('match_mode')) {
      context.handle(_matchModeMeta,
          matchMode.isAcceptableOrUnknown(data['match_mode']!, _matchModeMeta));
    }
    if (data.containsKey('sound_enabled')) {
      context.handle(
          _soundEnabledMeta,
          soundEnabled.isAcceptableOrUnknown(
              data['sound_enabled']!, _soundEnabledMeta));
    }
    if (data.containsKey('include_rare_idioms')) {
      context.handle(
          _includeRareIdiomsMeta,
          includeRareIdioms.isAcceptableOrUnknown(
              data['include_rare_idioms']!, _includeRareIdiomsMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IdiomGameSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IdiomGameSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_id'])!,
      currentGrade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_grade'])!,
      customCountdown: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}custom_countdown']),
      customFreeHints: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}custom_free_hints']),
      matchMode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}match_mode'])!,
      soundEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sound_enabled'])!,
      includeRareIdioms: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}include_rare_idioms'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $IdiomGameSettingsTable createAlias(String alias) {
    return $IdiomGameSettingsTable(attachedDatabase, alias);
  }
}

class IdiomGameSetting extends DataClass
    implements Insertable<IdiomGameSetting> {
  final int id;
  final int childId;
  final int currentGrade;
  final int? customCountdown;
  final int? customFreeHints;

  /// 接龙匹配模式: 0=正常接龙(首字=尾字), 1=包含尾字, 2=同音接龙(声调一致)
  final int matchMode;
  final bool soundEnabled;
  final bool includeRareIdioms;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const IdiomGameSetting(
      {required this.id,
      required this.childId,
      required this.currentGrade,
      this.customCountdown,
      this.customFreeHints,
      required this.matchMode,
      required this.soundEnabled,
      required this.includeRareIdioms,
      required this.isDeleted,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['child_id'] = Variable<int>(childId);
    map['current_grade'] = Variable<int>(currentGrade);
    if (!nullToAbsent || customCountdown != null) {
      map['custom_countdown'] = Variable<int>(customCountdown);
    }
    if (!nullToAbsent || customFreeHints != null) {
      map['custom_free_hints'] = Variable<int>(customFreeHints);
    }
    map['match_mode'] = Variable<int>(matchMode);
    map['sound_enabled'] = Variable<bool>(soundEnabled);
    map['include_rare_idioms'] = Variable<bool>(includeRareIdioms);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  IdiomGameSettingsCompanion toCompanion(bool nullToAbsent) {
    return IdiomGameSettingsCompanion(
      id: Value(id),
      childId: Value(childId),
      currentGrade: Value(currentGrade),
      customCountdown: customCountdown == null && nullToAbsent
          ? const Value.absent()
          : Value(customCountdown),
      customFreeHints: customFreeHints == null && nullToAbsent
          ? const Value.absent()
          : Value(customFreeHints),
      matchMode: Value(matchMode),
      soundEnabled: Value(soundEnabled),
      includeRareIdioms: Value(includeRareIdioms),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory IdiomGameSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IdiomGameSetting(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<int>(json['childId']),
      currentGrade: serializer.fromJson<int>(json['currentGrade']),
      customCountdown: serializer.fromJson<int?>(json['customCountdown']),
      customFreeHints: serializer.fromJson<int?>(json['customFreeHints']),
      matchMode: serializer.fromJson<int>(json['matchMode']),
      soundEnabled: serializer.fromJson<bool>(json['soundEnabled']),
      includeRareIdioms: serializer.fromJson<bool>(json['includeRareIdioms']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<int>(childId),
      'currentGrade': serializer.toJson<int>(currentGrade),
      'customCountdown': serializer.toJson<int?>(customCountdown),
      'customFreeHints': serializer.toJson<int?>(customFreeHints),
      'matchMode': serializer.toJson<int>(matchMode),
      'soundEnabled': serializer.toJson<bool>(soundEnabled),
      'includeRareIdioms': serializer.toJson<bool>(includeRareIdioms),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  IdiomGameSetting copyWith(
          {int? id,
          int? childId,
          int? currentGrade,
          Value<int?> customCountdown = const Value.absent(),
          Value<int?> customFreeHints = const Value.absent(),
          int? matchMode,
          bool? soundEnabled,
          bool? includeRareIdioms,
          bool? isDeleted,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      IdiomGameSetting(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        currentGrade: currentGrade ?? this.currentGrade,
        customCountdown: customCountdown.present
            ? customCountdown.value
            : this.customCountdown,
        customFreeHints: customFreeHints.present
            ? customFreeHints.value
            : this.customFreeHints,
        matchMode: matchMode ?? this.matchMode,
        soundEnabled: soundEnabled ?? this.soundEnabled,
        includeRareIdioms: includeRareIdioms ?? this.includeRareIdioms,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  IdiomGameSetting copyWithCompanion(IdiomGameSettingsCompanion data) {
    return IdiomGameSetting(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      currentGrade: data.currentGrade.present
          ? data.currentGrade.value
          : this.currentGrade,
      customCountdown: data.customCountdown.present
          ? data.customCountdown.value
          : this.customCountdown,
      customFreeHints: data.customFreeHints.present
          ? data.customFreeHints.value
          : this.customFreeHints,
      matchMode: data.matchMode.present ? data.matchMode.value : this.matchMode,
      soundEnabled: data.soundEnabled.present
          ? data.soundEnabled.value
          : this.soundEnabled,
      includeRareIdioms: data.includeRareIdioms.present
          ? data.includeRareIdioms.value
          : this.includeRareIdioms,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IdiomGameSetting(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('currentGrade: $currentGrade, ')
          ..write('customCountdown: $customCountdown, ')
          ..write('customFreeHints: $customFreeHints, ')
          ..write('matchMode: $matchMode, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('includeRareIdioms: $includeRareIdioms, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      currentGrade,
      customCountdown,
      customFreeHints,
      matchMode,
      soundEnabled,
      includeRareIdioms,
      isDeleted,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IdiomGameSetting &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.currentGrade == this.currentGrade &&
          other.customCountdown == this.customCountdown &&
          other.customFreeHints == this.customFreeHints &&
          other.matchMode == this.matchMode &&
          other.soundEnabled == this.soundEnabled &&
          other.includeRareIdioms == this.includeRareIdioms &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class IdiomGameSettingsCompanion extends UpdateCompanion<IdiomGameSetting> {
  final Value<int> id;
  final Value<int> childId;
  final Value<int> currentGrade;
  final Value<int?> customCountdown;
  final Value<int?> customFreeHints;
  final Value<int> matchMode;
  final Value<bool> soundEnabled;
  final Value<bool> includeRareIdioms;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const IdiomGameSettingsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.currentGrade = const Value.absent(),
    this.customCountdown = const Value.absent(),
    this.customFreeHints = const Value.absent(),
    this.matchMode = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.includeRareIdioms = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  IdiomGameSettingsCompanion.insert({
    this.id = const Value.absent(),
    required int childId,
    this.currentGrade = const Value.absent(),
    this.customCountdown = const Value.absent(),
    this.customFreeHints = const Value.absent(),
    this.matchMode = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.includeRareIdioms = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : childId = Value(childId),
        createdAt = Value(createdAt);
  static Insertable<IdiomGameSetting> custom({
    Expression<int>? id,
    Expression<int>? childId,
    Expression<int>? currentGrade,
    Expression<int>? customCountdown,
    Expression<int>? customFreeHints,
    Expression<int>? matchMode,
    Expression<bool>? soundEnabled,
    Expression<bool>? includeRareIdioms,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (currentGrade != null) 'current_grade': currentGrade,
      if (customCountdown != null) 'custom_countdown': customCountdown,
      if (customFreeHints != null) 'custom_free_hints': customFreeHints,
      if (matchMode != null) 'match_mode': matchMode,
      if (soundEnabled != null) 'sound_enabled': soundEnabled,
      if (includeRareIdioms != null) 'include_rare_idioms': includeRareIdioms,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  IdiomGameSettingsCompanion copyWith(
      {Value<int>? id,
      Value<int>? childId,
      Value<int>? currentGrade,
      Value<int?>? customCountdown,
      Value<int?>? customFreeHints,
      Value<int>? matchMode,
      Value<bool>? soundEnabled,
      Value<bool>? includeRareIdioms,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return IdiomGameSettingsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      currentGrade: currentGrade ?? this.currentGrade,
      customCountdown: customCountdown ?? this.customCountdown,
      customFreeHints: customFreeHints ?? this.customFreeHints,
      matchMode: matchMode ?? this.matchMode,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      includeRareIdioms: includeRareIdioms ?? this.includeRareIdioms,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<int>(childId.value);
    }
    if (currentGrade.present) {
      map['current_grade'] = Variable<int>(currentGrade.value);
    }
    if (customCountdown.present) {
      map['custom_countdown'] = Variable<int>(customCountdown.value);
    }
    if (customFreeHints.present) {
      map['custom_free_hints'] = Variable<int>(customFreeHints.value);
    }
    if (matchMode.present) {
      map['match_mode'] = Variable<int>(matchMode.value);
    }
    if (soundEnabled.present) {
      map['sound_enabled'] = Variable<bool>(soundEnabled.value);
    }
    if (includeRareIdioms.present) {
      map['include_rare_idioms'] = Variable<bool>(includeRareIdioms.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdiomGameSettingsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('currentGrade: $currentGrade, ')
          ..write('customCountdown: $customCountdown, ')
          ..write('customFreeHints: $customFreeHints, ')
          ..write('matchMode: $matchMode, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('includeRareIdioms: $includeRareIdioms, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $IdiomGameRecordsTable extends IdiomGameRecords
    with TableInfo<$IdiomGameRecordsTable, IdiomGameRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IdiomGameRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int> childId = GeneratedColumn<int>(
      'child_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES children (id)'));
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<int> grade = GeneratedColumn<int>(
      'grade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _chainLengthMeta =
      const VerificationMeta('chainLength');
  @override
  late final GeneratedColumn<int> chainLength = GeneratedColumn<int>(
      'chain_length', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _hintsUsedMeta =
      const VerificationMeta('hintsUsed');
  @override
  late final GeneratedColumn<int> hintsUsed = GeneratedColumn<int>(
      'hints_used', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _fastAnswerCountMeta =
      const VerificationMeta('fastAnswerCount');
  @override
  late final GeneratedColumn<int> fastAnswerCount = GeneratedColumn<int>(
      'fast_answer_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _rareIdiomCountMeta =
      const VerificationMeta('rareIdiomCount');
  @override
  late final GeneratedColumn<int> rareIdiomCount = GeneratedColumn<int>(
      'rare_idiom_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _playerTurnsMeta =
      const VerificationMeta('playerTurns');
  @override
  late final GeneratedColumn<int> playerTurns = GeneratedColumn<int>(
      'player_turns', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _timeoutWarningCountMeta =
      const VerificationMeta('timeoutWarningCount');
  @override
  late final GeneratedColumn<int> timeoutWarningCount = GeneratedColumn<int>(
      'timeout_warning_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isAiSurrenderMeta =
      const VerificationMeta('isAiSurrender');
  @override
  late final GeneratedColumn<bool> isAiSurrender = GeneratedColumn<bool>(
      'is_ai_surrender', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_ai_surrender" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _comboMaxMeta =
      const VerificationMeta('comboMax');
  @override
  late final GeneratedColumn<int> comboMax = GeneratedColumn<int>(
      'combo_max', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _starsEarnedMeta =
      const VerificationMeta('starsEarned');
  @override
  late final GeneratedColumn<int> starsEarned = GeneratedColumn<int>(
      'stars_earned', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _starRatingMeta =
      const VerificationMeta('starRating');
  @override
  late final GeneratedColumn<int> starRating = GeneratedColumn<int>(
      'star_rating', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _idiomChainMeta =
      const VerificationMeta('idiomChain');
  @override
  late final GeneratedColumn<String> idiomChain = GeneratedColumn<String>(
      'idiom_chain', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _playedAtMeta =
      const VerificationMeta('playedAt');
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
      'played_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        grade,
        score,
        chainLength,
        duration,
        hintsUsed,
        fastAnswerCount,
        rareIdiomCount,
        playerTurns,
        timeoutWarningCount,
        isAiSurrender,
        comboMax,
        starsEarned,
        starRating,
        idiomChain,
        isDeleted,
        playedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'idiom_game_records';
  @override
  VerificationContext validateIntegrity(Insertable<IdiomGameRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('chain_length')) {
      context.handle(
          _chainLengthMeta,
          chainLength.isAcceptableOrUnknown(
              data['chain_length']!, _chainLengthMeta));
    } else if (isInserting) {
      context.missing(_chainLengthMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('hints_used')) {
      context.handle(_hintsUsedMeta,
          hintsUsed.isAcceptableOrUnknown(data['hints_used']!, _hintsUsedMeta));
    }
    if (data.containsKey('fast_answer_count')) {
      context.handle(
          _fastAnswerCountMeta,
          fastAnswerCount.isAcceptableOrUnknown(
              data['fast_answer_count']!, _fastAnswerCountMeta));
    }
    if (data.containsKey('rare_idiom_count')) {
      context.handle(
          _rareIdiomCountMeta,
          rareIdiomCount.isAcceptableOrUnknown(
              data['rare_idiom_count']!, _rareIdiomCountMeta));
    }
    if (data.containsKey('player_turns')) {
      context.handle(
          _playerTurnsMeta,
          playerTurns.isAcceptableOrUnknown(
              data['player_turns']!, _playerTurnsMeta));
    }
    if (data.containsKey('timeout_warning_count')) {
      context.handle(
          _timeoutWarningCountMeta,
          timeoutWarningCount.isAcceptableOrUnknown(
              data['timeout_warning_count']!, _timeoutWarningCountMeta));
    }
    if (data.containsKey('is_ai_surrender')) {
      context.handle(
          _isAiSurrenderMeta,
          isAiSurrender.isAcceptableOrUnknown(
              data['is_ai_surrender']!, _isAiSurrenderMeta));
    }
    if (data.containsKey('combo_max')) {
      context.handle(_comboMaxMeta,
          comboMax.isAcceptableOrUnknown(data['combo_max']!, _comboMaxMeta));
    }
    if (data.containsKey('stars_earned')) {
      context.handle(
          _starsEarnedMeta,
          starsEarned.isAcceptableOrUnknown(
              data['stars_earned']!, _starsEarnedMeta));
    }
    if (data.containsKey('star_rating')) {
      context.handle(
          _starRatingMeta,
          starRating.isAcceptableOrUnknown(
              data['star_rating']!, _starRatingMeta));
    }
    if (data.containsKey('idiom_chain')) {
      context.handle(
          _idiomChainMeta,
          idiomChain.isAcceptableOrUnknown(
              data['idiom_chain']!, _idiomChainMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('played_at')) {
      context.handle(_playedAtMeta,
          playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta));
    } else if (isInserting) {
      context.missing(_playedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IdiomGameRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IdiomGameRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_id'])!,
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}grade'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score'])!,
      chainLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chain_length'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      hintsUsed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hints_used'])!,
      fastAnswerCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fast_answer_count'])!,
      rareIdiomCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rare_idiom_count'])!,
      playerTurns: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_turns'])!,
      timeoutWarningCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}timeout_warning_count'])!,
      isAiSurrender: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_ai_surrender'])!,
      comboMax: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}combo_max'])!,
      starsEarned: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stars_earned'])!,
      starRating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}star_rating'])!,
      idiomChain: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}idiom_chain']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      playedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}played_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $IdiomGameRecordsTable createAlias(String alias) {
    return $IdiomGameRecordsTable(attachedDatabase, alias);
  }
}

class IdiomGameRecord extends DataClass implements Insertable<IdiomGameRecord> {
  final int id;
  final int childId;
  final int grade;
  final int score;
  final int chainLength;
  final int duration;
  final int hintsUsed;
  final int fastAnswerCount;
  final int rareIdiomCount;
  final int playerTurns;
  final int timeoutWarningCount;
  final bool isAiSurrender;
  final int comboMax;
  final int starsEarned;
  final int starRating;
  final String? idiomChain;
  final bool isDeleted;
  final DateTime playedAt;
  final DateTime createdAt;
  const IdiomGameRecord(
      {required this.id,
      required this.childId,
      required this.grade,
      required this.score,
      required this.chainLength,
      required this.duration,
      required this.hintsUsed,
      required this.fastAnswerCount,
      required this.rareIdiomCount,
      required this.playerTurns,
      required this.timeoutWarningCount,
      required this.isAiSurrender,
      required this.comboMax,
      required this.starsEarned,
      required this.starRating,
      this.idiomChain,
      required this.isDeleted,
      required this.playedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['child_id'] = Variable<int>(childId);
    map['grade'] = Variable<int>(grade);
    map['score'] = Variable<int>(score);
    map['chain_length'] = Variable<int>(chainLength);
    map['duration'] = Variable<int>(duration);
    map['hints_used'] = Variable<int>(hintsUsed);
    map['fast_answer_count'] = Variable<int>(fastAnswerCount);
    map['rare_idiom_count'] = Variable<int>(rareIdiomCount);
    map['player_turns'] = Variable<int>(playerTurns);
    map['timeout_warning_count'] = Variable<int>(timeoutWarningCount);
    map['is_ai_surrender'] = Variable<bool>(isAiSurrender);
    map['combo_max'] = Variable<int>(comboMax);
    map['stars_earned'] = Variable<int>(starsEarned);
    map['star_rating'] = Variable<int>(starRating);
    if (!nullToAbsent || idiomChain != null) {
      map['idiom_chain'] = Variable<String>(idiomChain);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['played_at'] = Variable<DateTime>(playedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  IdiomGameRecordsCompanion toCompanion(bool nullToAbsent) {
    return IdiomGameRecordsCompanion(
      id: Value(id),
      childId: Value(childId),
      grade: Value(grade),
      score: Value(score),
      chainLength: Value(chainLength),
      duration: Value(duration),
      hintsUsed: Value(hintsUsed),
      fastAnswerCount: Value(fastAnswerCount),
      rareIdiomCount: Value(rareIdiomCount),
      playerTurns: Value(playerTurns),
      timeoutWarningCount: Value(timeoutWarningCount),
      isAiSurrender: Value(isAiSurrender),
      comboMax: Value(comboMax),
      starsEarned: Value(starsEarned),
      starRating: Value(starRating),
      idiomChain: idiomChain == null && nullToAbsent
          ? const Value.absent()
          : Value(idiomChain),
      isDeleted: Value(isDeleted),
      playedAt: Value(playedAt),
      createdAt: Value(createdAt),
    );
  }

  factory IdiomGameRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IdiomGameRecord(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<int>(json['childId']),
      grade: serializer.fromJson<int>(json['grade']),
      score: serializer.fromJson<int>(json['score']),
      chainLength: serializer.fromJson<int>(json['chainLength']),
      duration: serializer.fromJson<int>(json['duration']),
      hintsUsed: serializer.fromJson<int>(json['hintsUsed']),
      fastAnswerCount: serializer.fromJson<int>(json['fastAnswerCount']),
      rareIdiomCount: serializer.fromJson<int>(json['rareIdiomCount']),
      playerTurns: serializer.fromJson<int>(json['playerTurns']),
      timeoutWarningCount:
          serializer.fromJson<int>(json['timeoutWarningCount']),
      isAiSurrender: serializer.fromJson<bool>(json['isAiSurrender']),
      comboMax: serializer.fromJson<int>(json['comboMax']),
      starsEarned: serializer.fromJson<int>(json['starsEarned']),
      starRating: serializer.fromJson<int>(json['starRating']),
      idiomChain: serializer.fromJson<String?>(json['idiomChain']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<int>(childId),
      'grade': serializer.toJson<int>(grade),
      'score': serializer.toJson<int>(score),
      'chainLength': serializer.toJson<int>(chainLength),
      'duration': serializer.toJson<int>(duration),
      'hintsUsed': serializer.toJson<int>(hintsUsed),
      'fastAnswerCount': serializer.toJson<int>(fastAnswerCount),
      'rareIdiomCount': serializer.toJson<int>(rareIdiomCount),
      'playerTurns': serializer.toJson<int>(playerTurns),
      'timeoutWarningCount': serializer.toJson<int>(timeoutWarningCount),
      'isAiSurrender': serializer.toJson<bool>(isAiSurrender),
      'comboMax': serializer.toJson<int>(comboMax),
      'starsEarned': serializer.toJson<int>(starsEarned),
      'starRating': serializer.toJson<int>(starRating),
      'idiomChain': serializer.toJson<String?>(idiomChain),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'playedAt': serializer.toJson<DateTime>(playedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  IdiomGameRecord copyWith(
          {int? id,
          int? childId,
          int? grade,
          int? score,
          int? chainLength,
          int? duration,
          int? hintsUsed,
          int? fastAnswerCount,
          int? rareIdiomCount,
          int? playerTurns,
          int? timeoutWarningCount,
          bool? isAiSurrender,
          int? comboMax,
          int? starsEarned,
          int? starRating,
          Value<String?> idiomChain = const Value.absent(),
          bool? isDeleted,
          DateTime? playedAt,
          DateTime? createdAt}) =>
      IdiomGameRecord(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        grade: grade ?? this.grade,
        score: score ?? this.score,
        chainLength: chainLength ?? this.chainLength,
        duration: duration ?? this.duration,
        hintsUsed: hintsUsed ?? this.hintsUsed,
        fastAnswerCount: fastAnswerCount ?? this.fastAnswerCount,
        rareIdiomCount: rareIdiomCount ?? this.rareIdiomCount,
        playerTurns: playerTurns ?? this.playerTurns,
        timeoutWarningCount: timeoutWarningCount ?? this.timeoutWarningCount,
        isAiSurrender: isAiSurrender ?? this.isAiSurrender,
        comboMax: comboMax ?? this.comboMax,
        starsEarned: starsEarned ?? this.starsEarned,
        starRating: starRating ?? this.starRating,
        idiomChain: idiomChain.present ? idiomChain.value : this.idiomChain,
        isDeleted: isDeleted ?? this.isDeleted,
        playedAt: playedAt ?? this.playedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  IdiomGameRecord copyWithCompanion(IdiomGameRecordsCompanion data) {
    return IdiomGameRecord(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      grade: data.grade.present ? data.grade.value : this.grade,
      score: data.score.present ? data.score.value : this.score,
      chainLength:
          data.chainLength.present ? data.chainLength.value : this.chainLength,
      duration: data.duration.present ? data.duration.value : this.duration,
      hintsUsed: data.hintsUsed.present ? data.hintsUsed.value : this.hintsUsed,
      fastAnswerCount: data.fastAnswerCount.present
          ? data.fastAnswerCount.value
          : this.fastAnswerCount,
      rareIdiomCount: data.rareIdiomCount.present
          ? data.rareIdiomCount.value
          : this.rareIdiomCount,
      playerTurns:
          data.playerTurns.present ? data.playerTurns.value : this.playerTurns,
      timeoutWarningCount: data.timeoutWarningCount.present
          ? data.timeoutWarningCount.value
          : this.timeoutWarningCount,
      isAiSurrender: data.isAiSurrender.present
          ? data.isAiSurrender.value
          : this.isAiSurrender,
      comboMax: data.comboMax.present ? data.comboMax.value : this.comboMax,
      starsEarned:
          data.starsEarned.present ? data.starsEarned.value : this.starsEarned,
      starRating:
          data.starRating.present ? data.starRating.value : this.starRating,
      idiomChain:
          data.idiomChain.present ? data.idiomChain.value : this.idiomChain,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IdiomGameRecord(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('grade: $grade, ')
          ..write('score: $score, ')
          ..write('chainLength: $chainLength, ')
          ..write('duration: $duration, ')
          ..write('hintsUsed: $hintsUsed, ')
          ..write('fastAnswerCount: $fastAnswerCount, ')
          ..write('rareIdiomCount: $rareIdiomCount, ')
          ..write('playerTurns: $playerTurns, ')
          ..write('timeoutWarningCount: $timeoutWarningCount, ')
          ..write('isAiSurrender: $isAiSurrender, ')
          ..write('comboMax: $comboMax, ')
          ..write('starsEarned: $starsEarned, ')
          ..write('starRating: $starRating, ')
          ..write('idiomChain: $idiomChain, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('playedAt: $playedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      grade,
      score,
      chainLength,
      duration,
      hintsUsed,
      fastAnswerCount,
      rareIdiomCount,
      playerTurns,
      timeoutWarningCount,
      isAiSurrender,
      comboMax,
      starsEarned,
      starRating,
      idiomChain,
      isDeleted,
      playedAt,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IdiomGameRecord &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.grade == this.grade &&
          other.score == this.score &&
          other.chainLength == this.chainLength &&
          other.duration == this.duration &&
          other.hintsUsed == this.hintsUsed &&
          other.fastAnswerCount == this.fastAnswerCount &&
          other.rareIdiomCount == this.rareIdiomCount &&
          other.playerTurns == this.playerTurns &&
          other.timeoutWarningCount == this.timeoutWarningCount &&
          other.isAiSurrender == this.isAiSurrender &&
          other.comboMax == this.comboMax &&
          other.starsEarned == this.starsEarned &&
          other.starRating == this.starRating &&
          other.idiomChain == this.idiomChain &&
          other.isDeleted == this.isDeleted &&
          other.playedAt == this.playedAt &&
          other.createdAt == this.createdAt);
}

class IdiomGameRecordsCompanion extends UpdateCompanion<IdiomGameRecord> {
  final Value<int> id;
  final Value<int> childId;
  final Value<int> grade;
  final Value<int> score;
  final Value<int> chainLength;
  final Value<int> duration;
  final Value<int> hintsUsed;
  final Value<int> fastAnswerCount;
  final Value<int> rareIdiomCount;
  final Value<int> playerTurns;
  final Value<int> timeoutWarningCount;
  final Value<bool> isAiSurrender;
  final Value<int> comboMax;
  final Value<int> starsEarned;
  final Value<int> starRating;
  final Value<String?> idiomChain;
  final Value<bool> isDeleted;
  final Value<DateTime> playedAt;
  final Value<DateTime> createdAt;
  const IdiomGameRecordsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.grade = const Value.absent(),
    this.score = const Value.absent(),
    this.chainLength = const Value.absent(),
    this.duration = const Value.absent(),
    this.hintsUsed = const Value.absent(),
    this.fastAnswerCount = const Value.absent(),
    this.rareIdiomCount = const Value.absent(),
    this.playerTurns = const Value.absent(),
    this.timeoutWarningCount = const Value.absent(),
    this.isAiSurrender = const Value.absent(),
    this.comboMax = const Value.absent(),
    this.starsEarned = const Value.absent(),
    this.starRating = const Value.absent(),
    this.idiomChain = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.playedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  IdiomGameRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int childId,
    required int grade,
    required int score,
    required int chainLength,
    required int duration,
    this.hintsUsed = const Value.absent(),
    this.fastAnswerCount = const Value.absent(),
    this.rareIdiomCount = const Value.absent(),
    this.playerTurns = const Value.absent(),
    this.timeoutWarningCount = const Value.absent(),
    this.isAiSurrender = const Value.absent(),
    this.comboMax = const Value.absent(),
    this.starsEarned = const Value.absent(),
    this.starRating = const Value.absent(),
    this.idiomChain = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime playedAt,
    required DateTime createdAt,
  })  : childId = Value(childId),
        grade = Value(grade),
        score = Value(score),
        chainLength = Value(chainLength),
        duration = Value(duration),
        playedAt = Value(playedAt),
        createdAt = Value(createdAt);
  static Insertable<IdiomGameRecord> custom({
    Expression<int>? id,
    Expression<int>? childId,
    Expression<int>? grade,
    Expression<int>? score,
    Expression<int>? chainLength,
    Expression<int>? duration,
    Expression<int>? hintsUsed,
    Expression<int>? fastAnswerCount,
    Expression<int>? rareIdiomCount,
    Expression<int>? playerTurns,
    Expression<int>? timeoutWarningCount,
    Expression<bool>? isAiSurrender,
    Expression<int>? comboMax,
    Expression<int>? starsEarned,
    Expression<int>? starRating,
    Expression<String>? idiomChain,
    Expression<bool>? isDeleted,
    Expression<DateTime>? playedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (grade != null) 'grade': grade,
      if (score != null) 'score': score,
      if (chainLength != null) 'chain_length': chainLength,
      if (duration != null) 'duration': duration,
      if (hintsUsed != null) 'hints_used': hintsUsed,
      if (fastAnswerCount != null) 'fast_answer_count': fastAnswerCount,
      if (rareIdiomCount != null) 'rare_idiom_count': rareIdiomCount,
      if (playerTurns != null) 'player_turns': playerTurns,
      if (timeoutWarningCount != null)
        'timeout_warning_count': timeoutWarningCount,
      if (isAiSurrender != null) 'is_ai_surrender': isAiSurrender,
      if (comboMax != null) 'combo_max': comboMax,
      if (starsEarned != null) 'stars_earned': starsEarned,
      if (starRating != null) 'star_rating': starRating,
      if (idiomChain != null) 'idiom_chain': idiomChain,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (playedAt != null) 'played_at': playedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  IdiomGameRecordsCompanion copyWith(
      {Value<int>? id,
      Value<int>? childId,
      Value<int>? grade,
      Value<int>? score,
      Value<int>? chainLength,
      Value<int>? duration,
      Value<int>? hintsUsed,
      Value<int>? fastAnswerCount,
      Value<int>? rareIdiomCount,
      Value<int>? playerTurns,
      Value<int>? timeoutWarningCount,
      Value<bool>? isAiSurrender,
      Value<int>? comboMax,
      Value<int>? starsEarned,
      Value<int>? starRating,
      Value<String?>? idiomChain,
      Value<bool>? isDeleted,
      Value<DateTime>? playedAt,
      Value<DateTime>? createdAt}) {
    return IdiomGameRecordsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      grade: grade ?? this.grade,
      score: score ?? this.score,
      chainLength: chainLength ?? this.chainLength,
      duration: duration ?? this.duration,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      fastAnswerCount: fastAnswerCount ?? this.fastAnswerCount,
      rareIdiomCount: rareIdiomCount ?? this.rareIdiomCount,
      playerTurns: playerTurns ?? this.playerTurns,
      timeoutWarningCount: timeoutWarningCount ?? this.timeoutWarningCount,
      isAiSurrender: isAiSurrender ?? this.isAiSurrender,
      comboMax: comboMax ?? this.comboMax,
      starsEarned: starsEarned ?? this.starsEarned,
      starRating: starRating ?? this.starRating,
      idiomChain: idiomChain ?? this.idiomChain,
      isDeleted: isDeleted ?? this.isDeleted,
      playedAt: playedAt ?? this.playedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<int>(childId.value);
    }
    if (grade.present) {
      map['grade'] = Variable<int>(grade.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (chainLength.present) {
      map['chain_length'] = Variable<int>(chainLength.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (hintsUsed.present) {
      map['hints_used'] = Variable<int>(hintsUsed.value);
    }
    if (fastAnswerCount.present) {
      map['fast_answer_count'] = Variable<int>(fastAnswerCount.value);
    }
    if (rareIdiomCount.present) {
      map['rare_idiom_count'] = Variable<int>(rareIdiomCount.value);
    }
    if (playerTurns.present) {
      map['player_turns'] = Variable<int>(playerTurns.value);
    }
    if (timeoutWarningCount.present) {
      map['timeout_warning_count'] = Variable<int>(timeoutWarningCount.value);
    }
    if (isAiSurrender.present) {
      map['is_ai_surrender'] = Variable<bool>(isAiSurrender.value);
    }
    if (comboMax.present) {
      map['combo_max'] = Variable<int>(comboMax.value);
    }
    if (starsEarned.present) {
      map['stars_earned'] = Variable<int>(starsEarned.value);
    }
    if (starRating.present) {
      map['star_rating'] = Variable<int>(starRating.value);
    }
    if (idiomChain.present) {
      map['idiom_chain'] = Variable<String>(idiomChain.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdiomGameRecordsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('grade: $grade, ')
          ..write('score: $score, ')
          ..write('chainLength: $chainLength, ')
          ..write('duration: $duration, ')
          ..write('hintsUsed: $hintsUsed, ')
          ..write('fastAnswerCount: $fastAnswerCount, ')
          ..write('rareIdiomCount: $rareIdiomCount, ')
          ..write('playerTurns: $playerTurns, ')
          ..write('timeoutWarningCount: $timeoutWarningCount, ')
          ..write('isAiSurrender: $isAiSurrender, ')
          ..write('comboMax: $comboMax, ')
          ..write('starsEarned: $starsEarned, ')
          ..write('starRating: $starRating, ')
          ..write('idiomChain: $idiomChain, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('playedAt: $playedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $IdiomGradeProgressTable extends IdiomGradeProgress
    with TableInfo<$IdiomGradeProgressTable, IdiomGradeProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IdiomGradeProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int> childId = GeneratedColumn<int>(
      'child_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES children (id)'));
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<int> grade = GeneratedColumn<int>(
      'grade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _highScoreMeta =
      const VerificationMeta('highScore');
  @override
  late final GeneratedColumn<int> highScore = GeneratedColumn<int>(
      'high_score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _bestChainLengthMeta =
      const VerificationMeta('bestChainLength');
  @override
  late final GeneratedColumn<int> bestChainLength = GeneratedColumn<int>(
      'best_chain_length', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _starRatingMeta =
      const VerificationMeta('starRating');
  @override
  late final GeneratedColumn<int> starRating = GeneratedColumn<int>(
      'star_rating', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _playCountMeta =
      const VerificationMeta('playCount');
  @override
  late final GeneratedColumn<int> playCount = GeneratedColumn<int>(
      'play_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isUnlockedMeta =
      const VerificationMeta('isUnlocked');
  @override
  late final GeneratedColumn<bool> isUnlocked = GeneratedColumn<bool>(
      'is_unlocked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_unlocked" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        grade,
        highScore,
        bestChainLength,
        starRating,
        playCount,
        isUnlocked,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'idiom_grade_progress';
  @override
  VerificationContext validateIntegrity(
      Insertable<IdiomGradeProgressData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('high_score')) {
      context.handle(_highScoreMeta,
          highScore.isAcceptableOrUnknown(data['high_score']!, _highScoreMeta));
    }
    if (data.containsKey('best_chain_length')) {
      context.handle(
          _bestChainLengthMeta,
          bestChainLength.isAcceptableOrUnknown(
              data['best_chain_length']!, _bestChainLengthMeta));
    }
    if (data.containsKey('star_rating')) {
      context.handle(
          _starRatingMeta,
          starRating.isAcceptableOrUnknown(
              data['star_rating']!, _starRatingMeta));
    }
    if (data.containsKey('play_count')) {
      context.handle(_playCountMeta,
          playCount.isAcceptableOrUnknown(data['play_count']!, _playCountMeta));
    }
    if (data.containsKey('is_unlocked')) {
      context.handle(
          _isUnlockedMeta,
          isUnlocked.isAcceptableOrUnknown(
              data['is_unlocked']!, _isUnlockedMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {childId, grade},
      ];
  @override
  IdiomGradeProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IdiomGradeProgressData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_id'])!,
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}grade'])!,
      highScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}high_score'])!,
      bestChainLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}best_chain_length'])!,
      starRating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}star_rating'])!,
      playCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}play_count'])!,
      isUnlocked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_unlocked'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $IdiomGradeProgressTable createAlias(String alias) {
    return $IdiomGradeProgressTable(attachedDatabase, alias);
  }
}

class IdiomGradeProgressData extends DataClass
    implements Insertable<IdiomGradeProgressData> {
  final int id;
  final int childId;
  final int grade;
  final int highScore;
  final int bestChainLength;
  final int starRating;
  final int playCount;
  final bool isUnlocked;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const IdiomGradeProgressData(
      {required this.id,
      required this.childId,
      required this.grade,
      required this.highScore,
      required this.bestChainLength,
      required this.starRating,
      required this.playCount,
      required this.isUnlocked,
      required this.isDeleted,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['child_id'] = Variable<int>(childId);
    map['grade'] = Variable<int>(grade);
    map['high_score'] = Variable<int>(highScore);
    map['best_chain_length'] = Variable<int>(bestChainLength);
    map['star_rating'] = Variable<int>(starRating);
    map['play_count'] = Variable<int>(playCount);
    map['is_unlocked'] = Variable<bool>(isUnlocked);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  IdiomGradeProgressCompanion toCompanion(bool nullToAbsent) {
    return IdiomGradeProgressCompanion(
      id: Value(id),
      childId: Value(childId),
      grade: Value(grade),
      highScore: Value(highScore),
      bestChainLength: Value(bestChainLength),
      starRating: Value(starRating),
      playCount: Value(playCount),
      isUnlocked: Value(isUnlocked),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory IdiomGradeProgressData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IdiomGradeProgressData(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<int>(json['childId']),
      grade: serializer.fromJson<int>(json['grade']),
      highScore: serializer.fromJson<int>(json['highScore']),
      bestChainLength: serializer.fromJson<int>(json['bestChainLength']),
      starRating: serializer.fromJson<int>(json['starRating']),
      playCount: serializer.fromJson<int>(json['playCount']),
      isUnlocked: serializer.fromJson<bool>(json['isUnlocked']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<int>(childId),
      'grade': serializer.toJson<int>(grade),
      'highScore': serializer.toJson<int>(highScore),
      'bestChainLength': serializer.toJson<int>(bestChainLength),
      'starRating': serializer.toJson<int>(starRating),
      'playCount': serializer.toJson<int>(playCount),
      'isUnlocked': serializer.toJson<bool>(isUnlocked),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  IdiomGradeProgressData copyWith(
          {int? id,
          int? childId,
          int? grade,
          int? highScore,
          int? bestChainLength,
          int? starRating,
          int? playCount,
          bool? isUnlocked,
          bool? isDeleted,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      IdiomGradeProgressData(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        grade: grade ?? this.grade,
        highScore: highScore ?? this.highScore,
        bestChainLength: bestChainLength ?? this.bestChainLength,
        starRating: starRating ?? this.starRating,
        playCount: playCount ?? this.playCount,
        isUnlocked: isUnlocked ?? this.isUnlocked,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  IdiomGradeProgressData copyWithCompanion(IdiomGradeProgressCompanion data) {
    return IdiomGradeProgressData(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      grade: data.grade.present ? data.grade.value : this.grade,
      highScore: data.highScore.present ? data.highScore.value : this.highScore,
      bestChainLength: data.bestChainLength.present
          ? data.bestChainLength.value
          : this.bestChainLength,
      starRating:
          data.starRating.present ? data.starRating.value : this.starRating,
      playCount: data.playCount.present ? data.playCount.value : this.playCount,
      isUnlocked:
          data.isUnlocked.present ? data.isUnlocked.value : this.isUnlocked,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IdiomGradeProgressData(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('grade: $grade, ')
          ..write('highScore: $highScore, ')
          ..write('bestChainLength: $bestChainLength, ')
          ..write('starRating: $starRating, ')
          ..write('playCount: $playCount, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      grade,
      highScore,
      bestChainLength,
      starRating,
      playCount,
      isUnlocked,
      isDeleted,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IdiomGradeProgressData &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.grade == this.grade &&
          other.highScore == this.highScore &&
          other.bestChainLength == this.bestChainLength &&
          other.starRating == this.starRating &&
          other.playCount == this.playCount &&
          other.isUnlocked == this.isUnlocked &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class IdiomGradeProgressCompanion
    extends UpdateCompanion<IdiomGradeProgressData> {
  final Value<int> id;
  final Value<int> childId;
  final Value<int> grade;
  final Value<int> highScore;
  final Value<int> bestChainLength;
  final Value<int> starRating;
  final Value<int> playCount;
  final Value<bool> isUnlocked;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const IdiomGradeProgressCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.grade = const Value.absent(),
    this.highScore = const Value.absent(),
    this.bestChainLength = const Value.absent(),
    this.starRating = const Value.absent(),
    this.playCount = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  IdiomGradeProgressCompanion.insert({
    this.id = const Value.absent(),
    required int childId,
    required int grade,
    this.highScore = const Value.absent(),
    this.bestChainLength = const Value.absent(),
    this.starRating = const Value.absent(),
    this.playCount = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : childId = Value(childId),
        grade = Value(grade),
        createdAt = Value(createdAt);
  static Insertable<IdiomGradeProgressData> custom({
    Expression<int>? id,
    Expression<int>? childId,
    Expression<int>? grade,
    Expression<int>? highScore,
    Expression<int>? bestChainLength,
    Expression<int>? starRating,
    Expression<int>? playCount,
    Expression<bool>? isUnlocked,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (grade != null) 'grade': grade,
      if (highScore != null) 'high_score': highScore,
      if (bestChainLength != null) 'best_chain_length': bestChainLength,
      if (starRating != null) 'star_rating': starRating,
      if (playCount != null) 'play_count': playCount,
      if (isUnlocked != null) 'is_unlocked': isUnlocked,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  IdiomGradeProgressCompanion copyWith(
      {Value<int>? id,
      Value<int>? childId,
      Value<int>? grade,
      Value<int>? highScore,
      Value<int>? bestChainLength,
      Value<int>? starRating,
      Value<int>? playCount,
      Value<bool>? isUnlocked,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return IdiomGradeProgressCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      grade: grade ?? this.grade,
      highScore: highScore ?? this.highScore,
      bestChainLength: bestChainLength ?? this.bestChainLength,
      starRating: starRating ?? this.starRating,
      playCount: playCount ?? this.playCount,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<int>(childId.value);
    }
    if (grade.present) {
      map['grade'] = Variable<int>(grade.value);
    }
    if (highScore.present) {
      map['high_score'] = Variable<int>(highScore.value);
    }
    if (bestChainLength.present) {
      map['best_chain_length'] = Variable<int>(bestChainLength.value);
    }
    if (starRating.present) {
      map['star_rating'] = Variable<int>(starRating.value);
    }
    if (playCount.present) {
      map['play_count'] = Variable<int>(playCount.value);
    }
    if (isUnlocked.present) {
      map['is_unlocked'] = Variable<bool>(isUnlocked.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdiomGradeProgressCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('grade: $grade, ')
          ..write('highScore: $highScore, ')
          ..write('bestChainLength: $bestChainLength, ')
          ..write('starRating: $starRating, ')
          ..write('playCount: $playCount, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $IdiomFailureRecordsTable extends IdiomFailureRecords
    with TableInfo<$IdiomFailureRecordsTable, IdiomFailureRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IdiomFailureRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int> childId = GeneratedColumn<int>(
      'child_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES children (id)'));
  static const VerificationMeta _lastCharMeta =
      const VerificationMeta('lastChar');
  @override
  late final GeneratedColumn<String> lastChar = GeneratedColumn<String>(
      'last_char', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _failCountMeta =
      const VerificationMeta('failCount');
  @override
  late final GeneratedColumn<int> failCount = GeneratedColumn<int>(
      'fail_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _successCountMeta =
      const VerificationMeta('successCount');
  @override
  late final GeneratedColumn<int> successCount = GeneratedColumn<int>(
      'success_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastFailedAtMeta =
      const VerificationMeta('lastFailedAt');
  @override
  late final GeneratedColumn<DateTime> lastFailedAt = GeneratedColumn<DateTime>(
      'last_failed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastSuccessAtMeta =
      const VerificationMeta('lastSuccessAt');
  @override
  late final GeneratedColumn<DateTime> lastSuccessAt =
      GeneratedColumn<DateTime>('last_success_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        lastChar,
        failCount,
        successCount,
        lastFailedAt,
        lastSuccessAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'idiom_failure_records';
  @override
  VerificationContext validateIntegrity(Insertable<IdiomFailureRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('last_char')) {
      context.handle(_lastCharMeta,
          lastChar.isAcceptableOrUnknown(data['last_char']!, _lastCharMeta));
    } else if (isInserting) {
      context.missing(_lastCharMeta);
    }
    if (data.containsKey('fail_count')) {
      context.handle(_failCountMeta,
          failCount.isAcceptableOrUnknown(data['fail_count']!, _failCountMeta));
    }
    if (data.containsKey('success_count')) {
      context.handle(
          _successCountMeta,
          successCount.isAcceptableOrUnknown(
              data['success_count']!, _successCountMeta));
    }
    if (data.containsKey('last_failed_at')) {
      context.handle(
          _lastFailedAtMeta,
          lastFailedAt.isAcceptableOrUnknown(
              data['last_failed_at']!, _lastFailedAtMeta));
    } else if (isInserting) {
      context.missing(_lastFailedAtMeta);
    }
    if (data.containsKey('last_success_at')) {
      context.handle(
          _lastSuccessAtMeta,
          lastSuccessAt.isAcceptableOrUnknown(
              data['last_success_at']!, _lastSuccessAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {childId, lastChar},
      ];
  @override
  IdiomFailureRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IdiomFailureRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_id'])!,
      lastChar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_char'])!,
      failCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fail_count'])!,
      successCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}success_count'])!,
      lastFailedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_failed_at'])!,
      lastSuccessAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_success_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $IdiomFailureRecordsTable createAlias(String alias) {
    return $IdiomFailureRecordsTable(attachedDatabase, alias);
  }
}

class IdiomFailureRecord extends DataClass
    implements Insertable<IdiomFailureRecord> {
  final int id;
  final int childId;
  final String lastChar;
  final int failCount;
  final int successCount;
  final DateTime lastFailedAt;
  final DateTime? lastSuccessAt;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const IdiomFailureRecord(
      {required this.id,
      required this.childId,
      required this.lastChar,
      required this.failCount,
      required this.successCount,
      required this.lastFailedAt,
      this.lastSuccessAt,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['child_id'] = Variable<int>(childId);
    map['last_char'] = Variable<String>(lastChar);
    map['fail_count'] = Variable<int>(failCount);
    map['success_count'] = Variable<int>(successCount);
    map['last_failed_at'] = Variable<DateTime>(lastFailedAt);
    if (!nullToAbsent || lastSuccessAt != null) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  IdiomFailureRecordsCompanion toCompanion(bool nullToAbsent) {
    return IdiomFailureRecordsCompanion(
      id: Value(id),
      childId: Value(childId),
      lastChar: Value(lastChar),
      failCount: Value(failCount),
      successCount: Value(successCount),
      lastFailedAt: Value(lastFailedAt),
      lastSuccessAt: lastSuccessAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSuccessAt),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory IdiomFailureRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IdiomFailureRecord(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<int>(json['childId']),
      lastChar: serializer.fromJson<String>(json['lastChar']),
      failCount: serializer.fromJson<int>(json['failCount']),
      successCount: serializer.fromJson<int>(json['successCount']),
      lastFailedAt: serializer.fromJson<DateTime>(json['lastFailedAt']),
      lastSuccessAt: serializer.fromJson<DateTime?>(json['lastSuccessAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<int>(childId),
      'lastChar': serializer.toJson<String>(lastChar),
      'failCount': serializer.toJson<int>(failCount),
      'successCount': serializer.toJson<int>(successCount),
      'lastFailedAt': serializer.toJson<DateTime>(lastFailedAt),
      'lastSuccessAt': serializer.toJson<DateTime?>(lastSuccessAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  IdiomFailureRecord copyWith(
          {int? id,
          int? childId,
          String? lastChar,
          int? failCount,
          int? successCount,
          DateTime? lastFailedAt,
          Value<DateTime?> lastSuccessAt = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      IdiomFailureRecord(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        lastChar: lastChar ?? this.lastChar,
        failCount: failCount ?? this.failCount,
        successCount: successCount ?? this.successCount,
        lastFailedAt: lastFailedAt ?? this.lastFailedAt,
        lastSuccessAt:
            lastSuccessAt.present ? lastSuccessAt.value : this.lastSuccessAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  IdiomFailureRecord copyWithCompanion(IdiomFailureRecordsCompanion data) {
    return IdiomFailureRecord(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      lastChar: data.lastChar.present ? data.lastChar.value : this.lastChar,
      failCount: data.failCount.present ? data.failCount.value : this.failCount,
      successCount: data.successCount.present
          ? data.successCount.value
          : this.successCount,
      lastFailedAt: data.lastFailedAt.present
          ? data.lastFailedAt.value
          : this.lastFailedAt,
      lastSuccessAt: data.lastSuccessAt.present
          ? data.lastSuccessAt.value
          : this.lastSuccessAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IdiomFailureRecord(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('lastChar: $lastChar, ')
          ..write('failCount: $failCount, ')
          ..write('successCount: $successCount, ')
          ..write('lastFailedAt: $lastFailedAt, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, childId, lastChar, failCount,
      successCount, lastFailedAt, lastSuccessAt, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IdiomFailureRecord &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.lastChar == this.lastChar &&
          other.failCount == this.failCount &&
          other.successCount == this.successCount &&
          other.lastFailedAt == this.lastFailedAt &&
          other.lastSuccessAt == this.lastSuccessAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class IdiomFailureRecordsCompanion extends UpdateCompanion<IdiomFailureRecord> {
  final Value<int> id;
  final Value<int> childId;
  final Value<String> lastChar;
  final Value<int> failCount;
  final Value<int> successCount;
  final Value<DateTime> lastFailedAt;
  final Value<DateTime?> lastSuccessAt;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const IdiomFailureRecordsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.lastChar = const Value.absent(),
    this.failCount = const Value.absent(),
    this.successCount = const Value.absent(),
    this.lastFailedAt = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  IdiomFailureRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int childId,
    required String lastChar,
    this.failCount = const Value.absent(),
    this.successCount = const Value.absent(),
    required DateTime lastFailedAt,
    this.lastSuccessAt = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
  })  : childId = Value(childId),
        lastChar = Value(lastChar),
        lastFailedAt = Value(lastFailedAt),
        createdAt = Value(createdAt);
  static Insertable<IdiomFailureRecord> custom({
    Expression<int>? id,
    Expression<int>? childId,
    Expression<String>? lastChar,
    Expression<int>? failCount,
    Expression<int>? successCount,
    Expression<DateTime>? lastFailedAt,
    Expression<DateTime>? lastSuccessAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (lastChar != null) 'last_char': lastChar,
      if (failCount != null) 'fail_count': failCount,
      if (successCount != null) 'success_count': successCount,
      if (lastFailedAt != null) 'last_failed_at': lastFailedAt,
      if (lastSuccessAt != null) 'last_success_at': lastSuccessAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  IdiomFailureRecordsCompanion copyWith(
      {Value<int>? id,
      Value<int>? childId,
      Value<String>? lastChar,
      Value<int>? failCount,
      Value<int>? successCount,
      Value<DateTime>? lastFailedAt,
      Value<DateTime?>? lastSuccessAt,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return IdiomFailureRecordsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      lastChar: lastChar ?? this.lastChar,
      failCount: failCount ?? this.failCount,
      successCount: successCount ?? this.successCount,
      lastFailedAt: lastFailedAt ?? this.lastFailedAt,
      lastSuccessAt: lastSuccessAt ?? this.lastSuccessAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<int>(childId.value);
    }
    if (lastChar.present) {
      map['last_char'] = Variable<String>(lastChar.value);
    }
    if (failCount.present) {
      map['fail_count'] = Variable<int>(failCount.value);
    }
    if (successCount.present) {
      map['success_count'] = Variable<int>(successCount.value);
    }
    if (lastFailedAt.present) {
      map['last_failed_at'] = Variable<DateTime>(lastFailedAt.value);
    }
    if (lastSuccessAt.present) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdiomFailureRecordsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('lastChar: $lastChar, ')
          ..write('failCount: $failCount, ')
          ..write('successCount: $successCount, ')
          ..write('lastFailedAt: $lastFailedAt, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $IdiomPuzzleRecordsTable extends IdiomPuzzleRecords
    with TableInfo<$IdiomPuzzleRecordsTable, IdiomPuzzleRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IdiomPuzzleRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int> childId = GeneratedColumn<int>(
      'child_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES children (id)'));
  static const VerificationMeta _gameModeMeta =
      const VerificationMeta('gameMode');
  @override
  late final GeneratedColumn<String> gameMode = GeneratedColumn<String>(
      'game_mode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<int> grade = GeneratedColumn<int>(
      'grade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _correctCountMeta =
      const VerificationMeta('correctCount');
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
      'correct_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalCountMeta =
      const VerificationMeta('totalCount');
  @override
  late final GeneratedColumn<int> totalCount = GeneratedColumn<int>(
      'total_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _starsEarnedMeta =
      const VerificationMeta('starsEarned');
  @override
  late final GeneratedColumn<int> starsEarned = GeneratedColumn<int>(
      'stars_earned', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timeTakenSecondsMeta =
      const VerificationMeta('timeTakenSeconds');
  @override
  late final GeneratedColumn<int> timeTakenSeconds = GeneratedColumn<int>(
      'time_taken_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _playedAtMeta =
      const VerificationMeta('playedAt');
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
      'played_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        gameMode,
        grade,
        correctCount,
        totalCount,
        starsEarned,
        timeTakenSeconds,
        isDeleted,
        playedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'idiom_puzzle_records';
  @override
  VerificationContext validateIntegrity(Insertable<IdiomPuzzleRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('game_mode')) {
      context.handle(_gameModeMeta,
          gameMode.isAcceptableOrUnknown(data['game_mode']!, _gameModeMeta));
    } else if (isInserting) {
      context.missing(_gameModeMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('correct_count')) {
      context.handle(
          _correctCountMeta,
          correctCount.isAcceptableOrUnknown(
              data['correct_count']!, _correctCountMeta));
    } else if (isInserting) {
      context.missing(_correctCountMeta);
    }
    if (data.containsKey('total_count')) {
      context.handle(
          _totalCountMeta,
          totalCount.isAcceptableOrUnknown(
              data['total_count']!, _totalCountMeta));
    } else if (isInserting) {
      context.missing(_totalCountMeta);
    }
    if (data.containsKey('stars_earned')) {
      context.handle(
          _starsEarnedMeta,
          starsEarned.isAcceptableOrUnknown(
              data['stars_earned']!, _starsEarnedMeta));
    } else if (isInserting) {
      context.missing(_starsEarnedMeta);
    }
    if (data.containsKey('time_taken_seconds')) {
      context.handle(
          _timeTakenSecondsMeta,
          timeTakenSeconds.isAcceptableOrUnknown(
              data['time_taken_seconds']!, _timeTakenSecondsMeta));
    } else if (isInserting) {
      context.missing(_timeTakenSecondsMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('played_at')) {
      context.handle(_playedAtMeta,
          playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta));
    } else if (isInserting) {
      context.missing(_playedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IdiomPuzzleRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IdiomPuzzleRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_id'])!,
      gameMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}game_mode'])!,
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}grade'])!,
      correctCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}correct_count'])!,
      totalCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_count'])!,
      starsEarned: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stars_earned'])!,
      timeTakenSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}time_taken_seconds'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      playedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}played_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $IdiomPuzzleRecordsTable createAlias(String alias) {
    return $IdiomPuzzleRecordsTable(attachedDatabase, alias);
  }
}

class IdiomPuzzleRecord extends DataClass
    implements Insertable<IdiomPuzzleRecord> {
  final int id;
  final int childId;
  final String gameMode;
  final int grade;
  final int correctCount;
  final int totalCount;
  final int starsEarned;
  final int timeTakenSeconds;
  final bool isDeleted;
  final DateTime playedAt;
  final DateTime createdAt;
  const IdiomPuzzleRecord(
      {required this.id,
      required this.childId,
      required this.gameMode,
      required this.grade,
      required this.correctCount,
      required this.totalCount,
      required this.starsEarned,
      required this.timeTakenSeconds,
      required this.isDeleted,
      required this.playedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['child_id'] = Variable<int>(childId);
    map['game_mode'] = Variable<String>(gameMode);
    map['grade'] = Variable<int>(grade);
    map['correct_count'] = Variable<int>(correctCount);
    map['total_count'] = Variable<int>(totalCount);
    map['stars_earned'] = Variable<int>(starsEarned);
    map['time_taken_seconds'] = Variable<int>(timeTakenSeconds);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['played_at'] = Variable<DateTime>(playedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  IdiomPuzzleRecordsCompanion toCompanion(bool nullToAbsent) {
    return IdiomPuzzleRecordsCompanion(
      id: Value(id),
      childId: Value(childId),
      gameMode: Value(gameMode),
      grade: Value(grade),
      correctCount: Value(correctCount),
      totalCount: Value(totalCount),
      starsEarned: Value(starsEarned),
      timeTakenSeconds: Value(timeTakenSeconds),
      isDeleted: Value(isDeleted),
      playedAt: Value(playedAt),
      createdAt: Value(createdAt),
    );
  }

  factory IdiomPuzzleRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IdiomPuzzleRecord(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<int>(json['childId']),
      gameMode: serializer.fromJson<String>(json['gameMode']),
      grade: serializer.fromJson<int>(json['grade']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      totalCount: serializer.fromJson<int>(json['totalCount']),
      starsEarned: serializer.fromJson<int>(json['starsEarned']),
      timeTakenSeconds: serializer.fromJson<int>(json['timeTakenSeconds']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<int>(childId),
      'gameMode': serializer.toJson<String>(gameMode),
      'grade': serializer.toJson<int>(grade),
      'correctCount': serializer.toJson<int>(correctCount),
      'totalCount': serializer.toJson<int>(totalCount),
      'starsEarned': serializer.toJson<int>(starsEarned),
      'timeTakenSeconds': serializer.toJson<int>(timeTakenSeconds),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'playedAt': serializer.toJson<DateTime>(playedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  IdiomPuzzleRecord copyWith(
          {int? id,
          int? childId,
          String? gameMode,
          int? grade,
          int? correctCount,
          int? totalCount,
          int? starsEarned,
          int? timeTakenSeconds,
          bool? isDeleted,
          DateTime? playedAt,
          DateTime? createdAt}) =>
      IdiomPuzzleRecord(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        gameMode: gameMode ?? this.gameMode,
        grade: grade ?? this.grade,
        correctCount: correctCount ?? this.correctCount,
        totalCount: totalCount ?? this.totalCount,
        starsEarned: starsEarned ?? this.starsEarned,
        timeTakenSeconds: timeTakenSeconds ?? this.timeTakenSeconds,
        isDeleted: isDeleted ?? this.isDeleted,
        playedAt: playedAt ?? this.playedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  IdiomPuzzleRecord copyWithCompanion(IdiomPuzzleRecordsCompanion data) {
    return IdiomPuzzleRecord(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      gameMode: data.gameMode.present ? data.gameMode.value : this.gameMode,
      grade: data.grade.present ? data.grade.value : this.grade,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      totalCount:
          data.totalCount.present ? data.totalCount.value : this.totalCount,
      starsEarned:
          data.starsEarned.present ? data.starsEarned.value : this.starsEarned,
      timeTakenSeconds: data.timeTakenSeconds.present
          ? data.timeTakenSeconds.value
          : this.timeTakenSeconds,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IdiomPuzzleRecord(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('gameMode: $gameMode, ')
          ..write('grade: $grade, ')
          ..write('correctCount: $correctCount, ')
          ..write('totalCount: $totalCount, ')
          ..write('starsEarned: $starsEarned, ')
          ..write('timeTakenSeconds: $timeTakenSeconds, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('playedAt: $playedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      gameMode,
      grade,
      correctCount,
      totalCount,
      starsEarned,
      timeTakenSeconds,
      isDeleted,
      playedAt,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IdiomPuzzleRecord &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.gameMode == this.gameMode &&
          other.grade == this.grade &&
          other.correctCount == this.correctCount &&
          other.totalCount == this.totalCount &&
          other.starsEarned == this.starsEarned &&
          other.timeTakenSeconds == this.timeTakenSeconds &&
          other.isDeleted == this.isDeleted &&
          other.playedAt == this.playedAt &&
          other.createdAt == this.createdAt);
}

class IdiomPuzzleRecordsCompanion extends UpdateCompanion<IdiomPuzzleRecord> {
  final Value<int> id;
  final Value<int> childId;
  final Value<String> gameMode;
  final Value<int> grade;
  final Value<int> correctCount;
  final Value<int> totalCount;
  final Value<int> starsEarned;
  final Value<int> timeTakenSeconds;
  final Value<bool> isDeleted;
  final Value<DateTime> playedAt;
  final Value<DateTime> createdAt;
  const IdiomPuzzleRecordsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.gameMode = const Value.absent(),
    this.grade = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.starsEarned = const Value.absent(),
    this.timeTakenSeconds = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.playedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  IdiomPuzzleRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int childId,
    required String gameMode,
    required int grade,
    required int correctCount,
    required int totalCount,
    required int starsEarned,
    required int timeTakenSeconds,
    this.isDeleted = const Value.absent(),
    required DateTime playedAt,
    required DateTime createdAt,
  })  : childId = Value(childId),
        gameMode = Value(gameMode),
        grade = Value(grade),
        correctCount = Value(correctCount),
        totalCount = Value(totalCount),
        starsEarned = Value(starsEarned),
        timeTakenSeconds = Value(timeTakenSeconds),
        playedAt = Value(playedAt),
        createdAt = Value(createdAt);
  static Insertable<IdiomPuzzleRecord> custom({
    Expression<int>? id,
    Expression<int>? childId,
    Expression<String>? gameMode,
    Expression<int>? grade,
    Expression<int>? correctCount,
    Expression<int>? totalCount,
    Expression<int>? starsEarned,
    Expression<int>? timeTakenSeconds,
    Expression<bool>? isDeleted,
    Expression<DateTime>? playedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (gameMode != null) 'game_mode': gameMode,
      if (grade != null) 'grade': grade,
      if (correctCount != null) 'correct_count': correctCount,
      if (totalCount != null) 'total_count': totalCount,
      if (starsEarned != null) 'stars_earned': starsEarned,
      if (timeTakenSeconds != null) 'time_taken_seconds': timeTakenSeconds,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (playedAt != null) 'played_at': playedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  IdiomPuzzleRecordsCompanion copyWith(
      {Value<int>? id,
      Value<int>? childId,
      Value<String>? gameMode,
      Value<int>? grade,
      Value<int>? correctCount,
      Value<int>? totalCount,
      Value<int>? starsEarned,
      Value<int>? timeTakenSeconds,
      Value<bool>? isDeleted,
      Value<DateTime>? playedAt,
      Value<DateTime>? createdAt}) {
    return IdiomPuzzleRecordsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      gameMode: gameMode ?? this.gameMode,
      grade: grade ?? this.grade,
      correctCount: correctCount ?? this.correctCount,
      totalCount: totalCount ?? this.totalCount,
      starsEarned: starsEarned ?? this.starsEarned,
      timeTakenSeconds: timeTakenSeconds ?? this.timeTakenSeconds,
      isDeleted: isDeleted ?? this.isDeleted,
      playedAt: playedAt ?? this.playedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<int>(childId.value);
    }
    if (gameMode.present) {
      map['game_mode'] = Variable<String>(gameMode.value);
    }
    if (grade.present) {
      map['grade'] = Variable<int>(grade.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (totalCount.present) {
      map['total_count'] = Variable<int>(totalCount.value);
    }
    if (starsEarned.present) {
      map['stars_earned'] = Variable<int>(starsEarned.value);
    }
    if (timeTakenSeconds.present) {
      map['time_taken_seconds'] = Variable<int>(timeTakenSeconds.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdiomPuzzleRecordsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('gameMode: $gameMode, ')
          ..write('grade: $grade, ')
          ..write('correctCount: $correctCount, ')
          ..write('totalCount: $totalCount, ')
          ..write('starsEarned: $starsEarned, ')
          ..write('timeTakenSeconds: $timeTakenSeconds, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('playedAt: $playedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $IdiomEngagementRecordsTable extends IdiomEngagementRecords
    with TableInfo<$IdiomEngagementRecordsTable, IdiomEngagementRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IdiomEngagementRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _childIdMeta =
      const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int> childId = GeneratedColumn<int>(
      'child_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES children (id)'));
  static const VerificationMeta _idiomIdMeta =
      const VerificationMeta('idiomId');
  @override
  late final GeneratedColumn<int> idiomId = GeneratedColumn<int>(
      'idiom_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES idioms (id)'));
  static const VerificationMeta _encounterCountMeta =
      const VerificationMeta('encounterCount');
  @override
  late final GeneratedColumn<int> encounterCount = GeneratedColumn<int>(
      'encounter_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _correctCountMeta =
      const VerificationMeta('correctCount');
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
      'correct_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _failCountMeta =
      const VerificationMeta('failCount');
  @override
  late final GeneratedColumn<int> failCount = GeneratedColumn<int>(
      'fail_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastEncounteredAtMeta =
      const VerificationMeta('lastEncounteredAt');
  @override
  late final GeneratedColumn<DateTime> lastEncounteredAt =
      GeneratedColumn<DateTime>('last_encountered_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastWrongAtMeta =
      const VerificationMeta('lastWrongAt');
  @override
  late final GeneratedColumn<DateTime> lastWrongAt = GeneratedColumn<DateTime>(
      'last_wrong_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _masteryLevelMeta =
      const VerificationMeta('masteryLevel');
  @override
  late final GeneratedColumn<int> masteryLevel = GeneratedColumn<int>(
      'mastery_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _consecutiveCorrectMeta =
      const VerificationMeta('consecutiveCorrect');
  @override
  late final GeneratedColumn<int> consecutiveCorrect = GeneratedColumn<int>(
      'consecutive_correct', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        childId,
        idiomId,
        encounterCount,
        correctCount,
        failCount,
        lastEncounteredAt,
        lastWrongAt,
        masteryLevel,
        consecutiveCorrect
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'idiom_engagement_records';
  @override
  VerificationContext validateIntegrity(
      Insertable<IdiomEngagementRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    } else if (isInserting) {
      context.missing(_childIdMeta);
    }
    if (data.containsKey('idiom_id')) {
      context.handle(_idiomIdMeta,
          idiomId.isAcceptableOrUnknown(data['idiom_id']!, _idiomIdMeta));
    } else if (isInserting) {
      context.missing(_idiomIdMeta);
    }
    if (data.containsKey('encounter_count')) {
      context.handle(
          _encounterCountMeta,
          encounterCount.isAcceptableOrUnknown(
              data['encounter_count']!, _encounterCountMeta));
    }
    if (data.containsKey('correct_count')) {
      context.handle(
          _correctCountMeta,
          correctCount.isAcceptableOrUnknown(
              data['correct_count']!, _correctCountMeta));
    }
    if (data.containsKey('fail_count')) {
      context.handle(_failCountMeta,
          failCount.isAcceptableOrUnknown(data['fail_count']!, _failCountMeta));
    }
    if (data.containsKey('last_encountered_at')) {
      context.handle(
          _lastEncounteredAtMeta,
          lastEncounteredAt.isAcceptableOrUnknown(
              data['last_encountered_at']!, _lastEncounteredAtMeta));
    } else if (isInserting) {
      context.missing(_lastEncounteredAtMeta);
    }
    if (data.containsKey('last_wrong_at')) {
      context.handle(
          _lastWrongAtMeta,
          lastWrongAt.isAcceptableOrUnknown(
              data['last_wrong_at']!, _lastWrongAtMeta));
    }
    if (data.containsKey('mastery_level')) {
      context.handle(
          _masteryLevelMeta,
          masteryLevel.isAcceptableOrUnknown(
              data['mastery_level']!, _masteryLevelMeta));
    }
    if (data.containsKey('consecutive_correct')) {
      context.handle(
          _consecutiveCorrectMeta,
          consecutiveCorrect.isAcceptableOrUnknown(
              data['consecutive_correct']!, _consecutiveCorrectMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IdiomEngagementRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IdiomEngagementRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      childId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_id'])!,
      idiomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}idiom_id'])!,
      encounterCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}encounter_count'])!,
      correctCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}correct_count'])!,
      failCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fail_count'])!,
      lastEncounteredAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_encountered_at'])!,
      lastWrongAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_wrong_at']),
      masteryLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mastery_level'])!,
      consecutiveCorrect: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}consecutive_correct'])!,
    );
  }

  @override
  $IdiomEngagementRecordsTable createAlias(String alias) {
    return $IdiomEngagementRecordsTable(attachedDatabase, alias);
  }
}

class IdiomEngagementRecord extends DataClass
    implements Insertable<IdiomEngagementRecord> {
  final int id;
  final int childId;
  final int idiomId;
  final int encounterCount;
  final int correctCount;
  final int failCount;
  final DateTime lastEncounteredAt;
  final DateTime? lastWrongAt;
  final int masteryLevel;
  final int consecutiveCorrect;
  const IdiomEngagementRecord(
      {required this.id,
      required this.childId,
      required this.idiomId,
      required this.encounterCount,
      required this.correctCount,
      required this.failCount,
      required this.lastEncounteredAt,
      this.lastWrongAt,
      required this.masteryLevel,
      required this.consecutiveCorrect});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['child_id'] = Variable<int>(childId);
    map['idiom_id'] = Variable<int>(idiomId);
    map['encounter_count'] = Variable<int>(encounterCount);
    map['correct_count'] = Variable<int>(correctCount);
    map['fail_count'] = Variable<int>(failCount);
    map['last_encountered_at'] = Variable<DateTime>(lastEncounteredAt);
    if (!nullToAbsent || lastWrongAt != null) {
      map['last_wrong_at'] = Variable<DateTime>(lastWrongAt);
    }
    map['mastery_level'] = Variable<int>(masteryLevel);
    map['consecutive_correct'] = Variable<int>(consecutiveCorrect);
    return map;
  }

  IdiomEngagementRecordsCompanion toCompanion(bool nullToAbsent) {
    return IdiomEngagementRecordsCompanion(
      id: Value(id),
      childId: Value(childId),
      idiomId: Value(idiomId),
      encounterCount: Value(encounterCount),
      correctCount: Value(correctCount),
      failCount: Value(failCount),
      lastEncounteredAt: Value(lastEncounteredAt),
      lastWrongAt: lastWrongAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastWrongAt),
      masteryLevel: Value(masteryLevel),
      consecutiveCorrect: Value(consecutiveCorrect),
    );
  }

  factory IdiomEngagementRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IdiomEngagementRecord(
      id: serializer.fromJson<int>(json['id']),
      childId: serializer.fromJson<int>(json['childId']),
      idiomId: serializer.fromJson<int>(json['idiomId']),
      encounterCount: serializer.fromJson<int>(json['encounterCount']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      failCount: serializer.fromJson<int>(json['failCount']),
      lastEncounteredAt:
          serializer.fromJson<DateTime>(json['lastEncounteredAt']),
      lastWrongAt: serializer.fromJson<DateTime?>(json['lastWrongAt']),
      masteryLevel: serializer.fromJson<int>(json['masteryLevel']),
      consecutiveCorrect: serializer.fromJson<int>(json['consecutiveCorrect']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'childId': serializer.toJson<int>(childId),
      'idiomId': serializer.toJson<int>(idiomId),
      'encounterCount': serializer.toJson<int>(encounterCount),
      'correctCount': serializer.toJson<int>(correctCount),
      'failCount': serializer.toJson<int>(failCount),
      'lastEncounteredAt': serializer.toJson<DateTime>(lastEncounteredAt),
      'lastWrongAt': serializer.toJson<DateTime?>(lastWrongAt),
      'masteryLevel': serializer.toJson<int>(masteryLevel),
      'consecutiveCorrect': serializer.toJson<int>(consecutiveCorrect),
    };
  }

  IdiomEngagementRecord copyWith(
          {int? id,
          int? childId,
          int? idiomId,
          int? encounterCount,
          int? correctCount,
          int? failCount,
          DateTime? lastEncounteredAt,
          Value<DateTime?> lastWrongAt = const Value.absent(),
          int? masteryLevel,
          int? consecutiveCorrect}) =>
      IdiomEngagementRecord(
        id: id ?? this.id,
        childId: childId ?? this.childId,
        idiomId: idiomId ?? this.idiomId,
        encounterCount: encounterCount ?? this.encounterCount,
        correctCount: correctCount ?? this.correctCount,
        failCount: failCount ?? this.failCount,
        lastEncounteredAt: lastEncounteredAt ?? this.lastEncounteredAt,
        lastWrongAt: lastWrongAt.present ? lastWrongAt.value : this.lastWrongAt,
        masteryLevel: masteryLevel ?? this.masteryLevel,
        consecutiveCorrect: consecutiveCorrect ?? this.consecutiveCorrect,
      );
  IdiomEngagementRecord copyWithCompanion(
      IdiomEngagementRecordsCompanion data) {
    return IdiomEngagementRecord(
      id: data.id.present ? data.id.value : this.id,
      childId: data.childId.present ? data.childId.value : this.childId,
      idiomId: data.idiomId.present ? data.idiomId.value : this.idiomId,
      encounterCount: data.encounterCount.present
          ? data.encounterCount.value
          : this.encounterCount,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      failCount: data.failCount.present ? data.failCount.value : this.failCount,
      lastEncounteredAt: data.lastEncounteredAt.present
          ? data.lastEncounteredAt.value
          : this.lastEncounteredAt,
      lastWrongAt:
          data.lastWrongAt.present ? data.lastWrongAt.value : this.lastWrongAt,
      masteryLevel: data.masteryLevel.present
          ? data.masteryLevel.value
          : this.masteryLevel,
      consecutiveCorrect: data.consecutiveCorrect.present
          ? data.consecutiveCorrect.value
          : this.consecutiveCorrect,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IdiomEngagementRecord(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('idiomId: $idiomId, ')
          ..write('encounterCount: $encounterCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('failCount: $failCount, ')
          ..write('lastEncounteredAt: $lastEncounteredAt, ')
          ..write('lastWrongAt: $lastWrongAt, ')
          ..write('masteryLevel: $masteryLevel, ')
          ..write('consecutiveCorrect: $consecutiveCorrect')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      childId,
      idiomId,
      encounterCount,
      correctCount,
      failCount,
      lastEncounteredAt,
      lastWrongAt,
      masteryLevel,
      consecutiveCorrect);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IdiomEngagementRecord &&
          other.id == this.id &&
          other.childId == this.childId &&
          other.idiomId == this.idiomId &&
          other.encounterCount == this.encounterCount &&
          other.correctCount == this.correctCount &&
          other.failCount == this.failCount &&
          other.lastEncounteredAt == this.lastEncounteredAt &&
          other.lastWrongAt == this.lastWrongAt &&
          other.masteryLevel == this.masteryLevel &&
          other.consecutiveCorrect == this.consecutiveCorrect);
}

class IdiomEngagementRecordsCompanion
    extends UpdateCompanion<IdiomEngagementRecord> {
  final Value<int> id;
  final Value<int> childId;
  final Value<int> idiomId;
  final Value<int> encounterCount;
  final Value<int> correctCount;
  final Value<int> failCount;
  final Value<DateTime> lastEncounteredAt;
  final Value<DateTime?> lastWrongAt;
  final Value<int> masteryLevel;
  final Value<int> consecutiveCorrect;
  const IdiomEngagementRecordsCompanion({
    this.id = const Value.absent(),
    this.childId = const Value.absent(),
    this.idiomId = const Value.absent(),
    this.encounterCount = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.failCount = const Value.absent(),
    this.lastEncounteredAt = const Value.absent(),
    this.lastWrongAt = const Value.absent(),
    this.masteryLevel = const Value.absent(),
    this.consecutiveCorrect = const Value.absent(),
  });
  IdiomEngagementRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int childId,
    required int idiomId,
    this.encounterCount = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.failCount = const Value.absent(),
    required DateTime lastEncounteredAt,
    this.lastWrongAt = const Value.absent(),
    this.masteryLevel = const Value.absent(),
    this.consecutiveCorrect = const Value.absent(),
  })  : childId = Value(childId),
        idiomId = Value(idiomId),
        lastEncounteredAt = Value(lastEncounteredAt);
  static Insertable<IdiomEngagementRecord> custom({
    Expression<int>? id,
    Expression<int>? childId,
    Expression<int>? idiomId,
    Expression<int>? encounterCount,
    Expression<int>? correctCount,
    Expression<int>? failCount,
    Expression<DateTime>? lastEncounteredAt,
    Expression<DateTime>? lastWrongAt,
    Expression<int>? masteryLevel,
    Expression<int>? consecutiveCorrect,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (childId != null) 'child_id': childId,
      if (idiomId != null) 'idiom_id': idiomId,
      if (encounterCount != null) 'encounter_count': encounterCount,
      if (correctCount != null) 'correct_count': correctCount,
      if (failCount != null) 'fail_count': failCount,
      if (lastEncounteredAt != null) 'last_encountered_at': lastEncounteredAt,
      if (lastWrongAt != null) 'last_wrong_at': lastWrongAt,
      if (masteryLevel != null) 'mastery_level': masteryLevel,
      if (consecutiveCorrect != null) 'consecutive_correct': consecutiveCorrect,
    });
  }

  IdiomEngagementRecordsCompanion copyWith(
      {Value<int>? id,
      Value<int>? childId,
      Value<int>? idiomId,
      Value<int>? encounterCount,
      Value<int>? correctCount,
      Value<int>? failCount,
      Value<DateTime>? lastEncounteredAt,
      Value<DateTime?>? lastWrongAt,
      Value<int>? masteryLevel,
      Value<int>? consecutiveCorrect}) {
    return IdiomEngagementRecordsCompanion(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      idiomId: idiomId ?? this.idiomId,
      encounterCount: encounterCount ?? this.encounterCount,
      correctCount: correctCount ?? this.correctCount,
      failCount: failCount ?? this.failCount,
      lastEncounteredAt: lastEncounteredAt ?? this.lastEncounteredAt,
      lastWrongAt: lastWrongAt ?? this.lastWrongAt,
      masteryLevel: masteryLevel ?? this.masteryLevel,
      consecutiveCorrect: consecutiveCorrect ?? this.consecutiveCorrect,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<int>(childId.value);
    }
    if (idiomId.present) {
      map['idiom_id'] = Variable<int>(idiomId.value);
    }
    if (encounterCount.present) {
      map['encounter_count'] = Variable<int>(encounterCount.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (failCount.present) {
      map['fail_count'] = Variable<int>(failCount.value);
    }
    if (lastEncounteredAt.present) {
      map['last_encountered_at'] = Variable<DateTime>(lastEncounteredAt.value);
    }
    if (lastWrongAt.present) {
      map['last_wrong_at'] = Variable<DateTime>(lastWrongAt.value);
    }
    if (masteryLevel.present) {
      map['mastery_level'] = Variable<int>(masteryLevel.value);
    }
    if (consecutiveCorrect.present) {
      map['consecutive_correct'] = Variable<int>(consecutiveCorrect.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdiomEngagementRecordsCompanion(')
          ..write('id: $id, ')
          ..write('childId: $childId, ')
          ..write('idiomId: $idiomId, ')
          ..write('encounterCount: $encounterCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('failCount: $failCount, ')
          ..write('lastEncounteredAt: $lastEncounteredAt, ')
          ..write('lastWrongAt: $lastWrongAt, ')
          ..write('masteryLevel: $masteryLevel, ')
          ..write('consecutiveCorrect: $consecutiveCorrect')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ChildrenTable children = $ChildrenTable(this);
  late final $RulesTable rules = $RulesTable(this);
  late final $RewardsTable rewards = $RewardsTable(this);
  late final $ExchangesTable exchanges = $ExchangesTable(this);
  late final $PointRecordsTable pointRecords = $PointRecordsTable(this);
  late final $AppContentsTable appContents = $AppContentsTable(this);
  late final $AppLogsTable appLogs = $AppLogsTable(this);
  late final $BadgesTable badges = $BadgesTable(this);
  late final $BadgeAcquisitionsTable badgeAcquisitions =
      $BadgeAcquisitionsTable(this);
  late final $CheckinRecordsTable checkinRecords = $CheckinRecordsTable(this);
  late final $IdiomsTable idioms = $IdiomsTable(this);
  late final $IdiomGameSettingsTable idiomGameSettings =
      $IdiomGameSettingsTable(this);
  late final $IdiomGameRecordsTable idiomGameRecords =
      $IdiomGameRecordsTable(this);
  late final $IdiomGradeProgressTable idiomGradeProgress =
      $IdiomGradeProgressTable(this);
  late final $IdiomFailureRecordsTable idiomFailureRecords =
      $IdiomFailureRecordsTable(this);
  late final $IdiomPuzzleRecordsTable idiomPuzzleRecords =
      $IdiomPuzzleRecordsTable(this);
  late final $IdiomEngagementRecordsTable idiomEngagementRecords =
      $IdiomEngagementRecordsTable(this);
  late final Index idxIdiomsFirstPinyin = Index('idx_idioms_first_pinyin',
      'CREATE INDEX idx_idioms_first_pinyin ON idioms (first_pinyin_no_tone)');
  late final Index idxIdiomsLastPinyin = Index('idx_idioms_last_pinyin',
      'CREATE INDEX idx_idioms_last_pinyin ON idioms (last_pinyin_no_tone)');
  late final Index idxIdiomsFirstChar = Index('idx_idioms_first_char',
      'CREATE INDEX idx_idioms_first_char ON idioms (first_char)');
  late final Index idxIdiomsLastChar = Index('idx_idioms_last_char',
      'CREATE INDEX idx_idioms_last_char ON idioms (last_char)');
  late final Index idxIdiomsGrade = Index('idx_idioms_grade',
      'CREATE INDEX idx_idioms_grade ON idioms (grade_level)');
  late final Index idxIdiomsRare = Index(
      'idx_idioms_rare', 'CREATE INDEX idx_idioms_rare ON idioms (is_rare)');
  late final Index idxIdiomsFirstPinyinTone = Index(
      'idx_idioms_first_pinyin_tone',
      'CREATE INDEX idx_idioms_first_pinyin_tone ON idioms (first_pinyin)');
  late final Index idxIdiomsLastPinyinTone = Index(
      'idx_idioms_last_pinyin_tone',
      'CREATE INDEX idx_idioms_last_pinyin_tone ON idioms (last_pinyin)');
  late final Index idxIdiomFailuresChild = Index('idx_idiom_failures_child',
      'CREATE INDEX idx_idiom_failures_child ON idiom_failure_records (child_id)');
  late final Index idxIdiomFailuresLastChar = Index(
      'idx_idiom_failures_last_char',
      'CREATE INDEX idx_idiom_failures_last_char ON idiom_failure_records (last_char)');
  late final Index idxEngagementChildIdiom = Index('idx_engagement_child_idiom',
      'CREATE UNIQUE INDEX idx_engagement_child_idiom ON idiom_engagement_records (child_id, idiom_id)');
  late final Index idxReviewQueue = Index('idx_review_queue',
      'CREATE INDEX idx_review_queue ON idiom_engagement_records (child_id, mastery_level, last_wrong_at)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        children,
        rules,
        rewards,
        exchanges,
        pointRecords,
        appContents,
        appLogs,
        badges,
        badgeAcquisitions,
        checkinRecords,
        idioms,
        idiomGameSettings,
        idiomGameRecords,
        idiomGradeProgress,
        idiomFailureRecords,
        idiomPuzzleRecords,
        idiomEngagementRecords,
        idxIdiomsFirstPinyin,
        idxIdiomsLastPinyin,
        idxIdiomsFirstChar,
        idxIdiomsLastChar,
        idxIdiomsGrade,
        idxIdiomsRare,
        idxIdiomsFirstPinyinTone,
        idxIdiomsLastPinyinTone,
        idxIdiomFailuresChild,
        idxIdiomFailuresLastChar,
        idxEngagementChildIdiom,
        idxReviewQueue
      ];
}

typedef $$ChildrenTableCreateCompanionBuilder = ChildrenCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> avatar,
  required String gender,
  Value<String?> birthday,
  Value<int> stars,
  Value<bool> isDeleted,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$ChildrenTableUpdateCompanionBuilder = ChildrenCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> avatar,
  Value<String> gender,
  Value<String?> birthday,
  Value<int> stars,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ChildrenTableReferences
    extends BaseReferences<_$AppDatabase, $ChildrenTable, ChildrenData> {
  $$ChildrenTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RulesTable, List<Rule>> _rulesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.rules,
          aliasName: $_aliasNameGenerator(db.children.id, db.rules.childId));

  $$RulesTableProcessedTableManager get rulesRefs {
    final manager = $$RulesTableTableManager($_db, $_db.rules)
        .filter((f) => f.childId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_rulesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExchangesTable, List<Exchange>>
      _exchangesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.exchanges,
              aliasName:
                  $_aliasNameGenerator(db.children.id, db.exchanges.childId));

  $$ExchangesTableProcessedTableManager get exchangesRefs {
    final manager = $$ExchangesTableTableManager($_db, $_db.exchanges)
        .filter((f) => f.childId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_exchangesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PointRecordsTable, List<PointRecord>>
      _pointRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.pointRecords,
          aliasName:
              $_aliasNameGenerator(db.children.id, db.pointRecords.childId));

  $$PointRecordsTableProcessedTableManager get pointRecordsRefs {
    final manager = $$PointRecordsTableTableManager($_db, $_db.pointRecords)
        .filter((f) => f.childId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_pointRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BadgeAcquisitionsTable, List<BadgeAcquisition>>
      _badgeAcquisitionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.badgeAcquisitions,
              aliasName: $_aliasNameGenerator(
                  db.children.id, db.badgeAcquisitions.childId));

  $$BadgeAcquisitionsTableProcessedTableManager get badgeAcquisitionsRefs {
    final manager =
        $$BadgeAcquisitionsTableTableManager($_db, $_db.badgeAcquisitions)
            .filter((f) => f.childId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_badgeAcquisitionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CheckinRecordsTable, List<CheckinRecord>>
      _checkinRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.checkinRecords,
              aliasName: $_aliasNameGenerator(
                  db.children.id, db.checkinRecords.childId));

  $$CheckinRecordsTableProcessedTableManager get checkinRecordsRefs {
    final manager = $$CheckinRecordsTableTableManager($_db, $_db.checkinRecords)
        .filter((f) => f.childId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_checkinRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$IdiomGameSettingsTable, List<IdiomGameSetting>>
      _idiomGameSettingsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.idiomGameSettings,
              aliasName: $_aliasNameGenerator(
                  db.children.id, db.idiomGameSettings.childId));

  $$IdiomGameSettingsTableProcessedTableManager get idiomGameSettingsRefs {
    final manager =
        $$IdiomGameSettingsTableTableManager($_db, $_db.idiomGameSettings)
            .filter((f) => f.childId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_idiomGameSettingsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$IdiomGameRecordsTable, List<IdiomGameRecord>>
      _idiomGameRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.idiomGameRecords,
              aliasName: $_aliasNameGenerator(
                  db.children.id, db.idiomGameRecords.childId));

  $$IdiomGameRecordsTableProcessedTableManager get idiomGameRecordsRefs {
    final manager =
        $$IdiomGameRecordsTableTableManager($_db, $_db.idiomGameRecords)
            .filter((f) => f.childId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_idiomGameRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$IdiomGradeProgressTable,
      List<IdiomGradeProgressData>> _idiomGradeProgressRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.idiomGradeProgress,
          aliasName: $_aliasNameGenerator(
              db.children.id, db.idiomGradeProgress.childId));

  $$IdiomGradeProgressTableProcessedTableManager get idiomGradeProgressRefs {
    final manager =
        $$IdiomGradeProgressTableTableManager($_db, $_db.idiomGradeProgress)
            .filter((f) => f.childId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_idiomGradeProgressRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$IdiomFailureRecordsTable,
      List<IdiomFailureRecord>> _idiomFailureRecordsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.idiomFailureRecords,
          aliasName: $_aliasNameGenerator(
              db.children.id, db.idiomFailureRecords.childId));

  $$IdiomFailureRecordsTableProcessedTableManager get idiomFailureRecordsRefs {
    final manager =
        $$IdiomFailureRecordsTableTableManager($_db, $_db.idiomFailureRecords)
            .filter((f) => f.childId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_idiomFailureRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$IdiomPuzzleRecordsTable, List<IdiomPuzzleRecord>>
      _idiomPuzzleRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.idiomPuzzleRecords,
              aliasName: $_aliasNameGenerator(
                  db.children.id, db.idiomPuzzleRecords.childId));

  $$IdiomPuzzleRecordsTableProcessedTableManager get idiomPuzzleRecordsRefs {
    final manager =
        $$IdiomPuzzleRecordsTableTableManager($_db, $_db.idiomPuzzleRecords)
            .filter((f) => f.childId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_idiomPuzzleRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$IdiomEngagementRecordsTable,
      List<IdiomEngagementRecord>> _idiomEngagementRecordsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.idiomEngagementRecords,
          aliasName: $_aliasNameGenerator(
              db.children.id, db.idiomEngagementRecords.childId));

  $$IdiomEngagementRecordsTableProcessedTableManager
      get idiomEngagementRecordsRefs {
    final manager = $$IdiomEngagementRecordsTableTableManager(
            $_db, $_db.idiomEngagementRecords)
        .filter((f) => f.childId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_idiomEngagementRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ChildrenTableFilterComposer
    extends Composer<_$AppDatabase, $ChildrenTable> {
  $$ChildrenTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatar => $composableBuilder(
      column: $table.avatar, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stars => $composableBuilder(
      column: $table.stars, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> rulesRefs(
      Expression<bool> Function($$RulesTableFilterComposer f) f) {
    final $$RulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.rules,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RulesTableFilterComposer(
              $db: $db,
              $table: $db.rules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> exchangesRefs(
      Expression<bool> Function($$ExchangesTableFilterComposer f) f) {
    final $$ExchangesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exchanges,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExchangesTableFilterComposer(
              $db: $db,
              $table: $db.exchanges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> pointRecordsRefs(
      Expression<bool> Function($$PointRecordsTableFilterComposer f) f) {
    final $$PointRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pointRecords,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PointRecordsTableFilterComposer(
              $db: $db,
              $table: $db.pointRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> badgeAcquisitionsRefs(
      Expression<bool> Function($$BadgeAcquisitionsTableFilterComposer f) f) {
    final $$BadgeAcquisitionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.badgeAcquisitions,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BadgeAcquisitionsTableFilterComposer(
              $db: $db,
              $table: $db.badgeAcquisitions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> checkinRecordsRefs(
      Expression<bool> Function($$CheckinRecordsTableFilterComposer f) f) {
    final $$CheckinRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.checkinRecords,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CheckinRecordsTableFilterComposer(
              $db: $db,
              $table: $db.checkinRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> idiomGameSettingsRefs(
      Expression<bool> Function($$IdiomGameSettingsTableFilterComposer f) f) {
    final $$IdiomGameSettingsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.idiomGameSettings,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IdiomGameSettingsTableFilterComposer(
              $db: $db,
              $table: $db.idiomGameSettings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> idiomGameRecordsRefs(
      Expression<bool> Function($$IdiomGameRecordsTableFilterComposer f) f) {
    final $$IdiomGameRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.idiomGameRecords,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IdiomGameRecordsTableFilterComposer(
              $db: $db,
              $table: $db.idiomGameRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> idiomGradeProgressRefs(
      Expression<bool> Function($$IdiomGradeProgressTableFilterComposer f) f) {
    final $$IdiomGradeProgressTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.idiomGradeProgress,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IdiomGradeProgressTableFilterComposer(
              $db: $db,
              $table: $db.idiomGradeProgress,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> idiomFailureRecordsRefs(
      Expression<bool> Function($$IdiomFailureRecordsTableFilterComposer f) f) {
    final $$IdiomFailureRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.idiomFailureRecords,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IdiomFailureRecordsTableFilterComposer(
              $db: $db,
              $table: $db.idiomFailureRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> idiomPuzzleRecordsRefs(
      Expression<bool> Function($$IdiomPuzzleRecordsTableFilterComposer f) f) {
    final $$IdiomPuzzleRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.idiomPuzzleRecords,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IdiomPuzzleRecordsTableFilterComposer(
              $db: $db,
              $table: $db.idiomPuzzleRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> idiomEngagementRecordsRefs(
      Expression<bool> Function($$IdiomEngagementRecordsTableFilterComposer f)
          f) {
    final $$IdiomEngagementRecordsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.idiomEngagementRecords,
            getReferencedColumn: (t) => t.childId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$IdiomEngagementRecordsTableFilterComposer(
                  $db: $db,
                  $table: $db.idiomEngagementRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ChildrenTableOrderingComposer
    extends Composer<_$AppDatabase, $ChildrenTable> {
  $$ChildrenTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatar => $composableBuilder(
      column: $table.avatar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stars => $composableBuilder(
      column: $table.stars, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ChildrenTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChildrenTable> {
  $$ChildrenTableAnnotationComposer({
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

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  GeneratedColumn<int> get stars =>
      $composableBuilder(column: $table.stars, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> rulesRefs<T extends Object>(
      Expression<T> Function($$RulesTableAnnotationComposer a) f) {
    final $$RulesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.rules,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RulesTableAnnotationComposer(
              $db: $db,
              $table: $db.rules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> exchangesRefs<T extends Object>(
      Expression<T> Function($$ExchangesTableAnnotationComposer a) f) {
    final $$ExchangesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exchanges,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExchangesTableAnnotationComposer(
              $db: $db,
              $table: $db.exchanges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> pointRecordsRefs<T extends Object>(
      Expression<T> Function($$PointRecordsTableAnnotationComposer a) f) {
    final $$PointRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pointRecords,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PointRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.pointRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> badgeAcquisitionsRefs<T extends Object>(
      Expression<T> Function($$BadgeAcquisitionsTableAnnotationComposer a) f) {
    final $$BadgeAcquisitionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.badgeAcquisitions,
            getReferencedColumn: (t) => t.childId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$BadgeAcquisitionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.badgeAcquisitions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> checkinRecordsRefs<T extends Object>(
      Expression<T> Function($$CheckinRecordsTableAnnotationComposer a) f) {
    final $$CheckinRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.checkinRecords,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CheckinRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.checkinRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> idiomGameSettingsRefs<T extends Object>(
      Expression<T> Function($$IdiomGameSettingsTableAnnotationComposer a) f) {
    final $$IdiomGameSettingsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.idiomGameSettings,
            getReferencedColumn: (t) => t.childId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$IdiomGameSettingsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.idiomGameSettings,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> idiomGameRecordsRefs<T extends Object>(
      Expression<T> Function($$IdiomGameRecordsTableAnnotationComposer a) f) {
    final $$IdiomGameRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.idiomGameRecords,
        getReferencedColumn: (t) => t.childId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IdiomGameRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.idiomGameRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> idiomGradeProgressRefs<T extends Object>(
      Expression<T> Function($$IdiomGradeProgressTableAnnotationComposer a) f) {
    final $$IdiomGradeProgressTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.idiomGradeProgress,
            getReferencedColumn: (t) => t.childId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$IdiomGradeProgressTableAnnotationComposer(
                  $db: $db,
                  $table: $db.idiomGradeProgress,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> idiomFailureRecordsRefs<T extends Object>(
      Expression<T> Function($$IdiomFailureRecordsTableAnnotationComposer a)
          f) {
    final $$IdiomFailureRecordsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.idiomFailureRecords,
            getReferencedColumn: (t) => t.childId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$IdiomFailureRecordsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.idiomFailureRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> idiomPuzzleRecordsRefs<T extends Object>(
      Expression<T> Function($$IdiomPuzzleRecordsTableAnnotationComposer a) f) {
    final $$IdiomPuzzleRecordsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.idiomPuzzleRecords,
            getReferencedColumn: (t) => t.childId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$IdiomPuzzleRecordsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.idiomPuzzleRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> idiomEngagementRecordsRefs<T extends Object>(
      Expression<T> Function($$IdiomEngagementRecordsTableAnnotationComposer a)
          f) {
    final $$IdiomEngagementRecordsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.idiomEngagementRecords,
            getReferencedColumn: (t) => t.childId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$IdiomEngagementRecordsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.idiomEngagementRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ChildrenTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChildrenTable,
    ChildrenData,
    $$ChildrenTableFilterComposer,
    $$ChildrenTableOrderingComposer,
    $$ChildrenTableAnnotationComposer,
    $$ChildrenTableCreateCompanionBuilder,
    $$ChildrenTableUpdateCompanionBuilder,
    (ChildrenData, $$ChildrenTableReferences),
    ChildrenData,
    PrefetchHooks Function(
        {bool rulesRefs,
        bool exchangesRefs,
        bool pointRecordsRefs,
        bool badgeAcquisitionsRefs,
        bool checkinRecordsRefs,
        bool idiomGameSettingsRefs,
        bool idiomGameRecordsRefs,
        bool idiomGradeProgressRefs,
        bool idiomFailureRecordsRefs,
        bool idiomPuzzleRecordsRefs,
        bool idiomEngagementRecordsRefs})> {
  $$ChildrenTableTableManager(_$AppDatabase db, $ChildrenTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChildrenTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChildrenTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChildrenTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> avatar = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<String?> birthday = const Value.absent(),
            Value<int> stars = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ChildrenCompanion(
            id: id,
            name: name,
            avatar: avatar,
            gender: gender,
            birthday: birthday,
            stars: stars,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> avatar = const Value.absent(),
            required String gender,
            Value<String?> birthday = const Value.absent(),
            Value<int> stars = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              ChildrenCompanion.insert(
            id: id,
            name: name,
            avatar: avatar,
            gender: gender,
            birthday: birthday,
            stars: stars,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ChildrenTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {rulesRefs = false,
              exchangesRefs = false,
              pointRecordsRefs = false,
              badgeAcquisitionsRefs = false,
              checkinRecordsRefs = false,
              idiomGameSettingsRefs = false,
              idiomGameRecordsRefs = false,
              idiomGradeProgressRefs = false,
              idiomFailureRecordsRefs = false,
              idiomPuzzleRecordsRefs = false,
              idiomEngagementRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (rulesRefs) db.rules,
                if (exchangesRefs) db.exchanges,
                if (pointRecordsRefs) db.pointRecords,
                if (badgeAcquisitionsRefs) db.badgeAcquisitions,
                if (checkinRecordsRefs) db.checkinRecords,
                if (idiomGameSettingsRefs) db.idiomGameSettings,
                if (idiomGameRecordsRefs) db.idiomGameRecords,
                if (idiomGradeProgressRefs) db.idiomGradeProgress,
                if (idiomFailureRecordsRefs) db.idiomFailureRecords,
                if (idiomPuzzleRecordsRefs) db.idiomPuzzleRecords,
                if (idiomEngagementRecordsRefs) db.idiomEngagementRecords
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (rulesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ChildrenTableReferences._rulesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChildrenTableReferences(db, table, p0).rulesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.childId == item.id),
                        typedResults: items),
                  if (exchangesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ChildrenTableReferences._exchangesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChildrenTableReferences(db, table, p0)
                                .exchangesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.childId == item.id),
                        typedResults: items),
                  if (pointRecordsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChildrenTableReferences
                            ._pointRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChildrenTableReferences(db, table, p0)
                                .pointRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.childId == item.id),
                        typedResults: items),
                  if (badgeAcquisitionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChildrenTableReferences
                            ._badgeAcquisitionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChildrenTableReferences(db, table, p0)
                                .badgeAcquisitionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.childId == item.id),
                        typedResults: items),
                  if (checkinRecordsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChildrenTableReferences
                            ._checkinRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChildrenTableReferences(db, table, p0)
                                .checkinRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.childId == item.id),
                        typedResults: items),
                  if (idiomGameSettingsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChildrenTableReferences
                            ._idiomGameSettingsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChildrenTableReferences(db, table, p0)
                                .idiomGameSettingsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.childId == item.id),
                        typedResults: items),
                  if (idiomGameRecordsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChildrenTableReferences
                            ._idiomGameRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChildrenTableReferences(db, table, p0)
                                .idiomGameRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.childId == item.id),
                        typedResults: items),
                  if (idiomGradeProgressRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChildrenTableReferences
                            ._idiomGradeProgressRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChildrenTableReferences(db, table, p0)
                                .idiomGradeProgressRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.childId == item.id),
                        typedResults: items),
                  if (idiomFailureRecordsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChildrenTableReferences
                            ._idiomFailureRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChildrenTableReferences(db, table, p0)
                                .idiomFailureRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.childId == item.id),
                        typedResults: items),
                  if (idiomPuzzleRecordsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChildrenTableReferences
                            ._idiomPuzzleRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChildrenTableReferences(db, table, p0)
                                .idiomPuzzleRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.childId == item.id),
                        typedResults: items),
                  if (idiomEngagementRecordsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChildrenTableReferences
                            ._idiomEngagementRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChildrenTableReferences(db, table, p0)
                                .idiomEngagementRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.childId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ChildrenTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChildrenTable,
    ChildrenData,
    $$ChildrenTableFilterComposer,
    $$ChildrenTableOrderingComposer,
    $$ChildrenTableAnnotationComposer,
    $$ChildrenTableCreateCompanionBuilder,
    $$ChildrenTableUpdateCompanionBuilder,
    (ChildrenData, $$ChildrenTableReferences),
    ChildrenData,
    PrefetchHooks Function(
        {bool rulesRefs,
        bool exchangesRefs,
        bool pointRecordsRefs,
        bool badgeAcquisitionsRefs,
        bool checkinRecordsRefs,
        bool idiomGameSettingsRefs,
        bool idiomGameRecordsRefs,
        bool idiomGradeProgressRefs,
        bool idiomFailureRecordsRefs,
        bool idiomPuzzleRecordsRefs,
        bool idiomEngagementRecordsRefs})>;
typedef $$RulesTableCreateCompanionBuilder = RulesCompanion Function({
  Value<int> id,
  Value<int?> childId,
  required String name,
  Value<String> icon,
  required int points,
  Value<String> type,
  Value<bool> isActive,
  Value<bool> isSystem,
  Value<bool> isEditable,
  Value<bool> isDeleted,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$RulesTableUpdateCompanionBuilder = RulesCompanion Function({
  Value<int> id,
  Value<int?> childId,
  Value<String> name,
  Value<String> icon,
  Value<int> points,
  Value<String> type,
  Value<bool> isActive,
  Value<bool> isSystem,
  Value<bool> isEditable,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$RulesTableReferences
    extends BaseReferences<_$AppDatabase, $RulesTable, Rule> {
  $$RulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChildrenTable _childIdTable(_$AppDatabase db) => db.children
      .createAlias($_aliasNameGenerator(db.rules.childId, db.children.id));

  $$ChildrenTableProcessedTableManager? get childId {
    if ($_item.childId == null) return null;
    final manager = $$ChildrenTableTableManager($_db, $_db.children)
        .filter((f) => f.id($_item.childId!));
    final item = $_typedResult.readTableOrNull(_childIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PointRecordsTable, List<PointRecord>>
      _pointRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.pointRecords,
          aliasName: $_aliasNameGenerator(db.rules.id, db.pointRecords.ruleId));

  $$PointRecordsTableProcessedTableManager get pointRecordsRefs {
    final manager = $$PointRecordsTableTableManager($_db, $_db.pointRecords)
        .filter((f) => f.ruleId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_pointRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RulesTableFilterComposer extends Composer<_$AppDatabase, $RulesTable> {
  $$RulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get points => $composableBuilder(
      column: $table.points, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSystem => $composableBuilder(
      column: $table.isSystem, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEditable => $composableBuilder(
      column: $table.isEditable, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ChildrenTableFilterComposer get childId {
    final $$ChildrenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableFilterComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> pointRecordsRefs(
      Expression<bool> Function($$PointRecordsTableFilterComposer f) f) {
    final $$PointRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pointRecords,
        getReferencedColumn: (t) => t.ruleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PointRecordsTableFilterComposer(
              $db: $db,
              $table: $db.pointRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RulesTableOrderingComposer
    extends Composer<_$AppDatabase, $RulesTable> {
  $$RulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get points => $composableBuilder(
      column: $table.points, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSystem => $composableBuilder(
      column: $table.isSystem, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEditable => $composableBuilder(
      column: $table.isEditable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ChildrenTableOrderingComposer get childId {
    final $$ChildrenTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableOrderingComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RulesTable> {
  $$RulesTableAnnotationComposer({
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

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<bool> get isEditable => $composableBuilder(
      column: $table.isEditable, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ChildrenTableAnnotationComposer get childId {
    final $$ChildrenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableAnnotationComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> pointRecordsRefs<T extends Object>(
      Expression<T> Function($$PointRecordsTableAnnotationComposer a) f) {
    final $$PointRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pointRecords,
        getReferencedColumn: (t) => t.ruleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PointRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.pointRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RulesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RulesTable,
    Rule,
    $$RulesTableFilterComposer,
    $$RulesTableOrderingComposer,
    $$RulesTableAnnotationComposer,
    $$RulesTableCreateCompanionBuilder,
    $$RulesTableUpdateCompanionBuilder,
    (Rule, $$RulesTableReferences),
    Rule,
    PrefetchHooks Function({bool childId, bool pointRecordsRefs})> {
  $$RulesTableTableManager(_$AppDatabase db, $RulesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> childId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<int> points = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isSystem = const Value.absent(),
            Value<bool> isEditable = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              RulesCompanion(
            id: id,
            childId: childId,
            name: name,
            icon: icon,
            points: points,
            type: type,
            isActive: isActive,
            isSystem: isSystem,
            isEditable: isEditable,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> childId = const Value.absent(),
            required String name,
            Value<String> icon = const Value.absent(),
            required int points,
            Value<String> type = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isSystem = const Value.absent(),
            Value<bool> isEditable = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              RulesCompanion.insert(
            id: id,
            childId: childId,
            name: name,
            icon: icon,
            points: points,
            type: type,
            isActive: isActive,
            isSystem: isSystem,
            isEditable: isEditable,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$RulesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({childId = false, pointRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pointRecordsRefs) db.pointRecords],
              addJoins: <
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
                      dynamic>>(state) {
                if (childId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.childId,
                    referencedTable: $$RulesTableReferences._childIdTable(db),
                    referencedColumn:
                        $$RulesTableReferences._childIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pointRecordsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$RulesTableReferences._pointRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RulesTableReferences(db, table, p0)
                                .pointRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.ruleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RulesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RulesTable,
    Rule,
    $$RulesTableFilterComposer,
    $$RulesTableOrderingComposer,
    $$RulesTableAnnotationComposer,
    $$RulesTableCreateCompanionBuilder,
    $$RulesTableUpdateCompanionBuilder,
    (Rule, $$RulesTableReferences),
    Rule,
    PrefetchHooks Function({bool childId, bool pointRecordsRefs})>;
typedef $$RewardsTableCreateCompanionBuilder = RewardsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  Value<String?> image,
  required int price,
  Value<String> category,
  Value<int?> stock,
  Value<bool> isActive,
  Value<bool> isDeleted,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$RewardsTableUpdateCompanionBuilder = RewardsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<String?> image,
  Value<int> price,
  Value<String> category,
  Value<int?> stock,
  Value<bool> isActive,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$RewardsTableReferences
    extends BaseReferences<_$AppDatabase, $RewardsTable, Reward> {
  $$RewardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExchangesTable, List<Exchange>>
      _exchangesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.exchanges,
              aliasName:
                  $_aliasNameGenerator(db.rewards.id, db.exchanges.rewardId));

  $$ExchangesTableProcessedTableManager get exchangesRefs {
    final manager = $$ExchangesTableTableManager($_db, $_db.exchanges)
        .filter((f) => f.rewardId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_exchangesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RewardsTableFilterComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> exchangesRefs(
      Expression<bool> Function($$ExchangesTableFilterComposer f) f) {
    final $$ExchangesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exchanges,
        getReferencedColumn: (t) => t.rewardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExchangesTableFilterComposer(
              $db: $db,
              $table: $db.exchanges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RewardsTableOrderingComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$RewardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> exchangesRefs<T extends Object>(
      Expression<T> Function($$ExchangesTableAnnotationComposer a) f) {
    final $$ExchangesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exchanges,
        getReferencedColumn: (t) => t.rewardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExchangesTableAnnotationComposer(
              $db: $db,
              $table: $db.exchanges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RewardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RewardsTable,
    Reward,
    $$RewardsTableFilterComposer,
    $$RewardsTableOrderingComposer,
    $$RewardsTableAnnotationComposer,
    $$RewardsTableCreateCompanionBuilder,
    $$RewardsTableUpdateCompanionBuilder,
    (Reward, $$RewardsTableReferences),
    Reward,
    PrefetchHooks Function({bool exchangesRefs})> {
  $$RewardsTableTableManager(_$AppDatabase db, $RewardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RewardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RewardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RewardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> image = const Value.absent(),
            Value<int> price = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<int?> stock = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              RewardsCompanion(
            id: id,
            name: name,
            description: description,
            image: image,
            price: price,
            category: category,
            stock: stock,
            isActive: isActive,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String?> image = const Value.absent(),
            required int price,
            Value<String> category = const Value.absent(),
            Value<int?> stock = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              RewardsCompanion.insert(
            id: id,
            name: name,
            description: description,
            image: image,
            price: price,
            category: category,
            stock: stock,
            isActive: isActive,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$RewardsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({exchangesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (exchangesRefs) db.exchanges],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exchangesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$RewardsTableReferences._exchangesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RewardsTableReferences(db, table, p0)
                                .exchangesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.rewardId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RewardsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RewardsTable,
    Reward,
    $$RewardsTableFilterComposer,
    $$RewardsTableOrderingComposer,
    $$RewardsTableAnnotationComposer,
    $$RewardsTableCreateCompanionBuilder,
    $$RewardsTableUpdateCompanionBuilder,
    (Reward, $$RewardsTableReferences),
    Reward,
    PrefetchHooks Function({bool exchangesRefs})>;
typedef $$ExchangesTableCreateCompanionBuilder = ExchangesCompanion Function({
  Value<int> id,
  required int childId,
  required int rewardId,
  required String rewardSnapshot,
  required int pointsSpent,
  Value<String?> note,
  Value<bool> isDeleted,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$ExchangesTableUpdateCompanionBuilder = ExchangesCompanion Function({
  Value<int> id,
  Value<int> childId,
  Value<int> rewardId,
  Value<String> rewardSnapshot,
  Value<int> pointsSpent,
  Value<String?> note,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$ExchangesTableReferences
    extends BaseReferences<_$AppDatabase, $ExchangesTable, Exchange> {
  $$ExchangesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChildrenTable _childIdTable(_$AppDatabase db) => db.children
      .createAlias($_aliasNameGenerator(db.exchanges.childId, db.children.id));

  $$ChildrenTableProcessedTableManager? get childId {
    if ($_item.childId == null) return null;
    final manager = $$ChildrenTableTableManager($_db, $_db.children)
        .filter((f) => f.id($_item.childId!));
    final item = $_typedResult.readTableOrNull(_childIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RewardsTable _rewardIdTable(_$AppDatabase db) => db.rewards
      .createAlias($_aliasNameGenerator(db.exchanges.rewardId, db.rewards.id));

  $$RewardsTableProcessedTableManager? get rewardId {
    if ($_item.rewardId == null) return null;
    final manager = $$RewardsTableTableManager($_db, $_db.rewards)
        .filter((f) => f.id($_item.rewardId!));
    final item = $_typedResult.readTableOrNull(_rewardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PointRecordsTable, List<PointRecord>>
      _pointRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.pointRecords,
              aliasName: $_aliasNameGenerator(
                  db.exchanges.id, db.pointRecords.exchangeId));

  $$PointRecordsTableProcessedTableManager get pointRecordsRefs {
    final manager = $$PointRecordsTableTableManager($_db, $_db.pointRecords)
        .filter((f) => f.exchangeId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_pointRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExchangesTableFilterComposer
    extends Composer<_$AppDatabase, $ExchangesTable> {
  $$ExchangesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rewardSnapshot => $composableBuilder(
      column: $table.rewardSnapshot,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pointsSpent => $composableBuilder(
      column: $table.pointsSpent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ChildrenTableFilterComposer get childId {
    final $$ChildrenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableFilterComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RewardsTableFilterComposer get rewardId {
    final $$RewardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.rewardId,
        referencedTable: $db.rewards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RewardsTableFilterComposer(
              $db: $db,
              $table: $db.rewards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> pointRecordsRefs(
      Expression<bool> Function($$PointRecordsTableFilterComposer f) f) {
    final $$PointRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pointRecords,
        getReferencedColumn: (t) => t.exchangeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PointRecordsTableFilterComposer(
              $db: $db,
              $table: $db.pointRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExchangesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExchangesTable> {
  $$ExchangesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rewardSnapshot => $composableBuilder(
      column: $table.rewardSnapshot,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pointsSpent => $composableBuilder(
      column: $table.pointsSpent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ChildrenTableOrderingComposer get childId {
    final $$ChildrenTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableOrderingComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RewardsTableOrderingComposer get rewardId {
    final $$RewardsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.rewardId,
        referencedTable: $db.rewards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RewardsTableOrderingComposer(
              $db: $db,
              $table: $db.rewards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExchangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExchangesTable> {
  $$ExchangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rewardSnapshot => $composableBuilder(
      column: $table.rewardSnapshot, builder: (column) => column);

  GeneratedColumn<int> get pointsSpent => $composableBuilder(
      column: $table.pointsSpent, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ChildrenTableAnnotationComposer get childId {
    final $$ChildrenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableAnnotationComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RewardsTableAnnotationComposer get rewardId {
    final $$RewardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.rewardId,
        referencedTable: $db.rewards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RewardsTableAnnotationComposer(
              $db: $db,
              $table: $db.rewards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> pointRecordsRefs<T extends Object>(
      Expression<T> Function($$PointRecordsTableAnnotationComposer a) f) {
    final $$PointRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pointRecords,
        getReferencedColumn: (t) => t.exchangeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PointRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.pointRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExchangesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExchangesTable,
    Exchange,
    $$ExchangesTableFilterComposer,
    $$ExchangesTableOrderingComposer,
    $$ExchangesTableAnnotationComposer,
    $$ExchangesTableCreateCompanionBuilder,
    $$ExchangesTableUpdateCompanionBuilder,
    (Exchange, $$ExchangesTableReferences),
    Exchange,
    PrefetchHooks Function(
        {bool childId, bool rewardId, bool pointRecordsRefs})> {
  $$ExchangesTableTableManager(_$AppDatabase db, $ExchangesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExchangesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExchangesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExchangesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> childId = const Value.absent(),
            Value<int> rewardId = const Value.absent(),
            Value<String> rewardSnapshot = const Value.absent(),
            Value<int> pointsSpent = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ExchangesCompanion(
            id: id,
            childId: childId,
            rewardId: rewardId,
            rewardSnapshot: rewardSnapshot,
            pointsSpent: pointsSpent,
            note: note,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int childId,
            required int rewardId,
            required String rewardSnapshot,
            required int pointsSpent,
            Value<String?> note = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ExchangesCompanion.insert(
            id: id,
            childId: childId,
            rewardId: rewardId,
            rewardSnapshot: rewardSnapshot,
            pointsSpent: pointsSpent,
            note: note,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExchangesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {childId = false, rewardId = false, pointRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pointRecordsRefs) db.pointRecords],
              addJoins: <
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
                      dynamic>>(state) {
                if (childId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.childId,
                    referencedTable:
                        $$ExchangesTableReferences._childIdTable(db),
                    referencedColumn:
                        $$ExchangesTableReferences._childIdTable(db).id,
                  ) as T;
                }
                if (rewardId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.rewardId,
                    referencedTable:
                        $$ExchangesTableReferences._rewardIdTable(db),
                    referencedColumn:
                        $$ExchangesTableReferences._rewardIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pointRecordsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ExchangesTableReferences
                            ._pointRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExchangesTableReferences(db, table, p0)
                                .pointRecordsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exchangeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExchangesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExchangesTable,
    Exchange,
    $$ExchangesTableFilterComposer,
    $$ExchangesTableOrderingComposer,
    $$ExchangesTableAnnotationComposer,
    $$ExchangesTableCreateCompanionBuilder,
    $$ExchangesTableUpdateCompanionBuilder,
    (Exchange, $$ExchangesTableReferences),
    Exchange,
    PrefetchHooks Function(
        {bool childId, bool rewardId, bool pointRecordsRefs})>;
typedef $$PointRecordsTableCreateCompanionBuilder = PointRecordsCompanion
    Function({
  Value<int> id,
  required int childId,
  Value<int?> ruleId,
  Value<String?> ruleName,
  Value<int?> exchangeId,
  required int points,
  required String type,
  Value<String?> note,
  Value<bool> isDeleted,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$PointRecordsTableUpdateCompanionBuilder = PointRecordsCompanion
    Function({
  Value<int> id,
  Value<int> childId,
  Value<int?> ruleId,
  Value<String?> ruleName,
  Value<int?> exchangeId,
  Value<int> points,
  Value<String> type,
  Value<String?> note,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$PointRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $PointRecordsTable, PointRecord> {
  $$PointRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChildrenTable _childIdTable(_$AppDatabase db) =>
      db.children.createAlias(
          $_aliasNameGenerator(db.pointRecords.childId, db.children.id));

  $$ChildrenTableProcessedTableManager? get childId {
    if ($_item.childId == null) return null;
    final manager = $$ChildrenTableTableManager($_db, $_db.children)
        .filter((f) => f.id($_item.childId!));
    final item = $_typedResult.readTableOrNull(_childIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RulesTable _ruleIdTable(_$AppDatabase db) => db.rules
      .createAlias($_aliasNameGenerator(db.pointRecords.ruleId, db.rules.id));

  $$RulesTableProcessedTableManager? get ruleId {
    if ($_item.ruleId == null) return null;
    final manager = $$RulesTableTableManager($_db, $_db.rules)
        .filter((f) => f.id($_item.ruleId!));
    final item = $_typedResult.readTableOrNull(_ruleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ExchangesTable _exchangeIdTable(_$AppDatabase db) =>
      db.exchanges.createAlias(
          $_aliasNameGenerator(db.pointRecords.exchangeId, db.exchanges.id));

  $$ExchangesTableProcessedTableManager? get exchangeId {
    if ($_item.exchangeId == null) return null;
    final manager = $$ExchangesTableTableManager($_db, $_db.exchanges)
        .filter((f) => f.id($_item.exchangeId!));
    final item = $_typedResult.readTableOrNull(_exchangeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PointRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PointRecordsTable> {
  $$PointRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ruleName => $composableBuilder(
      column: $table.ruleName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get points => $composableBuilder(
      column: $table.points, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ChildrenTableFilterComposer get childId {
    final $$ChildrenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableFilterComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RulesTableFilterComposer get ruleId {
    final $$RulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ruleId,
        referencedTable: $db.rules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RulesTableFilterComposer(
              $db: $db,
              $table: $db.rules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExchangesTableFilterComposer get exchangeId {
    final $$ExchangesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exchangeId,
        referencedTable: $db.exchanges,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExchangesTableFilterComposer(
              $db: $db,
              $table: $db.exchanges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PointRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PointRecordsTable> {
  $$PointRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ruleName => $composableBuilder(
      column: $table.ruleName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get points => $composableBuilder(
      column: $table.points, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ChildrenTableOrderingComposer get childId {
    final $$ChildrenTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableOrderingComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RulesTableOrderingComposer get ruleId {
    final $$RulesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ruleId,
        referencedTable: $db.rules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RulesTableOrderingComposer(
              $db: $db,
              $table: $db.rules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExchangesTableOrderingComposer get exchangeId {
    final $$ExchangesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exchangeId,
        referencedTable: $db.exchanges,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExchangesTableOrderingComposer(
              $db: $db,
              $table: $db.exchanges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PointRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PointRecordsTable> {
  $$PointRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ruleName =>
      $composableBuilder(column: $table.ruleName, builder: (column) => column);

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ChildrenTableAnnotationComposer get childId {
    final $$ChildrenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableAnnotationComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RulesTableAnnotationComposer get ruleId {
    final $$RulesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ruleId,
        referencedTable: $db.rules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RulesTableAnnotationComposer(
              $db: $db,
              $table: $db.rules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExchangesTableAnnotationComposer get exchangeId {
    final $$ExchangesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exchangeId,
        referencedTable: $db.exchanges,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExchangesTableAnnotationComposer(
              $db: $db,
              $table: $db.exchanges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PointRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PointRecordsTable,
    PointRecord,
    $$PointRecordsTableFilterComposer,
    $$PointRecordsTableOrderingComposer,
    $$PointRecordsTableAnnotationComposer,
    $$PointRecordsTableCreateCompanionBuilder,
    $$PointRecordsTableUpdateCompanionBuilder,
    (PointRecord, $$PointRecordsTableReferences),
    PointRecord,
    PrefetchHooks Function({bool childId, bool ruleId, bool exchangeId})> {
  $$PointRecordsTableTableManager(_$AppDatabase db, $PointRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PointRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PointRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PointRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> childId = const Value.absent(),
            Value<int?> ruleId = const Value.absent(),
            Value<String?> ruleName = const Value.absent(),
            Value<int?> exchangeId = const Value.absent(),
            Value<int> points = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              PointRecordsCompanion(
            id: id,
            childId: childId,
            ruleId: ruleId,
            ruleName: ruleName,
            exchangeId: exchangeId,
            points: points,
            type: type,
            note: note,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int childId,
            Value<int?> ruleId = const Value.absent(),
            Value<String?> ruleName = const Value.absent(),
            Value<int?> exchangeId = const Value.absent(),
            required int points,
            required String type,
            Value<String?> note = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              PointRecordsCompanion.insert(
            id: id,
            childId: childId,
            ruleId: ruleId,
            ruleName: ruleName,
            exchangeId: exchangeId,
            points: points,
            type: type,
            note: note,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PointRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {childId = false, ruleId = false, exchangeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (childId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.childId,
                    referencedTable:
                        $$PointRecordsTableReferences._childIdTable(db),
                    referencedColumn:
                        $$PointRecordsTableReferences._childIdTable(db).id,
                  ) as T;
                }
                if (ruleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ruleId,
                    referencedTable:
                        $$PointRecordsTableReferences._ruleIdTable(db),
                    referencedColumn:
                        $$PointRecordsTableReferences._ruleIdTable(db).id,
                  ) as T;
                }
                if (exchangeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exchangeId,
                    referencedTable:
                        $$PointRecordsTableReferences._exchangeIdTable(db),
                    referencedColumn:
                        $$PointRecordsTableReferences._exchangeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PointRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PointRecordsTable,
    PointRecord,
    $$PointRecordsTableFilterComposer,
    $$PointRecordsTableOrderingComposer,
    $$PointRecordsTableAnnotationComposer,
    $$PointRecordsTableCreateCompanionBuilder,
    $$PointRecordsTableUpdateCompanionBuilder,
    (PointRecord, $$PointRecordsTableReferences),
    PointRecord,
    PrefetchHooks Function({bool childId, bool ruleId, bool exchangeId})>;
typedef $$AppContentsTableCreateCompanionBuilder = AppContentsCompanion
    Function({
  Value<int> id,
  required String key,
  required String titleEn,
  required String titleZh,
  required String contentEn,
  required String contentZh,
  Value<int> version,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$AppContentsTableUpdateCompanionBuilder = AppContentsCompanion
    Function({
  Value<int> id,
  Value<String> key,
  Value<String> titleEn,
  Value<String> titleZh,
  Value<String> contentEn,
  Value<String> contentZh,
  Value<int> version,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

class $$AppContentsTableFilterComposer
    extends Composer<_$AppDatabase, $AppContentsTable> {
  $$AppContentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titleEn => $composableBuilder(
      column: $table.titleEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titleZh => $composableBuilder(
      column: $table.titleZh, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentEn => $composableBuilder(
      column: $table.contentEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentZh => $composableBuilder(
      column: $table.contentZh, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AppContentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppContentsTable> {
  $$AppContentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titleEn => $composableBuilder(
      column: $table.titleEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titleZh => $composableBuilder(
      column: $table.titleZh, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentEn => $composableBuilder(
      column: $table.contentEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentZh => $composableBuilder(
      column: $table.contentZh, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AppContentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppContentsTable> {
  $$AppContentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get titleEn =>
      $composableBuilder(column: $table.titleEn, builder: (column) => column);

  GeneratedColumn<String> get titleZh =>
      $composableBuilder(column: $table.titleZh, builder: (column) => column);

  GeneratedColumn<String> get contentEn =>
      $composableBuilder(column: $table.contentEn, builder: (column) => column);

  GeneratedColumn<String> get contentZh =>
      $composableBuilder(column: $table.contentZh, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppContentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppContentsTable,
    AppContent,
    $$AppContentsTableFilterComposer,
    $$AppContentsTableOrderingComposer,
    $$AppContentsTableAnnotationComposer,
    $$AppContentsTableCreateCompanionBuilder,
    $$AppContentsTableUpdateCompanionBuilder,
    (AppContent, BaseReferences<_$AppDatabase, $AppContentsTable, AppContent>),
    AppContent,
    PrefetchHooks Function()> {
  $$AppContentsTableTableManager(_$AppDatabase db, $AppContentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppContentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppContentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppContentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> key = const Value.absent(),
            Value<String> titleEn = const Value.absent(),
            Value<String> titleZh = const Value.absent(),
            Value<String> contentEn = const Value.absent(),
            Value<String> contentZh = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              AppContentsCompanion(
            id: id,
            key: key,
            titleEn: titleEn,
            titleZh: titleZh,
            contentEn: contentEn,
            contentZh: contentZh,
            version: version,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String key,
            required String titleEn,
            required String titleZh,
            required String contentEn,
            required String contentZh,
            Value<int> version = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              AppContentsCompanion.insert(
            id: id,
            key: key,
            titleEn: titleEn,
            titleZh: titleZh,
            contentEn: contentEn,
            contentZh: contentZh,
            version: version,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppContentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppContentsTable,
    AppContent,
    $$AppContentsTableFilterComposer,
    $$AppContentsTableOrderingComposer,
    $$AppContentsTableAnnotationComposer,
    $$AppContentsTableCreateCompanionBuilder,
    $$AppContentsTableUpdateCompanionBuilder,
    (AppContent, BaseReferences<_$AppDatabase, $AppContentsTable, AppContent>),
    AppContent,
    PrefetchHooks Function()>;
typedef $$AppLogsTableCreateCompanionBuilder = AppLogsCompanion Function({
  Value<int> id,
  required String level,
  required String tag,
  required String message,
  Value<String?> stackTrace,
  Value<String?> extra,
  required DateTime createdAt,
});
typedef $$AppLogsTableUpdateCompanionBuilder = AppLogsCompanion Function({
  Value<int> id,
  Value<String> level,
  Value<String> tag,
  Value<String> message,
  Value<String?> stackTrace,
  Value<String?> extra,
  Value<DateTime> createdAt,
});

class $$AppLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AppLogsTable> {
  $$AppLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stackTrace => $composableBuilder(
      column: $table.stackTrace, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get extra => $composableBuilder(
      column: $table.extra, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$AppLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppLogsTable> {
  $$AppLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stackTrace => $composableBuilder(
      column: $table.stackTrace, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get extra => $composableBuilder(
      column: $table.extra, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AppLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppLogsTable> {
  $$AppLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get stackTrace => $composableBuilder(
      column: $table.stackTrace, builder: (column) => column);

  GeneratedColumn<String> get extra =>
      $composableBuilder(column: $table.extra, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AppLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppLogsTable,
    AppLog,
    $$AppLogsTableFilterComposer,
    $$AppLogsTableOrderingComposer,
    $$AppLogsTableAnnotationComposer,
    $$AppLogsTableCreateCompanionBuilder,
    $$AppLogsTableUpdateCompanionBuilder,
    (AppLog, BaseReferences<_$AppDatabase, $AppLogsTable, AppLog>),
    AppLog,
    PrefetchHooks Function()> {
  $$AppLogsTableTableManager(_$AppDatabase db, $AppLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> level = const Value.absent(),
            Value<String> tag = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<String?> stackTrace = const Value.absent(),
            Value<String?> extra = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AppLogsCompanion(
            id: id,
            level: level,
            tag: tag,
            message: message,
            stackTrace: stackTrace,
            extra: extra,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String level,
            required String tag,
            required String message,
            Value<String?> stackTrace = const Value.absent(),
            Value<String?> extra = const Value.absent(),
            required DateTime createdAt,
          }) =>
              AppLogsCompanion.insert(
            id: id,
            level: level,
            tag: tag,
            message: message,
            stackTrace: stackTrace,
            extra: extra,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppLogsTable,
    AppLog,
    $$AppLogsTableFilterComposer,
    $$AppLogsTableOrderingComposer,
    $$AppLogsTableAnnotationComposer,
    $$AppLogsTableCreateCompanionBuilder,
    $$AppLogsTableUpdateCompanionBuilder,
    (AppLog, BaseReferences<_$AppDatabase, $AppLogsTable, AppLog>),
    AppLog,
    PrefetchHooks Function()>;
typedef $$BadgesTableCreateCompanionBuilder = BadgesCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  required String icon,
  Value<int> level,
  required String triggerType,
  required int triggerThreshold,
  Value<String?> triggerConfig,
  Value<int> bonusPoints,
  Value<int> sortOrder,
  Value<bool> isActive,
  Value<bool> isSystem,
  Value<bool> isDeleted,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$BadgesTableUpdateCompanionBuilder = BadgesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<String> icon,
  Value<int> level,
  Value<String> triggerType,
  Value<int> triggerThreshold,
  Value<String?> triggerConfig,
  Value<int> bonusPoints,
  Value<int> sortOrder,
  Value<bool> isActive,
  Value<bool> isSystem,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$BadgesTableReferences
    extends BaseReferences<_$AppDatabase, $BadgesTable, Badge> {
  $$BadgesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BadgeAcquisitionsTable, List<BadgeAcquisition>>
      _badgeAcquisitionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.badgeAcquisitions,
              aliasName: $_aliasNameGenerator(
                  db.badges.id, db.badgeAcquisitions.badgeId));

  $$BadgeAcquisitionsTableProcessedTableManager get badgeAcquisitionsRefs {
    final manager =
        $$BadgeAcquisitionsTableTableManager($_db, $_db.badgeAcquisitions)
            .filter((f) => f.badgeId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_badgeAcquisitionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BadgesTableFilterComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get triggerType => $composableBuilder(
      column: $table.triggerType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get triggerThreshold => $composableBuilder(
      column: $table.triggerThreshold,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get triggerConfig => $composableBuilder(
      column: $table.triggerConfig, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bonusPoints => $composableBuilder(
      column: $table.bonusPoints, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSystem => $composableBuilder(
      column: $table.isSystem, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> badgeAcquisitionsRefs(
      Expression<bool> Function($$BadgeAcquisitionsTableFilterComposer f) f) {
    final $$BadgeAcquisitionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.badgeAcquisitions,
        getReferencedColumn: (t) => t.badgeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BadgeAcquisitionsTableFilterComposer(
              $db: $db,
              $table: $db.badgeAcquisitions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BadgesTableOrderingComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get triggerType => $composableBuilder(
      column: $table.triggerType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get triggerThreshold => $composableBuilder(
      column: $table.triggerThreshold,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get triggerConfig => $composableBuilder(
      column: $table.triggerConfig,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bonusPoints => $composableBuilder(
      column: $table.bonusPoints, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSystem => $composableBuilder(
      column: $table.isSystem, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$BadgesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get triggerType => $composableBuilder(
      column: $table.triggerType, builder: (column) => column);

  GeneratedColumn<int> get triggerThreshold => $composableBuilder(
      column: $table.triggerThreshold, builder: (column) => column);

  GeneratedColumn<String> get triggerConfig => $composableBuilder(
      column: $table.triggerConfig, builder: (column) => column);

  GeneratedColumn<int> get bonusPoints => $composableBuilder(
      column: $table.bonusPoints, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> badgeAcquisitionsRefs<T extends Object>(
      Expression<T> Function($$BadgeAcquisitionsTableAnnotationComposer a) f) {
    final $$BadgeAcquisitionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.badgeAcquisitions,
            getReferencedColumn: (t) => t.badgeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$BadgeAcquisitionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.badgeAcquisitions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$BadgesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BadgesTable,
    Badge,
    $$BadgesTableFilterComposer,
    $$BadgesTableOrderingComposer,
    $$BadgesTableAnnotationComposer,
    $$BadgesTableCreateCompanionBuilder,
    $$BadgesTableUpdateCompanionBuilder,
    (Badge, $$BadgesTableReferences),
    Badge,
    PrefetchHooks Function({bool badgeAcquisitionsRefs})> {
  $$BadgesTableTableManager(_$AppDatabase db, $BadgesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BadgesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BadgesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BadgesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String> triggerType = const Value.absent(),
            Value<int> triggerThreshold = const Value.absent(),
            Value<String?> triggerConfig = const Value.absent(),
            Value<int> bonusPoints = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isSystem = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              BadgesCompanion(
            id: id,
            name: name,
            description: description,
            icon: icon,
            level: level,
            triggerType: triggerType,
            triggerThreshold: triggerThreshold,
            triggerConfig: triggerConfig,
            bonusPoints: bonusPoints,
            sortOrder: sortOrder,
            isActive: isActive,
            isSystem: isSystem,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            required String icon,
            Value<int> level = const Value.absent(),
            required String triggerType,
            required int triggerThreshold,
            Value<String?> triggerConfig = const Value.absent(),
            Value<int> bonusPoints = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isSystem = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              BadgesCompanion.insert(
            id: id,
            name: name,
            description: description,
            icon: icon,
            level: level,
            triggerType: triggerType,
            triggerThreshold: triggerThreshold,
            triggerConfig: triggerConfig,
            bonusPoints: bonusPoints,
            sortOrder: sortOrder,
            isActive: isActive,
            isSystem: isSystem,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BadgesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({badgeAcquisitionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (badgeAcquisitionsRefs) db.badgeAcquisitions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (badgeAcquisitionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$BadgesTableReferences
                            ._badgeAcquisitionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BadgesTableReferences(db, table, p0)
                                .badgeAcquisitionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.badgeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BadgesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BadgesTable,
    Badge,
    $$BadgesTableFilterComposer,
    $$BadgesTableOrderingComposer,
    $$BadgesTableAnnotationComposer,
    $$BadgesTableCreateCompanionBuilder,
    $$BadgesTableUpdateCompanionBuilder,
    (Badge, $$BadgesTableReferences),
    Badge,
    PrefetchHooks Function({bool badgeAcquisitionsRefs})>;
typedef $$BadgeAcquisitionsTableCreateCompanionBuilder
    = BadgeAcquisitionsCompanion Function({
  Value<int> id,
  required int childId,
  required int badgeId,
  required String badgeSnapshot,
  required int bonusPointsAwarded,
  Value<int?> pointRecordId,
  Value<int?> triggerValue,
  Value<String?> note,
  Value<bool> isDeleted,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$BadgeAcquisitionsTableUpdateCompanionBuilder
    = BadgeAcquisitionsCompanion Function({
  Value<int> id,
  Value<int> childId,
  Value<int> badgeId,
  Value<String> badgeSnapshot,
  Value<int> bonusPointsAwarded,
  Value<int?> pointRecordId,
  Value<int?> triggerValue,
  Value<String?> note,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$BadgeAcquisitionsTableReferences extends BaseReferences<
    _$AppDatabase, $BadgeAcquisitionsTable, BadgeAcquisition> {
  $$BadgeAcquisitionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ChildrenTable _childIdTable(_$AppDatabase db) =>
      db.children.createAlias(
          $_aliasNameGenerator(db.badgeAcquisitions.childId, db.children.id));

  $$ChildrenTableProcessedTableManager? get childId {
    if ($_item.childId == null) return null;
    final manager = $$ChildrenTableTableManager($_db, $_db.children)
        .filter((f) => f.id($_item.childId!));
    final item = $_typedResult.readTableOrNull(_childIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BadgesTable _badgeIdTable(_$AppDatabase db) => db.badges.createAlias(
      $_aliasNameGenerator(db.badgeAcquisitions.badgeId, db.badges.id));

  $$BadgesTableProcessedTableManager? get badgeId {
    if ($_item.badgeId == null) return null;
    final manager = $$BadgesTableTableManager($_db, $_db.badges)
        .filter((f) => f.id($_item.badgeId!));
    final item = $_typedResult.readTableOrNull(_badgeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BadgeAcquisitionsTableFilterComposer
    extends Composer<_$AppDatabase, $BadgeAcquisitionsTable> {
  $$BadgeAcquisitionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get badgeSnapshot => $composableBuilder(
      column: $table.badgeSnapshot, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bonusPointsAwarded => $composableBuilder(
      column: $table.bonusPointsAwarded,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pointRecordId => $composableBuilder(
      column: $table.pointRecordId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get triggerValue => $composableBuilder(
      column: $table.triggerValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ChildrenTableFilterComposer get childId {
    final $$ChildrenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableFilterComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BadgesTableFilterComposer get badgeId {
    final $$BadgesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.badgeId,
        referencedTable: $db.badges,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BadgesTableFilterComposer(
              $db: $db,
              $table: $db.badges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BadgeAcquisitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $BadgeAcquisitionsTable> {
  $$BadgeAcquisitionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get badgeSnapshot => $composableBuilder(
      column: $table.badgeSnapshot,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bonusPointsAwarded => $composableBuilder(
      column: $table.bonusPointsAwarded,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pointRecordId => $composableBuilder(
      column: $table.pointRecordId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get triggerValue => $composableBuilder(
      column: $table.triggerValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ChildrenTableOrderingComposer get childId {
    final $$ChildrenTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableOrderingComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BadgesTableOrderingComposer get badgeId {
    final $$BadgesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.badgeId,
        referencedTable: $db.badges,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BadgesTableOrderingComposer(
              $db: $db,
              $table: $db.badges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BadgeAcquisitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BadgeAcquisitionsTable> {
  $$BadgeAcquisitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get badgeSnapshot => $composableBuilder(
      column: $table.badgeSnapshot, builder: (column) => column);

  GeneratedColumn<int> get bonusPointsAwarded => $composableBuilder(
      column: $table.bonusPointsAwarded, builder: (column) => column);

  GeneratedColumn<int> get pointRecordId => $composableBuilder(
      column: $table.pointRecordId, builder: (column) => column);

  GeneratedColumn<int> get triggerValue => $composableBuilder(
      column: $table.triggerValue, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ChildrenTableAnnotationComposer get childId {
    final $$ChildrenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableAnnotationComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BadgesTableAnnotationComposer get badgeId {
    final $$BadgesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.badgeId,
        referencedTable: $db.badges,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BadgesTableAnnotationComposer(
              $db: $db,
              $table: $db.badges,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BadgeAcquisitionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BadgeAcquisitionsTable,
    BadgeAcquisition,
    $$BadgeAcquisitionsTableFilterComposer,
    $$BadgeAcquisitionsTableOrderingComposer,
    $$BadgeAcquisitionsTableAnnotationComposer,
    $$BadgeAcquisitionsTableCreateCompanionBuilder,
    $$BadgeAcquisitionsTableUpdateCompanionBuilder,
    (BadgeAcquisition, $$BadgeAcquisitionsTableReferences),
    BadgeAcquisition,
    PrefetchHooks Function({bool childId, bool badgeId})> {
  $$BadgeAcquisitionsTableTableManager(
      _$AppDatabase db, $BadgeAcquisitionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BadgeAcquisitionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BadgeAcquisitionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BadgeAcquisitionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> childId = const Value.absent(),
            Value<int> badgeId = const Value.absent(),
            Value<String> badgeSnapshot = const Value.absent(),
            Value<int> bonusPointsAwarded = const Value.absent(),
            Value<int?> pointRecordId = const Value.absent(),
            Value<int?> triggerValue = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              BadgeAcquisitionsCompanion(
            id: id,
            childId: childId,
            badgeId: badgeId,
            badgeSnapshot: badgeSnapshot,
            bonusPointsAwarded: bonusPointsAwarded,
            pointRecordId: pointRecordId,
            triggerValue: triggerValue,
            note: note,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int childId,
            required int badgeId,
            required String badgeSnapshot,
            required int bonusPointsAwarded,
            Value<int?> pointRecordId = const Value.absent(),
            Value<int?> triggerValue = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              BadgeAcquisitionsCompanion.insert(
            id: id,
            childId: childId,
            badgeId: badgeId,
            badgeSnapshot: badgeSnapshot,
            bonusPointsAwarded: bonusPointsAwarded,
            pointRecordId: pointRecordId,
            triggerValue: triggerValue,
            note: note,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BadgeAcquisitionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({childId = false, badgeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (childId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.childId,
                    referencedTable:
                        $$BadgeAcquisitionsTableReferences._childIdTable(db),
                    referencedColumn:
                        $$BadgeAcquisitionsTableReferences._childIdTable(db).id,
                  ) as T;
                }
                if (badgeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.badgeId,
                    referencedTable:
                        $$BadgeAcquisitionsTableReferences._badgeIdTable(db),
                    referencedColumn:
                        $$BadgeAcquisitionsTableReferences._badgeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BadgeAcquisitionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BadgeAcquisitionsTable,
    BadgeAcquisition,
    $$BadgeAcquisitionsTableFilterComposer,
    $$BadgeAcquisitionsTableOrderingComposer,
    $$BadgeAcquisitionsTableAnnotationComposer,
    $$BadgeAcquisitionsTableCreateCompanionBuilder,
    $$BadgeAcquisitionsTableUpdateCompanionBuilder,
    (BadgeAcquisition, $$BadgeAcquisitionsTableReferences),
    BadgeAcquisition,
    PrefetchHooks Function({bool childId, bool badgeId})>;
typedef $$CheckinRecordsTableCreateCompanionBuilder = CheckinRecordsCompanion
    Function({
  Value<int> id,
  required int childId,
  required String checkinDate,
  required int streakDays,
  Value<int?> pointRecordId,
  Value<bool> isDeleted,
  required DateTime createdAt,
});
typedef $$CheckinRecordsTableUpdateCompanionBuilder = CheckinRecordsCompanion
    Function({
  Value<int> id,
  Value<int> childId,
  Value<String> checkinDate,
  Value<int> streakDays,
  Value<int?> pointRecordId,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
});

final class $$CheckinRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $CheckinRecordsTable, CheckinRecord> {
  $$CheckinRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ChildrenTable _childIdTable(_$AppDatabase db) =>
      db.children.createAlias(
          $_aliasNameGenerator(db.checkinRecords.childId, db.children.id));

  $$ChildrenTableProcessedTableManager? get childId {
    if ($_item.childId == null) return null;
    final manager = $$ChildrenTableTableManager($_db, $_db.children)
        .filter((f) => f.id($_item.childId!));
    final item = $_typedResult.readTableOrNull(_childIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CheckinRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $CheckinRecordsTable> {
  $$CheckinRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get checkinDate => $composableBuilder(
      column: $table.checkinDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pointRecordId => $composableBuilder(
      column: $table.pointRecordId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ChildrenTableFilterComposer get childId {
    final $$ChildrenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableFilterComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CheckinRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $CheckinRecordsTable> {
  $$CheckinRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get checkinDate => $composableBuilder(
      column: $table.checkinDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pointRecordId => $composableBuilder(
      column: $table.pointRecordId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ChildrenTableOrderingComposer get childId {
    final $$ChildrenTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableOrderingComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CheckinRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CheckinRecordsTable> {
  $$CheckinRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get checkinDate => $composableBuilder(
      column: $table.checkinDate, builder: (column) => column);

  GeneratedColumn<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => column);

  GeneratedColumn<int> get pointRecordId => $composableBuilder(
      column: $table.pointRecordId, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ChildrenTableAnnotationComposer get childId {
    final $$ChildrenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableAnnotationComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CheckinRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CheckinRecordsTable,
    CheckinRecord,
    $$CheckinRecordsTableFilterComposer,
    $$CheckinRecordsTableOrderingComposer,
    $$CheckinRecordsTableAnnotationComposer,
    $$CheckinRecordsTableCreateCompanionBuilder,
    $$CheckinRecordsTableUpdateCompanionBuilder,
    (CheckinRecord, $$CheckinRecordsTableReferences),
    CheckinRecord,
    PrefetchHooks Function({bool childId})> {
  $$CheckinRecordsTableTableManager(
      _$AppDatabase db, $CheckinRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckinRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckinRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckinRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> childId = const Value.absent(),
            Value<String> checkinDate = const Value.absent(),
            Value<int> streakDays = const Value.absent(),
            Value<int?> pointRecordId = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CheckinRecordsCompanion(
            id: id,
            childId: childId,
            checkinDate: checkinDate,
            streakDays: streakDays,
            pointRecordId: pointRecordId,
            isDeleted: isDeleted,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int childId,
            required String checkinDate,
            required int streakDays,
            Value<int?> pointRecordId = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required DateTime createdAt,
          }) =>
              CheckinRecordsCompanion.insert(
            id: id,
            childId: childId,
            checkinDate: checkinDate,
            streakDays: streakDays,
            pointRecordId: pointRecordId,
            isDeleted: isDeleted,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CheckinRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({childId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (childId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.childId,
                    referencedTable:
                        $$CheckinRecordsTableReferences._childIdTable(db),
                    referencedColumn:
                        $$CheckinRecordsTableReferences._childIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CheckinRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CheckinRecordsTable,
    CheckinRecord,
    $$CheckinRecordsTableFilterComposer,
    $$CheckinRecordsTableOrderingComposer,
    $$CheckinRecordsTableAnnotationComposer,
    $$CheckinRecordsTableCreateCompanionBuilder,
    $$CheckinRecordsTableUpdateCompanionBuilder,
    (CheckinRecord, $$CheckinRecordsTableReferences),
    CheckinRecord,
    PrefetchHooks Function({bool childId})>;
typedef $$IdiomsTableCreateCompanionBuilder = IdiomsCompanion Function({
  Value<int> id,
  required String word,
  required String pinyin,
  required String firstPinyinNoTone,
  required String lastPinyinNoTone,
  Value<String> firstPinyin,
  Value<String> lastPinyin,
  required String firstChar,
  required String lastChar,
  Value<String?> explanation,
  Value<String?> source,
  Value<String?> example,
  Value<int> gradeLevel,
  Value<int> frequency,
  Value<bool> isRare,
  Value<bool> isDeleted,
  required DateTime createdAt,
});
typedef $$IdiomsTableUpdateCompanionBuilder = IdiomsCompanion Function({
  Value<int> id,
  Value<String> word,
  Value<String> pinyin,
  Value<String> firstPinyinNoTone,
  Value<String> lastPinyinNoTone,
  Value<String> firstPinyin,
  Value<String> lastPinyin,
  Value<String> firstChar,
  Value<String> lastChar,
  Value<String?> explanation,
  Value<String?> source,
  Value<String?> example,
  Value<int> gradeLevel,
  Value<int> frequency,
  Value<bool> isRare,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
});

final class $$IdiomsTableReferences
    extends BaseReferences<_$AppDatabase, $IdiomsTable, Idiom> {
  $$IdiomsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$IdiomEngagementRecordsTable,
      List<IdiomEngagementRecord>> _idiomEngagementRecordsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.idiomEngagementRecords,
          aliasName: $_aliasNameGenerator(
              db.idioms.id, db.idiomEngagementRecords.idiomId));

  $$IdiomEngagementRecordsTableProcessedTableManager
      get idiomEngagementRecordsRefs {
    final manager = $$IdiomEngagementRecordsTableTableManager(
            $_db, $_db.idiomEngagementRecords)
        .filter((f) => f.idiomId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_idiomEngagementRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$IdiomsTableFilterComposer
    extends Composer<_$AppDatabase, $IdiomsTable> {
  $$IdiomsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pinyin => $composableBuilder(
      column: $table.pinyin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstPinyinNoTone => $composableBuilder(
      column: $table.firstPinyinNoTone,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastPinyinNoTone => $composableBuilder(
      column: $table.lastPinyinNoTone,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstPinyin => $composableBuilder(
      column: $table.firstPinyin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastPinyin => $composableBuilder(
      column: $table.lastPinyin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstChar => $composableBuilder(
      column: $table.firstChar, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastChar => $composableBuilder(
      column: $table.lastChar, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get example => $composableBuilder(
      column: $table.example, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get gradeLevel => $composableBuilder(
      column: $table.gradeLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRare => $composableBuilder(
      column: $table.isRare, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> idiomEngagementRecordsRefs(
      Expression<bool> Function($$IdiomEngagementRecordsTableFilterComposer f)
          f) {
    final $$IdiomEngagementRecordsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.idiomEngagementRecords,
            getReferencedColumn: (t) => t.idiomId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$IdiomEngagementRecordsTableFilterComposer(
                  $db: $db,
                  $table: $db.idiomEngagementRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$IdiomsTableOrderingComposer
    extends Composer<_$AppDatabase, $IdiomsTable> {
  $$IdiomsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pinyin => $composableBuilder(
      column: $table.pinyin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstPinyinNoTone => $composableBuilder(
      column: $table.firstPinyinNoTone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastPinyinNoTone => $composableBuilder(
      column: $table.lastPinyinNoTone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstPinyin => $composableBuilder(
      column: $table.firstPinyin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastPinyin => $composableBuilder(
      column: $table.lastPinyin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstChar => $composableBuilder(
      column: $table.firstChar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastChar => $composableBuilder(
      column: $table.lastChar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get example => $composableBuilder(
      column: $table.example, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get gradeLevel => $composableBuilder(
      column: $table.gradeLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRare => $composableBuilder(
      column: $table.isRare, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$IdiomsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IdiomsTable> {
  $$IdiomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get pinyin =>
      $composableBuilder(column: $table.pinyin, builder: (column) => column);

  GeneratedColumn<String> get firstPinyinNoTone => $composableBuilder(
      column: $table.firstPinyinNoTone, builder: (column) => column);

  GeneratedColumn<String> get lastPinyinNoTone => $composableBuilder(
      column: $table.lastPinyinNoTone, builder: (column) => column);

  GeneratedColumn<String> get firstPinyin => $composableBuilder(
      column: $table.firstPinyin, builder: (column) => column);

  GeneratedColumn<String> get lastPinyin => $composableBuilder(
      column: $table.lastPinyin, builder: (column) => column);

  GeneratedColumn<String> get firstChar =>
      $composableBuilder(column: $table.firstChar, builder: (column) => column);

  GeneratedColumn<String> get lastChar =>
      $composableBuilder(column: $table.lastChar, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get example =>
      $composableBuilder(column: $table.example, builder: (column) => column);

  GeneratedColumn<int> get gradeLevel => $composableBuilder(
      column: $table.gradeLevel, builder: (column) => column);

  GeneratedColumn<int> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<bool> get isRare =>
      $composableBuilder(column: $table.isRare, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> idiomEngagementRecordsRefs<T extends Object>(
      Expression<T> Function($$IdiomEngagementRecordsTableAnnotationComposer a)
          f) {
    final $$IdiomEngagementRecordsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.idiomEngagementRecords,
            getReferencedColumn: (t) => t.idiomId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$IdiomEngagementRecordsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.idiomEngagementRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$IdiomsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IdiomsTable,
    Idiom,
    $$IdiomsTableFilterComposer,
    $$IdiomsTableOrderingComposer,
    $$IdiomsTableAnnotationComposer,
    $$IdiomsTableCreateCompanionBuilder,
    $$IdiomsTableUpdateCompanionBuilder,
    (Idiom, $$IdiomsTableReferences),
    Idiom,
    PrefetchHooks Function({bool idiomEngagementRecordsRefs})> {
  $$IdiomsTableTableManager(_$AppDatabase db, $IdiomsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IdiomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IdiomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IdiomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> word = const Value.absent(),
            Value<String> pinyin = const Value.absent(),
            Value<String> firstPinyinNoTone = const Value.absent(),
            Value<String> lastPinyinNoTone = const Value.absent(),
            Value<String> firstPinyin = const Value.absent(),
            Value<String> lastPinyin = const Value.absent(),
            Value<String> firstChar = const Value.absent(),
            Value<String> lastChar = const Value.absent(),
            Value<String?> explanation = const Value.absent(),
            Value<String?> source = const Value.absent(),
            Value<String?> example = const Value.absent(),
            Value<int> gradeLevel = const Value.absent(),
            Value<int> frequency = const Value.absent(),
            Value<bool> isRare = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              IdiomsCompanion(
            id: id,
            word: word,
            pinyin: pinyin,
            firstPinyinNoTone: firstPinyinNoTone,
            lastPinyinNoTone: lastPinyinNoTone,
            firstPinyin: firstPinyin,
            lastPinyin: lastPinyin,
            firstChar: firstChar,
            lastChar: lastChar,
            explanation: explanation,
            source: source,
            example: example,
            gradeLevel: gradeLevel,
            frequency: frequency,
            isRare: isRare,
            isDeleted: isDeleted,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String word,
            required String pinyin,
            required String firstPinyinNoTone,
            required String lastPinyinNoTone,
            Value<String> firstPinyin = const Value.absent(),
            Value<String> lastPinyin = const Value.absent(),
            required String firstChar,
            required String lastChar,
            Value<String?> explanation = const Value.absent(),
            Value<String?> source = const Value.absent(),
            Value<String?> example = const Value.absent(),
            Value<int> gradeLevel = const Value.absent(),
            Value<int> frequency = const Value.absent(),
            Value<bool> isRare = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required DateTime createdAt,
          }) =>
              IdiomsCompanion.insert(
            id: id,
            word: word,
            pinyin: pinyin,
            firstPinyinNoTone: firstPinyinNoTone,
            lastPinyinNoTone: lastPinyinNoTone,
            firstPinyin: firstPinyin,
            lastPinyin: lastPinyin,
            firstChar: firstChar,
            lastChar: lastChar,
            explanation: explanation,
            source: source,
            example: example,
            gradeLevel: gradeLevel,
            frequency: frequency,
            isRare: isRare,
            isDeleted: isDeleted,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$IdiomsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({idiomEngagementRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (idiomEngagementRecordsRefs) db.idiomEngagementRecords
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (idiomEngagementRecordsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$IdiomsTableReferences
                            ._idiomEngagementRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$IdiomsTableReferences(db, table, p0)
                                .idiomEngagementRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.idiomId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$IdiomsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IdiomsTable,
    Idiom,
    $$IdiomsTableFilterComposer,
    $$IdiomsTableOrderingComposer,
    $$IdiomsTableAnnotationComposer,
    $$IdiomsTableCreateCompanionBuilder,
    $$IdiomsTableUpdateCompanionBuilder,
    (Idiom, $$IdiomsTableReferences),
    Idiom,
    PrefetchHooks Function({bool idiomEngagementRecordsRefs})>;
typedef $$IdiomGameSettingsTableCreateCompanionBuilder
    = IdiomGameSettingsCompanion Function({
  Value<int> id,
  required int childId,
  Value<int> currentGrade,
  Value<int?> customCountdown,
  Value<int?> customFreeHints,
  Value<int> matchMode,
  Value<bool> soundEnabled,
  Value<bool> includeRareIdioms,
  Value<bool> isDeleted,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$IdiomGameSettingsTableUpdateCompanionBuilder
    = IdiomGameSettingsCompanion Function({
  Value<int> id,
  Value<int> childId,
  Value<int> currentGrade,
  Value<int?> customCountdown,
  Value<int?> customFreeHints,
  Value<int> matchMode,
  Value<bool> soundEnabled,
  Value<bool> includeRareIdioms,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$IdiomGameSettingsTableReferences extends BaseReferences<
    _$AppDatabase, $IdiomGameSettingsTable, IdiomGameSetting> {
  $$IdiomGameSettingsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ChildrenTable _childIdTable(_$AppDatabase db) =>
      db.children.createAlias(
          $_aliasNameGenerator(db.idiomGameSettings.childId, db.children.id));

  $$ChildrenTableProcessedTableManager? get childId {
    if ($_item.childId == null) return null;
    final manager = $$ChildrenTableTableManager($_db, $_db.children)
        .filter((f) => f.id($_item.childId!));
    final item = $_typedResult.readTableOrNull(_childIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$IdiomGameSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $IdiomGameSettingsTable> {
  $$IdiomGameSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentGrade => $composableBuilder(
      column: $table.currentGrade, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get customCountdown => $composableBuilder(
      column: $table.customCountdown,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get customFreeHints => $composableBuilder(
      column: $table.customFreeHints,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get matchMode => $composableBuilder(
      column: $table.matchMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get soundEnabled => $composableBuilder(
      column: $table.soundEnabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get includeRareIdioms => $composableBuilder(
      column: $table.includeRareIdioms,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ChildrenTableFilterComposer get childId {
    final $$ChildrenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableFilterComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomGameSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $IdiomGameSettingsTable> {
  $$IdiomGameSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentGrade => $composableBuilder(
      column: $table.currentGrade,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get customCountdown => $composableBuilder(
      column: $table.customCountdown,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get customFreeHints => $composableBuilder(
      column: $table.customFreeHints,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get matchMode => $composableBuilder(
      column: $table.matchMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get soundEnabled => $composableBuilder(
      column: $table.soundEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get includeRareIdioms => $composableBuilder(
      column: $table.includeRareIdioms,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ChildrenTableOrderingComposer get childId {
    final $$ChildrenTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableOrderingComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomGameSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IdiomGameSettingsTable> {
  $$IdiomGameSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get currentGrade => $composableBuilder(
      column: $table.currentGrade, builder: (column) => column);

  GeneratedColumn<int> get customCountdown => $composableBuilder(
      column: $table.customCountdown, builder: (column) => column);

  GeneratedColumn<int> get customFreeHints => $composableBuilder(
      column: $table.customFreeHints, builder: (column) => column);

  GeneratedColumn<int> get matchMode =>
      $composableBuilder(column: $table.matchMode, builder: (column) => column);

  GeneratedColumn<bool> get soundEnabled => $composableBuilder(
      column: $table.soundEnabled, builder: (column) => column);

  GeneratedColumn<bool> get includeRareIdioms => $composableBuilder(
      column: $table.includeRareIdioms, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ChildrenTableAnnotationComposer get childId {
    final $$ChildrenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableAnnotationComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomGameSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IdiomGameSettingsTable,
    IdiomGameSetting,
    $$IdiomGameSettingsTableFilterComposer,
    $$IdiomGameSettingsTableOrderingComposer,
    $$IdiomGameSettingsTableAnnotationComposer,
    $$IdiomGameSettingsTableCreateCompanionBuilder,
    $$IdiomGameSettingsTableUpdateCompanionBuilder,
    (IdiomGameSetting, $$IdiomGameSettingsTableReferences),
    IdiomGameSetting,
    PrefetchHooks Function({bool childId})> {
  $$IdiomGameSettingsTableTableManager(
      _$AppDatabase db, $IdiomGameSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IdiomGameSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IdiomGameSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IdiomGameSettingsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> childId = const Value.absent(),
            Value<int> currentGrade = const Value.absent(),
            Value<int?> customCountdown = const Value.absent(),
            Value<int?> customFreeHints = const Value.absent(),
            Value<int> matchMode = const Value.absent(),
            Value<bool> soundEnabled = const Value.absent(),
            Value<bool> includeRareIdioms = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              IdiomGameSettingsCompanion(
            id: id,
            childId: childId,
            currentGrade: currentGrade,
            customCountdown: customCountdown,
            customFreeHints: customFreeHints,
            matchMode: matchMode,
            soundEnabled: soundEnabled,
            includeRareIdioms: includeRareIdioms,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int childId,
            Value<int> currentGrade = const Value.absent(),
            Value<int?> customCountdown = const Value.absent(),
            Value<int?> customFreeHints = const Value.absent(),
            Value<int> matchMode = const Value.absent(),
            Value<bool> soundEnabled = const Value.absent(),
            Value<bool> includeRareIdioms = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              IdiomGameSettingsCompanion.insert(
            id: id,
            childId: childId,
            currentGrade: currentGrade,
            customCountdown: customCountdown,
            customFreeHints: customFreeHints,
            matchMode: matchMode,
            soundEnabled: soundEnabled,
            includeRareIdioms: includeRareIdioms,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$IdiomGameSettingsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({childId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (childId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.childId,
                    referencedTable:
                        $$IdiomGameSettingsTableReferences._childIdTable(db),
                    referencedColumn:
                        $$IdiomGameSettingsTableReferences._childIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$IdiomGameSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IdiomGameSettingsTable,
    IdiomGameSetting,
    $$IdiomGameSettingsTableFilterComposer,
    $$IdiomGameSettingsTableOrderingComposer,
    $$IdiomGameSettingsTableAnnotationComposer,
    $$IdiomGameSettingsTableCreateCompanionBuilder,
    $$IdiomGameSettingsTableUpdateCompanionBuilder,
    (IdiomGameSetting, $$IdiomGameSettingsTableReferences),
    IdiomGameSetting,
    PrefetchHooks Function({bool childId})>;
typedef $$IdiomGameRecordsTableCreateCompanionBuilder
    = IdiomGameRecordsCompanion Function({
  Value<int> id,
  required int childId,
  required int grade,
  required int score,
  required int chainLength,
  required int duration,
  Value<int> hintsUsed,
  Value<int> fastAnswerCount,
  Value<int> rareIdiomCount,
  Value<int> playerTurns,
  Value<int> timeoutWarningCount,
  Value<bool> isAiSurrender,
  Value<int> comboMax,
  Value<int> starsEarned,
  Value<int> starRating,
  Value<String?> idiomChain,
  Value<bool> isDeleted,
  required DateTime playedAt,
  required DateTime createdAt,
});
typedef $$IdiomGameRecordsTableUpdateCompanionBuilder
    = IdiomGameRecordsCompanion Function({
  Value<int> id,
  Value<int> childId,
  Value<int> grade,
  Value<int> score,
  Value<int> chainLength,
  Value<int> duration,
  Value<int> hintsUsed,
  Value<int> fastAnswerCount,
  Value<int> rareIdiomCount,
  Value<int> playerTurns,
  Value<int> timeoutWarningCount,
  Value<bool> isAiSurrender,
  Value<int> comboMax,
  Value<int> starsEarned,
  Value<int> starRating,
  Value<String?> idiomChain,
  Value<bool> isDeleted,
  Value<DateTime> playedAt,
  Value<DateTime> createdAt,
});

final class $$IdiomGameRecordsTableReferences extends BaseReferences<
    _$AppDatabase, $IdiomGameRecordsTable, IdiomGameRecord> {
  $$IdiomGameRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ChildrenTable _childIdTable(_$AppDatabase db) =>
      db.children.createAlias(
          $_aliasNameGenerator(db.idiomGameRecords.childId, db.children.id));

  $$ChildrenTableProcessedTableManager? get childId {
    if ($_item.childId == null) return null;
    final manager = $$ChildrenTableTableManager($_db, $_db.children)
        .filter((f) => f.id($_item.childId!));
    final item = $_typedResult.readTableOrNull(_childIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$IdiomGameRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $IdiomGameRecordsTable> {
  $$IdiomGameRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get chainLength => $composableBuilder(
      column: $table.chainLength, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hintsUsed => $composableBuilder(
      column: $table.hintsUsed, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fastAnswerCount => $composableBuilder(
      column: $table.fastAnswerCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rareIdiomCount => $composableBuilder(
      column: $table.rareIdiomCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get playerTurns => $composableBuilder(
      column: $table.playerTurns, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeoutWarningCount => $composableBuilder(
      column: $table.timeoutWarningCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isAiSurrender => $composableBuilder(
      column: $table.isAiSurrender, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get comboMax => $composableBuilder(
      column: $table.comboMax, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get starsEarned => $composableBuilder(
      column: $table.starsEarned, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get starRating => $composableBuilder(
      column: $table.starRating, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get idiomChain => $composableBuilder(
      column: $table.idiomChain, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
      column: $table.playedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ChildrenTableFilterComposer get childId {
    final $$ChildrenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableFilterComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomGameRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $IdiomGameRecordsTable> {
  $$IdiomGameRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get chainLength => $composableBuilder(
      column: $table.chainLength, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hintsUsed => $composableBuilder(
      column: $table.hintsUsed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fastAnswerCount => $composableBuilder(
      column: $table.fastAnswerCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rareIdiomCount => $composableBuilder(
      column: $table.rareIdiomCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get playerTurns => $composableBuilder(
      column: $table.playerTurns, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeoutWarningCount => $composableBuilder(
      column: $table.timeoutWarningCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isAiSurrender => $composableBuilder(
      column: $table.isAiSurrender,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get comboMax => $composableBuilder(
      column: $table.comboMax, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get starsEarned => $composableBuilder(
      column: $table.starsEarned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get starRating => $composableBuilder(
      column: $table.starRating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get idiomChain => $composableBuilder(
      column: $table.idiomChain, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
      column: $table.playedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ChildrenTableOrderingComposer get childId {
    final $$ChildrenTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableOrderingComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomGameRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IdiomGameRecordsTable> {
  $$IdiomGameRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get chainLength => $composableBuilder(
      column: $table.chainLength, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<int> get hintsUsed =>
      $composableBuilder(column: $table.hintsUsed, builder: (column) => column);

  GeneratedColumn<int> get fastAnswerCount => $composableBuilder(
      column: $table.fastAnswerCount, builder: (column) => column);

  GeneratedColumn<int> get rareIdiomCount => $composableBuilder(
      column: $table.rareIdiomCount, builder: (column) => column);

  GeneratedColumn<int> get playerTurns => $composableBuilder(
      column: $table.playerTurns, builder: (column) => column);

  GeneratedColumn<int> get timeoutWarningCount => $composableBuilder(
      column: $table.timeoutWarningCount, builder: (column) => column);

  GeneratedColumn<bool> get isAiSurrender => $composableBuilder(
      column: $table.isAiSurrender, builder: (column) => column);

  GeneratedColumn<int> get comboMax =>
      $composableBuilder(column: $table.comboMax, builder: (column) => column);

  GeneratedColumn<int> get starsEarned => $composableBuilder(
      column: $table.starsEarned, builder: (column) => column);

  GeneratedColumn<int> get starRating => $composableBuilder(
      column: $table.starRating, builder: (column) => column);

  GeneratedColumn<String> get idiomChain => $composableBuilder(
      column: $table.idiomChain, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ChildrenTableAnnotationComposer get childId {
    final $$ChildrenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableAnnotationComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomGameRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IdiomGameRecordsTable,
    IdiomGameRecord,
    $$IdiomGameRecordsTableFilterComposer,
    $$IdiomGameRecordsTableOrderingComposer,
    $$IdiomGameRecordsTableAnnotationComposer,
    $$IdiomGameRecordsTableCreateCompanionBuilder,
    $$IdiomGameRecordsTableUpdateCompanionBuilder,
    (IdiomGameRecord, $$IdiomGameRecordsTableReferences),
    IdiomGameRecord,
    PrefetchHooks Function({bool childId})> {
  $$IdiomGameRecordsTableTableManager(
      _$AppDatabase db, $IdiomGameRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IdiomGameRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IdiomGameRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IdiomGameRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> childId = const Value.absent(),
            Value<int> grade = const Value.absent(),
            Value<int> score = const Value.absent(),
            Value<int> chainLength = const Value.absent(),
            Value<int> duration = const Value.absent(),
            Value<int> hintsUsed = const Value.absent(),
            Value<int> fastAnswerCount = const Value.absent(),
            Value<int> rareIdiomCount = const Value.absent(),
            Value<int> playerTurns = const Value.absent(),
            Value<int> timeoutWarningCount = const Value.absent(),
            Value<bool> isAiSurrender = const Value.absent(),
            Value<int> comboMax = const Value.absent(),
            Value<int> starsEarned = const Value.absent(),
            Value<int> starRating = const Value.absent(),
            Value<String?> idiomChain = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> playedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              IdiomGameRecordsCompanion(
            id: id,
            childId: childId,
            grade: grade,
            score: score,
            chainLength: chainLength,
            duration: duration,
            hintsUsed: hintsUsed,
            fastAnswerCount: fastAnswerCount,
            rareIdiomCount: rareIdiomCount,
            playerTurns: playerTurns,
            timeoutWarningCount: timeoutWarningCount,
            isAiSurrender: isAiSurrender,
            comboMax: comboMax,
            starsEarned: starsEarned,
            starRating: starRating,
            idiomChain: idiomChain,
            isDeleted: isDeleted,
            playedAt: playedAt,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int childId,
            required int grade,
            required int score,
            required int chainLength,
            required int duration,
            Value<int> hintsUsed = const Value.absent(),
            Value<int> fastAnswerCount = const Value.absent(),
            Value<int> rareIdiomCount = const Value.absent(),
            Value<int> playerTurns = const Value.absent(),
            Value<int> timeoutWarningCount = const Value.absent(),
            Value<bool> isAiSurrender = const Value.absent(),
            Value<int> comboMax = const Value.absent(),
            Value<int> starsEarned = const Value.absent(),
            Value<int> starRating = const Value.absent(),
            Value<String?> idiomChain = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required DateTime playedAt,
            required DateTime createdAt,
          }) =>
              IdiomGameRecordsCompanion.insert(
            id: id,
            childId: childId,
            grade: grade,
            score: score,
            chainLength: chainLength,
            duration: duration,
            hintsUsed: hintsUsed,
            fastAnswerCount: fastAnswerCount,
            rareIdiomCount: rareIdiomCount,
            playerTurns: playerTurns,
            timeoutWarningCount: timeoutWarningCount,
            isAiSurrender: isAiSurrender,
            comboMax: comboMax,
            starsEarned: starsEarned,
            starRating: starRating,
            idiomChain: idiomChain,
            isDeleted: isDeleted,
            playedAt: playedAt,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$IdiomGameRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({childId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (childId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.childId,
                    referencedTable:
                        $$IdiomGameRecordsTableReferences._childIdTable(db),
                    referencedColumn:
                        $$IdiomGameRecordsTableReferences._childIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$IdiomGameRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IdiomGameRecordsTable,
    IdiomGameRecord,
    $$IdiomGameRecordsTableFilterComposer,
    $$IdiomGameRecordsTableOrderingComposer,
    $$IdiomGameRecordsTableAnnotationComposer,
    $$IdiomGameRecordsTableCreateCompanionBuilder,
    $$IdiomGameRecordsTableUpdateCompanionBuilder,
    (IdiomGameRecord, $$IdiomGameRecordsTableReferences),
    IdiomGameRecord,
    PrefetchHooks Function({bool childId})>;
typedef $$IdiomGradeProgressTableCreateCompanionBuilder
    = IdiomGradeProgressCompanion Function({
  Value<int> id,
  required int childId,
  required int grade,
  Value<int> highScore,
  Value<int> bestChainLength,
  Value<int> starRating,
  Value<int> playCount,
  Value<bool> isUnlocked,
  Value<bool> isDeleted,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$IdiomGradeProgressTableUpdateCompanionBuilder
    = IdiomGradeProgressCompanion Function({
  Value<int> id,
  Value<int> childId,
  Value<int> grade,
  Value<int> highScore,
  Value<int> bestChainLength,
  Value<int> starRating,
  Value<int> playCount,
  Value<bool> isUnlocked,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$IdiomGradeProgressTableReferences extends BaseReferences<
    _$AppDatabase, $IdiomGradeProgressTable, IdiomGradeProgressData> {
  $$IdiomGradeProgressTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ChildrenTable _childIdTable(_$AppDatabase db) =>
      db.children.createAlias(
          $_aliasNameGenerator(db.idiomGradeProgress.childId, db.children.id));

  $$ChildrenTableProcessedTableManager? get childId {
    if ($_item.childId == null) return null;
    final manager = $$ChildrenTableTableManager($_db, $_db.children)
        .filter((f) => f.id($_item.childId!));
    final item = $_typedResult.readTableOrNull(_childIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$IdiomGradeProgressTableFilterComposer
    extends Composer<_$AppDatabase, $IdiomGradeProgressTable> {
  $$IdiomGradeProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get highScore => $composableBuilder(
      column: $table.highScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bestChainLength => $composableBuilder(
      column: $table.bestChainLength,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get starRating => $composableBuilder(
      column: $table.starRating, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get playCount => $composableBuilder(
      column: $table.playCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isUnlocked => $composableBuilder(
      column: $table.isUnlocked, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ChildrenTableFilterComposer get childId {
    final $$ChildrenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableFilterComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomGradeProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $IdiomGradeProgressTable> {
  $$IdiomGradeProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get highScore => $composableBuilder(
      column: $table.highScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bestChainLength => $composableBuilder(
      column: $table.bestChainLength,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get starRating => $composableBuilder(
      column: $table.starRating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get playCount => $composableBuilder(
      column: $table.playCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isUnlocked => $composableBuilder(
      column: $table.isUnlocked, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ChildrenTableOrderingComposer get childId {
    final $$ChildrenTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableOrderingComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomGradeProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $IdiomGradeProgressTable> {
  $$IdiomGradeProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<int> get highScore =>
      $composableBuilder(column: $table.highScore, builder: (column) => column);

  GeneratedColumn<int> get bestChainLength => $composableBuilder(
      column: $table.bestChainLength, builder: (column) => column);

  GeneratedColumn<int> get starRating => $composableBuilder(
      column: $table.starRating, builder: (column) => column);

  GeneratedColumn<int> get playCount =>
      $composableBuilder(column: $table.playCount, builder: (column) => column);

  GeneratedColumn<bool> get isUnlocked => $composableBuilder(
      column: $table.isUnlocked, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ChildrenTableAnnotationComposer get childId {
    final $$ChildrenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableAnnotationComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomGradeProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IdiomGradeProgressTable,
    IdiomGradeProgressData,
    $$IdiomGradeProgressTableFilterComposer,
    $$IdiomGradeProgressTableOrderingComposer,
    $$IdiomGradeProgressTableAnnotationComposer,
    $$IdiomGradeProgressTableCreateCompanionBuilder,
    $$IdiomGradeProgressTableUpdateCompanionBuilder,
    (IdiomGradeProgressData, $$IdiomGradeProgressTableReferences),
    IdiomGradeProgressData,
    PrefetchHooks Function({bool childId})> {
  $$IdiomGradeProgressTableTableManager(
      _$AppDatabase db, $IdiomGradeProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IdiomGradeProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IdiomGradeProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IdiomGradeProgressTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> childId = const Value.absent(),
            Value<int> grade = const Value.absent(),
            Value<int> highScore = const Value.absent(),
            Value<int> bestChainLength = const Value.absent(),
            Value<int> starRating = const Value.absent(),
            Value<int> playCount = const Value.absent(),
            Value<bool> isUnlocked = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              IdiomGradeProgressCompanion(
            id: id,
            childId: childId,
            grade: grade,
            highScore: highScore,
            bestChainLength: bestChainLength,
            starRating: starRating,
            playCount: playCount,
            isUnlocked: isUnlocked,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int childId,
            required int grade,
            Value<int> highScore = const Value.absent(),
            Value<int> bestChainLength = const Value.absent(),
            Value<int> starRating = const Value.absent(),
            Value<int> playCount = const Value.absent(),
            Value<bool> isUnlocked = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              IdiomGradeProgressCompanion.insert(
            id: id,
            childId: childId,
            grade: grade,
            highScore: highScore,
            bestChainLength: bestChainLength,
            starRating: starRating,
            playCount: playCount,
            isUnlocked: isUnlocked,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$IdiomGradeProgressTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({childId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (childId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.childId,
                    referencedTable:
                        $$IdiomGradeProgressTableReferences._childIdTable(db),
                    referencedColumn: $$IdiomGradeProgressTableReferences
                        ._childIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$IdiomGradeProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IdiomGradeProgressTable,
    IdiomGradeProgressData,
    $$IdiomGradeProgressTableFilterComposer,
    $$IdiomGradeProgressTableOrderingComposer,
    $$IdiomGradeProgressTableAnnotationComposer,
    $$IdiomGradeProgressTableCreateCompanionBuilder,
    $$IdiomGradeProgressTableUpdateCompanionBuilder,
    (IdiomGradeProgressData, $$IdiomGradeProgressTableReferences),
    IdiomGradeProgressData,
    PrefetchHooks Function({bool childId})>;
typedef $$IdiomFailureRecordsTableCreateCompanionBuilder
    = IdiomFailureRecordsCompanion Function({
  Value<int> id,
  required int childId,
  required String lastChar,
  Value<int> failCount,
  Value<int> successCount,
  required DateTime lastFailedAt,
  Value<DateTime?> lastSuccessAt,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$IdiomFailureRecordsTableUpdateCompanionBuilder
    = IdiomFailureRecordsCompanion Function({
  Value<int> id,
  Value<int> childId,
  Value<String> lastChar,
  Value<int> failCount,
  Value<int> successCount,
  Value<DateTime> lastFailedAt,
  Value<DateTime?> lastSuccessAt,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$IdiomFailureRecordsTableReferences extends BaseReferences<
    _$AppDatabase, $IdiomFailureRecordsTable, IdiomFailureRecord> {
  $$IdiomFailureRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ChildrenTable _childIdTable(_$AppDatabase db) =>
      db.children.createAlias(
          $_aliasNameGenerator(db.idiomFailureRecords.childId, db.children.id));

  $$ChildrenTableProcessedTableManager? get childId {
    if ($_item.childId == null) return null;
    final manager = $$ChildrenTableTableManager($_db, $_db.children)
        .filter((f) => f.id($_item.childId!));
    final item = $_typedResult.readTableOrNull(_childIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$IdiomFailureRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $IdiomFailureRecordsTable> {
  $$IdiomFailureRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastChar => $composableBuilder(
      column: $table.lastChar, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get failCount => $composableBuilder(
      column: $table.failCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get successCount => $composableBuilder(
      column: $table.successCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastFailedAt => $composableBuilder(
      column: $table.lastFailedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSuccessAt => $composableBuilder(
      column: $table.lastSuccessAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ChildrenTableFilterComposer get childId {
    final $$ChildrenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableFilterComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomFailureRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $IdiomFailureRecordsTable> {
  $$IdiomFailureRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastChar => $composableBuilder(
      column: $table.lastChar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get failCount => $composableBuilder(
      column: $table.failCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get successCount => $composableBuilder(
      column: $table.successCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastFailedAt => $composableBuilder(
      column: $table.lastFailedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSuccessAt => $composableBuilder(
      column: $table.lastSuccessAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ChildrenTableOrderingComposer get childId {
    final $$ChildrenTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableOrderingComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomFailureRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IdiomFailureRecordsTable> {
  $$IdiomFailureRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lastChar =>
      $composableBuilder(column: $table.lastChar, builder: (column) => column);

  GeneratedColumn<int> get failCount =>
      $composableBuilder(column: $table.failCount, builder: (column) => column);

  GeneratedColumn<int> get successCount => $composableBuilder(
      column: $table.successCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastFailedAt => $composableBuilder(
      column: $table.lastFailedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSuccessAt => $composableBuilder(
      column: $table.lastSuccessAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ChildrenTableAnnotationComposer get childId {
    final $$ChildrenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableAnnotationComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomFailureRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IdiomFailureRecordsTable,
    IdiomFailureRecord,
    $$IdiomFailureRecordsTableFilterComposer,
    $$IdiomFailureRecordsTableOrderingComposer,
    $$IdiomFailureRecordsTableAnnotationComposer,
    $$IdiomFailureRecordsTableCreateCompanionBuilder,
    $$IdiomFailureRecordsTableUpdateCompanionBuilder,
    (IdiomFailureRecord, $$IdiomFailureRecordsTableReferences),
    IdiomFailureRecord,
    PrefetchHooks Function({bool childId})> {
  $$IdiomFailureRecordsTableTableManager(
      _$AppDatabase db, $IdiomFailureRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IdiomFailureRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IdiomFailureRecordsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IdiomFailureRecordsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> childId = const Value.absent(),
            Value<String> lastChar = const Value.absent(),
            Value<int> failCount = const Value.absent(),
            Value<int> successCount = const Value.absent(),
            Value<DateTime> lastFailedAt = const Value.absent(),
            Value<DateTime?> lastSuccessAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              IdiomFailureRecordsCompanion(
            id: id,
            childId: childId,
            lastChar: lastChar,
            failCount: failCount,
            successCount: successCount,
            lastFailedAt: lastFailedAt,
            lastSuccessAt: lastSuccessAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int childId,
            required String lastChar,
            Value<int> failCount = const Value.absent(),
            Value<int> successCount = const Value.absent(),
            required DateTime lastFailedAt,
            Value<DateTime?> lastSuccessAt = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              IdiomFailureRecordsCompanion.insert(
            id: id,
            childId: childId,
            lastChar: lastChar,
            failCount: failCount,
            successCount: successCount,
            lastFailedAt: lastFailedAt,
            lastSuccessAt: lastSuccessAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$IdiomFailureRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({childId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (childId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.childId,
                    referencedTable:
                        $$IdiomFailureRecordsTableReferences._childIdTable(db),
                    referencedColumn: $$IdiomFailureRecordsTableReferences
                        ._childIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$IdiomFailureRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IdiomFailureRecordsTable,
    IdiomFailureRecord,
    $$IdiomFailureRecordsTableFilterComposer,
    $$IdiomFailureRecordsTableOrderingComposer,
    $$IdiomFailureRecordsTableAnnotationComposer,
    $$IdiomFailureRecordsTableCreateCompanionBuilder,
    $$IdiomFailureRecordsTableUpdateCompanionBuilder,
    (IdiomFailureRecord, $$IdiomFailureRecordsTableReferences),
    IdiomFailureRecord,
    PrefetchHooks Function({bool childId})>;
typedef $$IdiomPuzzleRecordsTableCreateCompanionBuilder
    = IdiomPuzzleRecordsCompanion Function({
  Value<int> id,
  required int childId,
  required String gameMode,
  required int grade,
  required int correctCount,
  required int totalCount,
  required int starsEarned,
  required int timeTakenSeconds,
  Value<bool> isDeleted,
  required DateTime playedAt,
  required DateTime createdAt,
});
typedef $$IdiomPuzzleRecordsTableUpdateCompanionBuilder
    = IdiomPuzzleRecordsCompanion Function({
  Value<int> id,
  Value<int> childId,
  Value<String> gameMode,
  Value<int> grade,
  Value<int> correctCount,
  Value<int> totalCount,
  Value<int> starsEarned,
  Value<int> timeTakenSeconds,
  Value<bool> isDeleted,
  Value<DateTime> playedAt,
  Value<DateTime> createdAt,
});

final class $$IdiomPuzzleRecordsTableReferences extends BaseReferences<
    _$AppDatabase, $IdiomPuzzleRecordsTable, IdiomPuzzleRecord> {
  $$IdiomPuzzleRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ChildrenTable _childIdTable(_$AppDatabase db) =>
      db.children.createAlias(
          $_aliasNameGenerator(db.idiomPuzzleRecords.childId, db.children.id));

  $$ChildrenTableProcessedTableManager? get childId {
    if ($_item.childId == null) return null;
    final manager = $$ChildrenTableTableManager($_db, $_db.children)
        .filter((f) => f.id($_item.childId!));
    final item = $_typedResult.readTableOrNull(_childIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$IdiomPuzzleRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $IdiomPuzzleRecordsTable> {
  $$IdiomPuzzleRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gameMode => $composableBuilder(
      column: $table.gameMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get correctCount => $composableBuilder(
      column: $table.correctCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalCount => $composableBuilder(
      column: $table.totalCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get starsEarned => $composableBuilder(
      column: $table.starsEarned, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeTakenSeconds => $composableBuilder(
      column: $table.timeTakenSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
      column: $table.playedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ChildrenTableFilterComposer get childId {
    final $$ChildrenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableFilterComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomPuzzleRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $IdiomPuzzleRecordsTable> {
  $$IdiomPuzzleRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gameMode => $composableBuilder(
      column: $table.gameMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get correctCount => $composableBuilder(
      column: $table.correctCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalCount => $composableBuilder(
      column: $table.totalCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get starsEarned => $composableBuilder(
      column: $table.starsEarned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeTakenSeconds => $composableBuilder(
      column: $table.timeTakenSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
      column: $table.playedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ChildrenTableOrderingComposer get childId {
    final $$ChildrenTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableOrderingComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomPuzzleRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IdiomPuzzleRecordsTable> {
  $$IdiomPuzzleRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gameMode =>
      $composableBuilder(column: $table.gameMode, builder: (column) => column);

  GeneratedColumn<int> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<int> get correctCount => $composableBuilder(
      column: $table.correctCount, builder: (column) => column);

  GeneratedColumn<int> get totalCount => $composableBuilder(
      column: $table.totalCount, builder: (column) => column);

  GeneratedColumn<int> get starsEarned => $composableBuilder(
      column: $table.starsEarned, builder: (column) => column);

  GeneratedColumn<int> get timeTakenSeconds => $composableBuilder(
      column: $table.timeTakenSeconds, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ChildrenTableAnnotationComposer get childId {
    final $$ChildrenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableAnnotationComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomPuzzleRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IdiomPuzzleRecordsTable,
    IdiomPuzzleRecord,
    $$IdiomPuzzleRecordsTableFilterComposer,
    $$IdiomPuzzleRecordsTableOrderingComposer,
    $$IdiomPuzzleRecordsTableAnnotationComposer,
    $$IdiomPuzzleRecordsTableCreateCompanionBuilder,
    $$IdiomPuzzleRecordsTableUpdateCompanionBuilder,
    (IdiomPuzzleRecord, $$IdiomPuzzleRecordsTableReferences),
    IdiomPuzzleRecord,
    PrefetchHooks Function({bool childId})> {
  $$IdiomPuzzleRecordsTableTableManager(
      _$AppDatabase db, $IdiomPuzzleRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IdiomPuzzleRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IdiomPuzzleRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IdiomPuzzleRecordsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> childId = const Value.absent(),
            Value<String> gameMode = const Value.absent(),
            Value<int> grade = const Value.absent(),
            Value<int> correctCount = const Value.absent(),
            Value<int> totalCount = const Value.absent(),
            Value<int> starsEarned = const Value.absent(),
            Value<int> timeTakenSeconds = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> playedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              IdiomPuzzleRecordsCompanion(
            id: id,
            childId: childId,
            gameMode: gameMode,
            grade: grade,
            correctCount: correctCount,
            totalCount: totalCount,
            starsEarned: starsEarned,
            timeTakenSeconds: timeTakenSeconds,
            isDeleted: isDeleted,
            playedAt: playedAt,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int childId,
            required String gameMode,
            required int grade,
            required int correctCount,
            required int totalCount,
            required int starsEarned,
            required int timeTakenSeconds,
            Value<bool> isDeleted = const Value.absent(),
            required DateTime playedAt,
            required DateTime createdAt,
          }) =>
              IdiomPuzzleRecordsCompanion.insert(
            id: id,
            childId: childId,
            gameMode: gameMode,
            grade: grade,
            correctCount: correctCount,
            totalCount: totalCount,
            starsEarned: starsEarned,
            timeTakenSeconds: timeTakenSeconds,
            isDeleted: isDeleted,
            playedAt: playedAt,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$IdiomPuzzleRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({childId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (childId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.childId,
                    referencedTable:
                        $$IdiomPuzzleRecordsTableReferences._childIdTable(db),
                    referencedColumn: $$IdiomPuzzleRecordsTableReferences
                        ._childIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$IdiomPuzzleRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IdiomPuzzleRecordsTable,
    IdiomPuzzleRecord,
    $$IdiomPuzzleRecordsTableFilterComposer,
    $$IdiomPuzzleRecordsTableOrderingComposer,
    $$IdiomPuzzleRecordsTableAnnotationComposer,
    $$IdiomPuzzleRecordsTableCreateCompanionBuilder,
    $$IdiomPuzzleRecordsTableUpdateCompanionBuilder,
    (IdiomPuzzleRecord, $$IdiomPuzzleRecordsTableReferences),
    IdiomPuzzleRecord,
    PrefetchHooks Function({bool childId})>;
typedef $$IdiomEngagementRecordsTableCreateCompanionBuilder
    = IdiomEngagementRecordsCompanion Function({
  Value<int> id,
  required int childId,
  required int idiomId,
  Value<int> encounterCount,
  Value<int> correctCount,
  Value<int> failCount,
  required DateTime lastEncounteredAt,
  Value<DateTime?> lastWrongAt,
  Value<int> masteryLevel,
  Value<int> consecutiveCorrect,
});
typedef $$IdiomEngagementRecordsTableUpdateCompanionBuilder
    = IdiomEngagementRecordsCompanion Function({
  Value<int> id,
  Value<int> childId,
  Value<int> idiomId,
  Value<int> encounterCount,
  Value<int> correctCount,
  Value<int> failCount,
  Value<DateTime> lastEncounteredAt,
  Value<DateTime?> lastWrongAt,
  Value<int> masteryLevel,
  Value<int> consecutiveCorrect,
});

final class $$IdiomEngagementRecordsTableReferences extends BaseReferences<
    _$AppDatabase, $IdiomEngagementRecordsTable, IdiomEngagementRecord> {
  $$IdiomEngagementRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ChildrenTable _childIdTable(_$AppDatabase db) =>
      db.children.createAlias($_aliasNameGenerator(
          db.idiomEngagementRecords.childId, db.children.id));

  $$ChildrenTableProcessedTableManager? get childId {
    if ($_item.childId == null) return null;
    final manager = $$ChildrenTableTableManager($_db, $_db.children)
        .filter((f) => f.id($_item.childId!));
    final item = $_typedResult.readTableOrNull(_childIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $IdiomsTable _idiomIdTable(_$AppDatabase db) => db.idioms.createAlias(
      $_aliasNameGenerator(db.idiomEngagementRecords.idiomId, db.idioms.id));

  $$IdiomsTableProcessedTableManager? get idiomId {
    if ($_item.idiomId == null) return null;
    final manager = $$IdiomsTableTableManager($_db, $_db.idioms)
        .filter((f) => f.id($_item.idiomId!));
    final item = $_typedResult.readTableOrNull(_idiomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$IdiomEngagementRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $IdiomEngagementRecordsTable> {
  $$IdiomEngagementRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get encounterCount => $composableBuilder(
      column: $table.encounterCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get correctCount => $composableBuilder(
      column: $table.correctCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get failCount => $composableBuilder(
      column: $table.failCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastEncounteredAt => $composableBuilder(
      column: $table.lastEncounteredAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastWrongAt => $composableBuilder(
      column: $table.lastWrongAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get masteryLevel => $composableBuilder(
      column: $table.masteryLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get consecutiveCorrect => $composableBuilder(
      column: $table.consecutiveCorrect,
      builder: (column) => ColumnFilters(column));

  $$ChildrenTableFilterComposer get childId {
    final $$ChildrenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableFilterComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$IdiomsTableFilterComposer get idiomId {
    final $$IdiomsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idiomId,
        referencedTable: $db.idioms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IdiomsTableFilterComposer(
              $db: $db,
              $table: $db.idioms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomEngagementRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $IdiomEngagementRecordsTable> {
  $$IdiomEngagementRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get encounterCount => $composableBuilder(
      column: $table.encounterCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get correctCount => $composableBuilder(
      column: $table.correctCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get failCount => $composableBuilder(
      column: $table.failCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastEncounteredAt => $composableBuilder(
      column: $table.lastEncounteredAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastWrongAt => $composableBuilder(
      column: $table.lastWrongAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get masteryLevel => $composableBuilder(
      column: $table.masteryLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get consecutiveCorrect => $composableBuilder(
      column: $table.consecutiveCorrect,
      builder: (column) => ColumnOrderings(column));

  $$ChildrenTableOrderingComposer get childId {
    final $$ChildrenTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableOrderingComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$IdiomsTableOrderingComposer get idiomId {
    final $$IdiomsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idiomId,
        referencedTable: $db.idioms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IdiomsTableOrderingComposer(
              $db: $db,
              $table: $db.idioms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomEngagementRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IdiomEngagementRecordsTable> {
  $$IdiomEngagementRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get encounterCount => $composableBuilder(
      column: $table.encounterCount, builder: (column) => column);

  GeneratedColumn<int> get correctCount => $composableBuilder(
      column: $table.correctCount, builder: (column) => column);

  GeneratedColumn<int> get failCount =>
      $composableBuilder(column: $table.failCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastEncounteredAt => $composableBuilder(
      column: $table.lastEncounteredAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastWrongAt => $composableBuilder(
      column: $table.lastWrongAt, builder: (column) => column);

  GeneratedColumn<int> get masteryLevel => $composableBuilder(
      column: $table.masteryLevel, builder: (column) => column);

  GeneratedColumn<int> get consecutiveCorrect => $composableBuilder(
      column: $table.consecutiveCorrect, builder: (column) => column);

  $$ChildrenTableAnnotationComposer get childId {
    final $$ChildrenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.childId,
        referencedTable: $db.children,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChildrenTableAnnotationComposer(
              $db: $db,
              $table: $db.children,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$IdiomsTableAnnotationComposer get idiomId {
    final $$IdiomsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idiomId,
        referencedTable: $db.idioms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IdiomsTableAnnotationComposer(
              $db: $db,
              $table: $db.idioms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IdiomEngagementRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IdiomEngagementRecordsTable,
    IdiomEngagementRecord,
    $$IdiomEngagementRecordsTableFilterComposer,
    $$IdiomEngagementRecordsTableOrderingComposer,
    $$IdiomEngagementRecordsTableAnnotationComposer,
    $$IdiomEngagementRecordsTableCreateCompanionBuilder,
    $$IdiomEngagementRecordsTableUpdateCompanionBuilder,
    (IdiomEngagementRecord, $$IdiomEngagementRecordsTableReferences),
    IdiomEngagementRecord,
    PrefetchHooks Function({bool childId, bool idiomId})> {
  $$IdiomEngagementRecordsTableTableManager(
      _$AppDatabase db, $IdiomEngagementRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IdiomEngagementRecordsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$IdiomEngagementRecordsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IdiomEngagementRecordsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> childId = const Value.absent(),
            Value<int> idiomId = const Value.absent(),
            Value<int> encounterCount = const Value.absent(),
            Value<int> correctCount = const Value.absent(),
            Value<int> failCount = const Value.absent(),
            Value<DateTime> lastEncounteredAt = const Value.absent(),
            Value<DateTime?> lastWrongAt = const Value.absent(),
            Value<int> masteryLevel = const Value.absent(),
            Value<int> consecutiveCorrect = const Value.absent(),
          }) =>
              IdiomEngagementRecordsCompanion(
            id: id,
            childId: childId,
            idiomId: idiomId,
            encounterCount: encounterCount,
            correctCount: correctCount,
            failCount: failCount,
            lastEncounteredAt: lastEncounteredAt,
            lastWrongAt: lastWrongAt,
            masteryLevel: masteryLevel,
            consecutiveCorrect: consecutiveCorrect,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int childId,
            required int idiomId,
            Value<int> encounterCount = const Value.absent(),
            Value<int> correctCount = const Value.absent(),
            Value<int> failCount = const Value.absent(),
            required DateTime lastEncounteredAt,
            Value<DateTime?> lastWrongAt = const Value.absent(),
            Value<int> masteryLevel = const Value.absent(),
            Value<int> consecutiveCorrect = const Value.absent(),
          }) =>
              IdiomEngagementRecordsCompanion.insert(
            id: id,
            childId: childId,
            idiomId: idiomId,
            encounterCount: encounterCount,
            correctCount: correctCount,
            failCount: failCount,
            lastEncounteredAt: lastEncounteredAt,
            lastWrongAt: lastWrongAt,
            masteryLevel: masteryLevel,
            consecutiveCorrect: consecutiveCorrect,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$IdiomEngagementRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({childId = false, idiomId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (childId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.childId,
                    referencedTable: $$IdiomEngagementRecordsTableReferences
                        ._childIdTable(db),
                    referencedColumn: $$IdiomEngagementRecordsTableReferences
                        ._childIdTable(db)
                        .id,
                  ) as T;
                }
                if (idiomId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idiomId,
                    referencedTable: $$IdiomEngagementRecordsTableReferences
                        ._idiomIdTable(db),
                    referencedColumn: $$IdiomEngagementRecordsTableReferences
                        ._idiomIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$IdiomEngagementRecordsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $IdiomEngagementRecordsTable,
        IdiomEngagementRecord,
        $$IdiomEngagementRecordsTableFilterComposer,
        $$IdiomEngagementRecordsTableOrderingComposer,
        $$IdiomEngagementRecordsTableAnnotationComposer,
        $$IdiomEngagementRecordsTableCreateCompanionBuilder,
        $$IdiomEngagementRecordsTableUpdateCompanionBuilder,
        (IdiomEngagementRecord, $$IdiomEngagementRecordsTableReferences),
        IdiomEngagementRecord,
        PrefetchHooks Function({bool childId, bool idiomId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ChildrenTableTableManager get children =>
      $$ChildrenTableTableManager(_db, _db.children);
  $$RulesTableTableManager get rules =>
      $$RulesTableTableManager(_db, _db.rules);
  $$RewardsTableTableManager get rewards =>
      $$RewardsTableTableManager(_db, _db.rewards);
  $$ExchangesTableTableManager get exchanges =>
      $$ExchangesTableTableManager(_db, _db.exchanges);
  $$PointRecordsTableTableManager get pointRecords =>
      $$PointRecordsTableTableManager(_db, _db.pointRecords);
  $$AppContentsTableTableManager get appContents =>
      $$AppContentsTableTableManager(_db, _db.appContents);
  $$AppLogsTableTableManager get appLogs =>
      $$AppLogsTableTableManager(_db, _db.appLogs);
  $$BadgesTableTableManager get badges =>
      $$BadgesTableTableManager(_db, _db.badges);
  $$BadgeAcquisitionsTableTableManager get badgeAcquisitions =>
      $$BadgeAcquisitionsTableTableManager(_db, _db.badgeAcquisitions);
  $$CheckinRecordsTableTableManager get checkinRecords =>
      $$CheckinRecordsTableTableManager(_db, _db.checkinRecords);
  $$IdiomsTableTableManager get idioms =>
      $$IdiomsTableTableManager(_db, _db.idioms);
  $$IdiomGameSettingsTableTableManager get idiomGameSettings =>
      $$IdiomGameSettingsTableTableManager(_db, _db.idiomGameSettings);
  $$IdiomGameRecordsTableTableManager get idiomGameRecords =>
      $$IdiomGameRecordsTableTableManager(_db, _db.idiomGameRecords);
  $$IdiomGradeProgressTableTableManager get idiomGradeProgress =>
      $$IdiomGradeProgressTableTableManager(_db, _db.idiomGradeProgress);
  $$IdiomFailureRecordsTableTableManager get idiomFailureRecords =>
      $$IdiomFailureRecordsTableTableManager(_db, _db.idiomFailureRecords);
  $$IdiomPuzzleRecordsTableTableManager get idiomPuzzleRecords =>
      $$IdiomPuzzleRecordsTableTableManager(_db, _db.idiomPuzzleRecords);
  $$IdiomEngagementRecordsTableTableManager get idiomEngagementRecords =>
      $$IdiomEngagementRecordsTableTableManager(
          _db, _db.idiomEngagementRecords);
}
