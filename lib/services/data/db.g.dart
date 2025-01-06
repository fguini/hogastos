// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $CategoryTable extends Category
    with TableInfo<$CategoryTable, Categories> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<material.Color> color =
      GeneratedColumn<material.Color>('color', aliasedName, false,
          type: const ColorColumn(), requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<material.IconData> icon =
      GeneratedColumn<material.IconData>('icon', aliasedName, false,
          type: const IconDataColumn(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, description, color, icon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category';
  @override
  VerificationContext validateIntegrity(Insertable<Categories> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categories map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Categories(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      color: attachedDatabase.typeMapping
          .read(const ColorColumn(), data['${effectivePrefix}color'])!,
      icon: attachedDatabase.typeMapping
          .read(const IconDataColumn(), data['${effectivePrefix}icon'])!,
    );
  }

  @override
  $CategoryTable createAlias(String alias) {
    return $CategoryTable(attachedDatabase, alias);
  }
}

class Categories extends DataClass implements Insertable<Categories> {
  final int id;
  final String description;
  final material.Color color;
  final material.IconData icon;
  const Categories(
      {required this.id,
      required this.description,
      required this.color,
      required this.icon});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['description'] = Variable<String>(description);
    map['color'] = Variable<material.Color>(color, const ColorColumn());
    map['icon'] = Variable<material.IconData>(icon, const IconDataColumn());
    return map;
  }

  CategoryCompanion toCompanion(bool nullToAbsent) {
    return CategoryCompanion(
      id: Value(id),
      description: Value(description),
      color: Value(color),
      icon: Value(icon),
    );
  }

  factory Categories.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categories(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      color: serializer.fromJson<material.Color>(json['color']),
      icon: serializer.fromJson<material.IconData>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String>(description),
      'color': serializer.toJson<material.Color>(color),
      'icon': serializer.toJson<material.IconData>(icon),
    };
  }

  Categories copyWith(
          {int? id,
          String? description,
          material.Color? color,
          material.IconData? icon}) =>
      Categories(
        id: id ?? this.id,
        description: description ?? this.description,
        color: color ?? this.color,
        icon: icon ?? this.icon,
      );
  Categories copyWithCompanion(CategoryCompanion data) {
    return Categories(
      id: data.id.present ? data.id.value : this.id,
      description:
          data.description.present ? data.description.value : this.description,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Categories(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('color: $color, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, description, color, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categories &&
          other.id == this.id &&
          other.description == this.description &&
          other.color == this.color &&
          other.icon == this.icon);
}

class CategoryCompanion extends UpdateCompanion<Categories> {
  final Value<int> id;
  final Value<String> description;
  final Value<material.Color> color;
  final Value<material.IconData> icon;
  const CategoryCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
  });
  CategoryCompanion.insert({
    this.id = const Value.absent(),
    required String description,
    required material.Color color,
    required material.IconData icon,
  })  : description = Value(description),
        color = Value(color),
        icon = Value(icon);
  static Insertable<Categories> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<material.Color>? color,
    Expression<material.IconData>? icon,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
    });
  }

  CategoryCompanion copyWith(
      {Value<int>? id,
      Value<String>? description,
      Value<material.Color>? color,
      Value<material.IconData>? icon}) {
    return CategoryCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (color.present) {
      map['color'] = Variable<material.Color>(color.value, const ColorColumn());
    }
    if (icon.present) {
      map['icon'] =
          Variable<material.IconData>(icon.value, const IconDataColumn());
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('color: $color, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }
}

class $MovementTable extends Movement
    with TableInfo<$MovementTable, Movements> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovementTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<MovementType> type = GeneratedColumn<MovementType>(
      'type', aliasedName, false,
      type: const MovementTypeColumn(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, date, description, amount, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movement';
  @override
  VerificationContext validateIntegrity(Insertable<Movements> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Movements map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Movements(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      type: attachedDatabase.typeMapping
          .read(const MovementTypeColumn(), data['${effectivePrefix}type'])!,
    );
  }

  @override
  $MovementTable createAlias(String alias) {
    return $MovementTable(attachedDatabase, alias);
  }
}

class Movements extends DataClass implements Insertable<Movements> {
  final int id;
  final DateTime date;
  final String description;
  final double amount;
  final MovementType type;
  const Movements(
      {required this.id,
      required this.date,
      required this.description,
      required this.amount,
      required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['description'] = Variable<String>(description);
    map['amount'] = Variable<double>(amount);
    map['type'] = Variable<MovementType>(type, const MovementTypeColumn());
    return map;
  }

  MovementCompanion toCompanion(bool nullToAbsent) {
    return MovementCompanion(
      id: Value(id),
      date: Value(date),
      description: Value(description),
      amount: Value(amount),
      type: Value(type),
    );
  }

  factory Movements.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Movements(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
      type: serializer.fromJson<MovementType>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String>(description),
      'amount': serializer.toJson<double>(amount),
      'type': serializer.toJson<MovementType>(type),
    };
  }

  Movements copyWith(
          {int? id,
          DateTime? date,
          String? description,
          double? amount,
          MovementType? type}) =>
      Movements(
        id: id ?? this.id,
        date: date ?? this.date,
        description: description ?? this.description,
        amount: amount ?? this.amount,
        type: type ?? this.type,
      );
  Movements copyWithCompanion(MovementCompanion data) {
    return Movements(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      description:
          data.description.present ? data.description.value : this.description,
      amount: data.amount.present ? data.amount.value : this.amount,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Movements(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, description, amount, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Movements &&
          other.id == this.id &&
          other.date == this.date &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.type == this.type);
}

class MovementCompanion extends UpdateCompanion<Movements> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> description;
  final Value<double> amount;
  final Value<MovementType> type;
  const MovementCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.type = const Value.absent(),
  });
  MovementCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String description,
    required double amount,
    required MovementType type,
  })  : date = Value(date),
        description = Value(description),
        amount = Value(amount),
        type = Value(type);
  static Insertable<Movements> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<double>? amount,
    Expression<MovementType>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (type != null) 'type': type,
    });
  }

  MovementCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<String>? description,
      Value<double>? amount,
      Value<MovementType>? type}) {
    return MovementCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (type.present) {
      map['type'] =
          Variable<MovementType>(type.value, const MovementTypeColumn());
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovementCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

abstract class _$Db extends GeneratedDatabase {
  _$Db(QueryExecutor e) : super(e);
  $DbManager get managers => $DbManager(this);
  late final $CategoryTable category = $CategoryTable(this);
  late final $MovementTable movement = $MovementTable(this);
  late final Index categoryId =
      Index('category_id', 'CREATE INDEX category_id ON category (id)');
  late final Index movementId =
      Index('movement_id', 'CREATE INDEX movement_id ON movement (id)');
  late final Index movementDate =
      Index('movement_date', 'CREATE INDEX movement_date ON movement (date)');
  late final Index movementType =
      Index('movement_type', 'CREATE INDEX movement_type ON movement (type)');
  late final Index movementDateType = Index('movement_date_type',
      'CREATE INDEX movement_date_type ON movement (date, type)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        category,
        movement,
        categoryId,
        movementId,
        movementDate,
        movementType,
        movementDateType
      ];
}

typedef $$CategoryTableCreateCompanionBuilder = CategoryCompanion Function({
  Value<int> id,
  required String description,
  required material.Color color,
  required material.IconData icon,
});
typedef $$CategoryTableUpdateCompanionBuilder = CategoryCompanion Function({
  Value<int> id,
  Value<String> description,
  Value<material.Color> color,
  Value<material.IconData> icon,
});

class $$CategoryTableFilterComposer extends Composer<_$Db, $CategoryTable> {
  $$CategoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<material.Color> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<material.IconData> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));
}

class $$CategoryTableOrderingComposer extends Composer<_$Db, $CategoryTable> {
  $$CategoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<material.Color> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<material.IconData> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));
}

class $$CategoryTableAnnotationComposer extends Composer<_$Db, $CategoryTable> {
  $$CategoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<material.Color> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<material.IconData> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);
}

class $$CategoryTableTableManager extends RootTableManager<
    _$Db,
    $CategoryTable,
    Categories,
    $$CategoryTableFilterComposer,
    $$CategoryTableOrderingComposer,
    $$CategoryTableAnnotationComposer,
    $$CategoryTableCreateCompanionBuilder,
    $$CategoryTableUpdateCompanionBuilder,
    (Categories, BaseReferences<_$Db, $CategoryTable, Categories>),
    Categories,
    PrefetchHooks Function()> {
  $$CategoryTableTableManager(_$Db db, $CategoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<material.Color> color = const Value.absent(),
            Value<material.IconData> icon = const Value.absent(),
          }) =>
              CategoryCompanion(
            id: id,
            description: description,
            color: color,
            icon: icon,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String description,
            required material.Color color,
            required material.IconData icon,
          }) =>
              CategoryCompanion.insert(
            id: id,
            description: description,
            color: color,
            icon: icon,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoryTableProcessedTableManager = ProcessedTableManager<
    _$Db,
    $CategoryTable,
    Categories,
    $$CategoryTableFilterComposer,
    $$CategoryTableOrderingComposer,
    $$CategoryTableAnnotationComposer,
    $$CategoryTableCreateCompanionBuilder,
    $$CategoryTableUpdateCompanionBuilder,
    (Categories, BaseReferences<_$Db, $CategoryTable, Categories>),
    Categories,
    PrefetchHooks Function()>;
typedef $$MovementTableCreateCompanionBuilder = MovementCompanion Function({
  Value<int> id,
  required DateTime date,
  required String description,
  required double amount,
  required MovementType type,
});
typedef $$MovementTableUpdateCompanionBuilder = MovementCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<String> description,
  Value<double> amount,
  Value<MovementType> type,
});

class $$MovementTableFilterComposer extends Composer<_$Db, $MovementTable> {
  $$MovementTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<MovementType> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));
}

class $$MovementTableOrderingComposer extends Composer<_$Db, $MovementTable> {
  $$MovementTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<MovementType> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));
}

class $$MovementTableAnnotationComposer extends Composer<_$Db, $MovementTable> {
  $$MovementTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<MovementType> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);
}

class $$MovementTableTableManager extends RootTableManager<
    _$Db,
    $MovementTable,
    Movements,
    $$MovementTableFilterComposer,
    $$MovementTableOrderingComposer,
    $$MovementTableAnnotationComposer,
    $$MovementTableCreateCompanionBuilder,
    $$MovementTableUpdateCompanionBuilder,
    (Movements, BaseReferences<_$Db, $MovementTable, Movements>),
    Movements,
    PrefetchHooks Function()> {
  $$MovementTableTableManager(_$Db db, $MovementTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovementTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovementTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovementTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<MovementType> type = const Value.absent(),
          }) =>
              MovementCompanion(
            id: id,
            date: date,
            description: description,
            amount: amount,
            type: type,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            required String description,
            required double amount,
            required MovementType type,
          }) =>
              MovementCompanion.insert(
            id: id,
            date: date,
            description: description,
            amount: amount,
            type: type,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MovementTableProcessedTableManager = ProcessedTableManager<
    _$Db,
    $MovementTable,
    Movements,
    $$MovementTableFilterComposer,
    $$MovementTableOrderingComposer,
    $$MovementTableAnnotationComposer,
    $$MovementTableCreateCompanionBuilder,
    $$MovementTableUpdateCompanionBuilder,
    (Movements, BaseReferences<_$Db, $MovementTable, Movements>),
    Movements,
    PrefetchHooks Function()>;

class $DbManager {
  final _$Db _db;
  $DbManager(this._db);
  $$CategoryTableTableManager get category =>
      $$CategoryTableTableManager(_db, _db.category);
  $$MovementTableTableManager get movement =>
      $$MovementTableTableManager(_db, _db.movement);
}
