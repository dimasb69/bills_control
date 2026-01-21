// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gastos.dart';

// ignore_for_file: type=lint
class $GastosTable extends Gastos with TableInfo<$GastosTable, Gasto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GastosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
    'motivo',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, motivo, date, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gastos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Gasto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('motivo')) {
      context.handle(
        _motivoMeta,
        motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta),
      );
    } else if (isInserting) {
      context.missing(_motivoMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Gasto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Gasto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      motivo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivo'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
    );
  }

  @override
  $GastosTable createAlias(String alias) {
    return $GastosTable(attachedDatabase, alias);
  }
}

class Gasto extends DataClass implements Insertable<Gasto> {
  final int id;
  final String motivo;
  final DateTime date;
  final double amount;
  const Gasto({
    required this.id,
    required this.motivo,
    required this.date,
    required this.amount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['motivo'] = Variable<String>(motivo);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  GastosCompanion toCompanion(bool nullToAbsent) {
    return GastosCompanion(
      id: Value(id),
      motivo: Value(motivo),
      date: Value(date),
      amount: Value(amount),
    );
  }

  factory Gasto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Gasto(
      id: serializer.fromJson<int>(json['id']),
      motivo: serializer.fromJson<String>(json['motivo']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'motivo': serializer.toJson<String>(motivo),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<double>(amount),
    };
  }

  Gasto copyWith({int? id, String? motivo, DateTime? date, double? amount}) =>
      Gasto(
        id: id ?? this.id,
        motivo: motivo ?? this.motivo,
        date: date ?? this.date,
        amount: amount ?? this.amount,
      );
  Gasto copyWithCompanion(GastosCompanion data) {
    return Gasto(
      id: data.id.present ? data.id.value : this.id,
      motivo: data.motivo.present ? data.motivo.value : this.motivo,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Gasto(')
          ..write('id: $id, ')
          ..write('motivo: $motivo, ')
          ..write('date: $date, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, motivo, date, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Gasto &&
          other.id == this.id &&
          other.motivo == this.motivo &&
          other.date == this.date &&
          other.amount == this.amount);
}

class GastosCompanion extends UpdateCompanion<Gasto> {
  final Value<int> id;
  final Value<String> motivo;
  final Value<DateTime> date;
  final Value<double> amount;
  const GastosCompanion({
    this.id = const Value.absent(),
    this.motivo = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
  });
  GastosCompanion.insert({
    this.id = const Value.absent(),
    required String motivo,
    required DateTime date,
    required double amount,
  }) : motivo = Value(motivo),
       date = Value(date),
       amount = Value(amount);
  static Insertable<Gasto> custom({
    Expression<int>? id,
    Expression<String>? motivo,
    Expression<DateTime>? date,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (motivo != null) 'motivo': motivo,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
    });
  }

  GastosCompanion copyWith({
    Value<int>? id,
    Value<String>? motivo,
    Value<DateTime>? date,
    Value<double>? amount,
  }) {
    return GastosCompanion(
      id: id ?? this.id,
      motivo: motivo ?? this.motivo,
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GastosCompanion(')
          ..write('id: $id, ')
          ..write('motivo: $motivo, ')
          ..write('date: $date, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $GastosItemsTable extends GastosItems
    with TableInfo<$GastosItemsTable, GastosItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GastosItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _gastoIdMeta = const VerificationMeta(
    'gastoId',
  );
  @override
  late final GeneratedColumn<int> gastoId = GeneratedColumn<int>(
    'gasto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gastos (id)',
    ),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gastoId,
    description,
    date,
    amount,
    category,
    type,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gastos_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<GastosItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gasto_id')) {
      context.handle(
        _gastoIdMeta,
        gastoId.isAcceptableOrUnknown(data['gasto_id']!, _gastoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gastoIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GastosItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GastosItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      gastoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gasto_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
    );
  }

  @override
  $GastosItemsTable createAlias(String alias) {
    return $GastosItemsTable(attachedDatabase, alias);
  }
}

class GastosItem extends DataClass implements Insertable<GastosItem> {
  final int id;
  final int gastoId;
  final String description;
  final DateTime date;
  final double amount;
  final String category;
  final String type;
  const GastosItem({
    required this.id,
    required this.gastoId,
    required this.description,
    required this.date,
    required this.amount,
    required this.category,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gasto_id'] = Variable<int>(gastoId);
    map['description'] = Variable<String>(description);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<double>(amount);
    map['category'] = Variable<String>(category);
    map['type'] = Variable<String>(type);
    return map;
  }

  GastosItemsCompanion toCompanion(bool nullToAbsent) {
    return GastosItemsCompanion(
      id: Value(id),
      gastoId: Value(gastoId),
      description: Value(description),
      date: Value(date),
      amount: Value(amount),
      category: Value(category),
      type: Value(type),
    );
  }

  factory GastosItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GastosItem(
      id: serializer.fromJson<int>(json['id']),
      gastoId: serializer.fromJson<int>(json['gastoId']),
      description: serializer.fromJson<String>(json['description']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
      category: serializer.fromJson<String>(json['category']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gastoId': serializer.toJson<int>(gastoId),
      'description': serializer.toJson<String>(description),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<double>(amount),
      'category': serializer.toJson<String>(category),
      'type': serializer.toJson<String>(type),
    };
  }

  GastosItem copyWith({
    int? id,
    int? gastoId,
    String? description,
    DateTime? date,
    double? amount,
    String? category,
    String? type,
  }) => GastosItem(
    id: id ?? this.id,
    gastoId: gastoId ?? this.gastoId,
    description: description ?? this.description,
    date: date ?? this.date,
    amount: amount ?? this.amount,
    category: category ?? this.category,
    type: type ?? this.type,
  );
  GastosItem copyWithCompanion(GastosItemsCompanion data) {
    return GastosItem(
      id: data.id.present ? data.id.value : this.id,
      gastoId: data.gastoId.present ? data.gastoId.value : this.gastoId,
      description: data.description.present
          ? data.description.value
          : this.description,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
      category: data.category.present ? data.category.value : this.category,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GastosItem(')
          ..write('id: $id, ')
          ..write('gastoId: $gastoId, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, gastoId, description, date, amount, category, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GastosItem &&
          other.id == this.id &&
          other.gastoId == this.gastoId &&
          other.description == this.description &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.category == this.category &&
          other.type == this.type);
}

class GastosItemsCompanion extends UpdateCompanion<GastosItem> {
  final Value<int> id;
  final Value<int> gastoId;
  final Value<String> description;
  final Value<DateTime> date;
  final Value<double> amount;
  final Value<String> category;
  final Value<String> type;
  const GastosItemsCompanion({
    this.id = const Value.absent(),
    this.gastoId = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.category = const Value.absent(),
    this.type = const Value.absent(),
  });
  GastosItemsCompanion.insert({
    this.id = const Value.absent(),
    required int gastoId,
    required String description,
    required DateTime date,
    required double amount,
    required String category,
    required String type,
  }) : gastoId = Value(gastoId),
       description = Value(description),
       date = Value(date),
       amount = Value(amount),
       category = Value(category),
       type = Value(type);
  static Insertable<GastosItem> custom({
    Expression<int>? id,
    Expression<int>? gastoId,
    Expression<String>? description,
    Expression<DateTime>? date,
    Expression<double>? amount,
    Expression<String>? category,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gastoId != null) 'gasto_id': gastoId,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (category != null) 'category': category,
      if (type != null) 'type': type,
    });
  }

  GastosItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? gastoId,
    Value<String>? description,
    Value<DateTime>? date,
    Value<double>? amount,
    Value<String>? category,
    Value<String>? type,
  }) {
    return GastosItemsCompanion(
      id: id ?? this.id,
      gastoId: gastoId ?? this.gastoId,
      description: description ?? this.description,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gastoId.present) {
      map['gasto_id'] = Variable<int>(gastoId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GastosItemsCompanion(')
          ..write('id: $id, ')
          ..write('gastoId: $gastoId, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

abstract class _$GastosDatabase extends GeneratedDatabase {
  _$GastosDatabase(QueryExecutor e) : super(e);
  $GastosDatabaseManager get managers => $GastosDatabaseManager(this);
  late final $GastosTable gastos = $GastosTable(this);
  late final $GastosItemsTable gastosItems = $GastosItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [gastos, gastosItems];
}

typedef $$GastosTableCreateCompanionBuilder =
    GastosCompanion Function({
      Value<int> id,
      required String motivo,
      required DateTime date,
      required double amount,
    });
typedef $$GastosTableUpdateCompanionBuilder =
    GastosCompanion Function({
      Value<int> id,
      Value<String> motivo,
      Value<DateTime> date,
      Value<double> amount,
    });

final class $$GastosTableReferences
    extends BaseReferences<_$GastosDatabase, $GastosTable, Gasto> {
  $$GastosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GastosItemsTable, List<GastosItem>>
  _gastosItemsRefsTable(_$GastosDatabase db) => MultiTypedResultKey.fromTable(
    db.gastosItems,
    aliasName: $_aliasNameGenerator(db.gastos.id, db.gastosItems.gastoId),
  );

  $$GastosItemsTableProcessedTableManager get gastosItemsRefs {
    final manager = $$GastosItemsTableTableManager(
      $_db,
      $_db.gastosItems,
    ).filter((f) => f.gastoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_gastosItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GastosTableFilterComposer
    extends Composer<_$GastosDatabase, $GastosTable> {
  $$GastosTableFilterComposer({
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

  ColumnFilters<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> gastosItemsRefs(
    Expression<bool> Function($$GastosItemsTableFilterComposer f) f,
  ) {
    final $$GastosItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gastosItems,
      getReferencedColumn: (t) => t.gastoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosItemsTableFilterComposer(
            $db: $db,
            $table: $db.gastosItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GastosTableOrderingComposer
    extends Composer<_$GastosDatabase, $GastosTable> {
  $$GastosTableOrderingComposer({
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

  ColumnOrderings<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GastosTableAnnotationComposer
    extends Composer<_$GastosDatabase, $GastosTable> {
  $$GastosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get motivo =>
      $composableBuilder(column: $table.motivo, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  Expression<T> gastosItemsRefs<T extends Object>(
    Expression<T> Function($$GastosItemsTableAnnotationComposer a) f,
  ) {
    final $$GastosItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gastosItems,
      getReferencedColumn: (t) => t.gastoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.gastosItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GastosTableTableManager
    extends
        RootTableManager<
          _$GastosDatabase,
          $GastosTable,
          Gasto,
          $$GastosTableFilterComposer,
          $$GastosTableOrderingComposer,
          $$GastosTableAnnotationComposer,
          $$GastosTableCreateCompanionBuilder,
          $$GastosTableUpdateCompanionBuilder,
          (Gasto, $$GastosTableReferences),
          Gasto,
          PrefetchHooks Function({bool gastosItemsRefs})
        > {
  $$GastosTableTableManager(_$GastosDatabase db, $GastosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GastosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GastosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GastosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> motivo = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> amount = const Value.absent(),
              }) => GastosCompanion(
                id: id,
                motivo: motivo,
                date: date,
                amount: amount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String motivo,
                required DateTime date,
                required double amount,
              }) => GastosCompanion.insert(
                id: id,
                motivo: motivo,
                date: date,
                amount: amount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GastosTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({gastosItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (gastosItemsRefs) db.gastosItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (gastosItemsRefs)
                    await $_getPrefetchedData<Gasto, $GastosTable, GastosItem>(
                      currentTable: table,
                      referencedTable: $$GastosTableReferences
                          ._gastosItemsRefsTable(db),
                      managerFromTypedResult: (p0) => $$GastosTableReferences(
                        db,
                        table,
                        p0,
                      ).gastosItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.gastoId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GastosTableProcessedTableManager =
    ProcessedTableManager<
      _$GastosDatabase,
      $GastosTable,
      Gasto,
      $$GastosTableFilterComposer,
      $$GastosTableOrderingComposer,
      $$GastosTableAnnotationComposer,
      $$GastosTableCreateCompanionBuilder,
      $$GastosTableUpdateCompanionBuilder,
      (Gasto, $$GastosTableReferences),
      Gasto,
      PrefetchHooks Function({bool gastosItemsRefs})
    >;
typedef $$GastosItemsTableCreateCompanionBuilder =
    GastosItemsCompanion Function({
      Value<int> id,
      required int gastoId,
      required String description,
      required DateTime date,
      required double amount,
      required String category,
      required String type,
    });
typedef $$GastosItemsTableUpdateCompanionBuilder =
    GastosItemsCompanion Function({
      Value<int> id,
      Value<int> gastoId,
      Value<String> description,
      Value<DateTime> date,
      Value<double> amount,
      Value<String> category,
      Value<String> type,
    });

final class $$GastosItemsTableReferences
    extends BaseReferences<_$GastosDatabase, $GastosItemsTable, GastosItem> {
  $$GastosItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GastosTable _gastoIdTable(_$GastosDatabase db) => db.gastos
      .createAlias($_aliasNameGenerator(db.gastosItems.gastoId, db.gastos.id));

  $$GastosTableProcessedTableManager get gastoId {
    final $_column = $_itemColumn<int>('gasto_id')!;

    final manager = $$GastosTableTableManager(
      $_db,
      $_db.gastos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gastoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GastosItemsTableFilterComposer
    extends Composer<_$GastosDatabase, $GastosItemsTable> {
  $$GastosItemsTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  $$GastosTableFilterComposer get gastoId {
    final $$GastosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gastoId,
      referencedTable: $db.gastos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosTableFilterComposer(
            $db: $db,
            $table: $db.gastos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GastosItemsTableOrderingComposer
    extends Composer<_$GastosDatabase, $GastosItemsTable> {
  $$GastosItemsTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  $$GastosTableOrderingComposer get gastoId {
    final $$GastosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gastoId,
      referencedTable: $db.gastos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosTableOrderingComposer(
            $db: $db,
            $table: $db.gastos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GastosItemsTableAnnotationComposer
    extends Composer<_$GastosDatabase, $GastosItemsTable> {
  $$GastosItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  $$GastosTableAnnotationComposer get gastoId {
    final $$GastosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gastoId,
      referencedTable: $db.gastos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosTableAnnotationComposer(
            $db: $db,
            $table: $db.gastos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GastosItemsTableTableManager
    extends
        RootTableManager<
          _$GastosDatabase,
          $GastosItemsTable,
          GastosItem,
          $$GastosItemsTableFilterComposer,
          $$GastosItemsTableOrderingComposer,
          $$GastosItemsTableAnnotationComposer,
          $$GastosItemsTableCreateCompanionBuilder,
          $$GastosItemsTableUpdateCompanionBuilder,
          (GastosItem, $$GastosItemsTableReferences),
          GastosItem,
          PrefetchHooks Function({bool gastoId})
        > {
  $$GastosItemsTableTableManager(_$GastosDatabase db, $GastosItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GastosItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GastosItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GastosItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> gastoId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> type = const Value.absent(),
              }) => GastosItemsCompanion(
                id: id,
                gastoId: gastoId,
                description: description,
                date: date,
                amount: amount,
                category: category,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int gastoId,
                required String description,
                required DateTime date,
                required double amount,
                required String category,
                required String type,
              }) => GastosItemsCompanion.insert(
                id: id,
                gastoId: gastoId,
                description: description,
                date: date,
                amount: amount,
                category: category,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GastosItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gastoId = false}) {
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
                    if (gastoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gastoId,
                                referencedTable: $$GastosItemsTableReferences
                                    ._gastoIdTable(db),
                                referencedColumn: $$GastosItemsTableReferences
                                    ._gastoIdTable(db)
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

typedef $$GastosItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$GastosDatabase,
      $GastosItemsTable,
      GastosItem,
      $$GastosItemsTableFilterComposer,
      $$GastosItemsTableOrderingComposer,
      $$GastosItemsTableAnnotationComposer,
      $$GastosItemsTableCreateCompanionBuilder,
      $$GastosItemsTableUpdateCompanionBuilder,
      (GastosItem, $$GastosItemsTableReferences),
      GastosItem,
      PrefetchHooks Function({bool gastoId})
    >;

class $GastosDatabaseManager {
  final _$GastosDatabase _db;
  $GastosDatabaseManager(this._db);
  $$GastosTableTableManager get gastos =>
      $$GastosTableTableManager(_db, _db.gastos);
  $$GastosItemsTableTableManager get gastosItems =>
      $$GastosItemsTableTableManager(_db, _db.gastosItems);
}
