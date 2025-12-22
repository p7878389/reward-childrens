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
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [children, rules, rewards, exchanges, pointRecords, appContents, appLogs];
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
        {bool rulesRefs, bool exchangesRefs, bool pointRecordsRefs})> {
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
              pointRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (rulesRefs) db.rules,
                if (exchangesRefs) db.exchanges,
                if (pointRecordsRefs) db.pointRecords
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
        {bool rulesRefs, bool exchangesRefs, bool pointRecordsRefs})>;
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
}
