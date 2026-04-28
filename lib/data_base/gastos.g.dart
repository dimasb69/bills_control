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
  static const VerificationMeta _initialAmountMeta = const VerificationMeta(
    'initialAmount',
  );
  @override
  late final GeneratedColumn<double> initialAmount = GeneratedColumn<double>(
    'initial_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('normal'),
  );
  static const VerificationMeta _lastResetDateMeta = const VerificationMeta(
    'lastResetDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastResetDate =
      GeneratedColumn<DateTime>(
        'last_reset_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    motivo,
    date,
    amount,
    initialAmount,
    type,
    lastResetDate,
  ];
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
    if (data.containsKey('initial_amount')) {
      context.handle(
        _initialAmountMeta,
        initialAmount.isAcceptableOrUnknown(
          data['initial_amount']!,
          _initialAmountMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('last_reset_date')) {
      context.handle(
        _lastResetDateMeta,
        lastResetDate.isAcceptableOrUnknown(
          data['last_reset_date']!,
          _lastResetDateMeta,
        ),
      );
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
      initialAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}initial_amount'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      lastResetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reset_date'],
      ),
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
  final double initialAmount;
  final String type;
  final DateTime? lastResetDate;
  const Gasto({
    required this.id,
    required this.motivo,
    required this.date,
    required this.amount,
    required this.initialAmount,
    required this.type,
    this.lastResetDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['motivo'] = Variable<String>(motivo);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<double>(amount);
    map['initial_amount'] = Variable<double>(initialAmount);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || lastResetDate != null) {
      map['last_reset_date'] = Variable<DateTime>(lastResetDate);
    }
    return map;
  }

  GastosCompanion toCompanion(bool nullToAbsent) {
    return GastosCompanion(
      id: Value(id),
      motivo: Value(motivo),
      date: Value(date),
      amount: Value(amount),
      initialAmount: Value(initialAmount),
      type: Value(type),
      lastResetDate: lastResetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastResetDate),
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
      initialAmount: serializer.fromJson<double>(json['initialAmount']),
      type: serializer.fromJson<String>(json['type']),
      lastResetDate: serializer.fromJson<DateTime?>(json['lastResetDate']),
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
      'initialAmount': serializer.toJson<double>(initialAmount),
      'type': serializer.toJson<String>(type),
      'lastResetDate': serializer.toJson<DateTime?>(lastResetDate),
    };
  }

  Gasto copyWith({
    int? id,
    String? motivo,
    DateTime? date,
    double? amount,
    double? initialAmount,
    String? type,
    Value<DateTime?> lastResetDate = const Value.absent(),
  }) => Gasto(
    id: id ?? this.id,
    motivo: motivo ?? this.motivo,
    date: date ?? this.date,
    amount: amount ?? this.amount,
    initialAmount: initialAmount ?? this.initialAmount,
    type: type ?? this.type,
    lastResetDate: lastResetDate.present
        ? lastResetDate.value
        : this.lastResetDate,
  );
  Gasto copyWithCompanion(GastosCompanion data) {
    return Gasto(
      id: data.id.present ? data.id.value : this.id,
      motivo: data.motivo.present ? data.motivo.value : this.motivo,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
      initialAmount: data.initialAmount.present
          ? data.initialAmount.value
          : this.initialAmount,
      type: data.type.present ? data.type.value : this.type,
      lastResetDate: data.lastResetDate.present
          ? data.lastResetDate.value
          : this.lastResetDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Gasto(')
          ..write('id: $id, ')
          ..write('motivo: $motivo, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('initialAmount: $initialAmount, ')
          ..write('type: $type, ')
          ..write('lastResetDate: $lastResetDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, motivo, date, amount, initialAmount, type, lastResetDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Gasto &&
          other.id == this.id &&
          other.motivo == this.motivo &&
          other.date == this.date &&
          other.amount == this.amount &&
          other.initialAmount == this.initialAmount &&
          other.type == this.type &&
          other.lastResetDate == this.lastResetDate);
}

class GastosCompanion extends UpdateCompanion<Gasto> {
  final Value<int> id;
  final Value<String> motivo;
  final Value<DateTime> date;
  final Value<double> amount;
  final Value<double> initialAmount;
  final Value<String> type;
  final Value<DateTime?> lastResetDate;
  const GastosCompanion({
    this.id = const Value.absent(),
    this.motivo = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.initialAmount = const Value.absent(),
    this.type = const Value.absent(),
    this.lastResetDate = const Value.absent(),
  });
  GastosCompanion.insert({
    this.id = const Value.absent(),
    required String motivo,
    required DateTime date,
    required double amount,
    this.initialAmount = const Value.absent(),
    this.type = const Value.absent(),
    this.lastResetDate = const Value.absent(),
  }) : motivo = Value(motivo),
       date = Value(date),
       amount = Value(amount);
  static Insertable<Gasto> custom({
    Expression<int>? id,
    Expression<String>? motivo,
    Expression<DateTime>? date,
    Expression<double>? amount,
    Expression<double>? initialAmount,
    Expression<String>? type,
    Expression<DateTime>? lastResetDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (motivo != null) 'motivo': motivo,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (initialAmount != null) 'initial_amount': initialAmount,
      if (type != null) 'type': type,
      if (lastResetDate != null) 'last_reset_date': lastResetDate,
    });
  }

  GastosCompanion copyWith({
    Value<int>? id,
    Value<String>? motivo,
    Value<DateTime>? date,
    Value<double>? amount,
    Value<double>? initialAmount,
    Value<String>? type,
    Value<DateTime?>? lastResetDate,
  }) {
    return GastosCompanion(
      id: id ?? this.id,
      motivo: motivo ?? this.motivo,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      initialAmount: initialAmount ?? this.initialAmount,
      type: type ?? this.type,
      lastResetDate: lastResetDate ?? this.lastResetDate,
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
    if (initialAmount.present) {
      map['initial_amount'] = Variable<double>(initialAmount.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (lastResetDate.present) {
      map['last_reset_date'] = Variable<DateTime>(lastResetDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GastosCompanion(')
          ..write('id: $id, ')
          ..write('motivo: $motivo, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('initialAmount: $initialAmount, ')
          ..write('type: $type, ')
          ..write('lastResetDate: $lastResetDate')
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
      'REFERENCES gastos (id) ON DELETE CASCADE',
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

class $GastosHistorialCerradoTable extends GastosHistorialCerrado
    with TableInfo<$GastosHistorialCerradoTable, GastosHistorialCerradoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GastosHistorialCerradoTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES gastos (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _periodLabelMeta = const VerificationMeta(
    'periodLabel',
  );
  @override
  late final GeneratedColumn<String> periodLabel = GeneratedColumn<String>(
    'period_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonPathMeta = const VerificationMeta(
    'jsonPath',
  );
  @override
  late final GeneratedColumn<String> jsonPath = GeneratedColumn<String>(
    'json_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalSpentMeta = const VerificationMeta(
    'totalSpent',
  );
  @override
  late final GeneratedColumn<double> totalSpent = GeneratedColumn<double>(
    'total_spent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gastoId,
    periodLabel,
    jsonPath,
    totalSpent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gastos_historial_cerrado';
  @override
  VerificationContext validateIntegrity(
    Insertable<GastosHistorialCerradoData> instance, {
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
    if (data.containsKey('period_label')) {
      context.handle(
        _periodLabelMeta,
        periodLabel.isAcceptableOrUnknown(
          data['period_label']!,
          _periodLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_periodLabelMeta);
    }
    if (data.containsKey('json_path')) {
      context.handle(
        _jsonPathMeta,
        jsonPath.isAcceptableOrUnknown(data['json_path']!, _jsonPathMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonPathMeta);
    }
    if (data.containsKey('total_spent')) {
      context.handle(
        _totalSpentMeta,
        totalSpent.isAcceptableOrUnknown(data['total_spent']!, _totalSpentMeta),
      );
    } else if (isInserting) {
      context.missing(_totalSpentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GastosHistorialCerradoData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GastosHistorialCerradoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      gastoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gasto_id'],
      )!,
      periodLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period_label'],
      )!,
      jsonPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json_path'],
      )!,
      totalSpent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_spent'],
      )!,
    );
  }

  @override
  $GastosHistorialCerradoTable createAlias(String alias) {
    return $GastosHistorialCerradoTable(attachedDatabase, alias);
  }
}

class GastosHistorialCerradoData extends DataClass
    implements Insertable<GastosHistorialCerradoData> {
  final int id;
  final int gastoId;
  final String periodLabel;
  final String jsonPath;
  final double totalSpent;
  const GastosHistorialCerradoData({
    required this.id,
    required this.gastoId,
    required this.periodLabel,
    required this.jsonPath,
    required this.totalSpent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gasto_id'] = Variable<int>(gastoId);
    map['period_label'] = Variable<String>(periodLabel);
    map['json_path'] = Variable<String>(jsonPath);
    map['total_spent'] = Variable<double>(totalSpent);
    return map;
  }

  GastosHistorialCerradoCompanion toCompanion(bool nullToAbsent) {
    return GastosHistorialCerradoCompanion(
      id: Value(id),
      gastoId: Value(gastoId),
      periodLabel: Value(periodLabel),
      jsonPath: Value(jsonPath),
      totalSpent: Value(totalSpent),
    );
  }

  factory GastosHistorialCerradoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GastosHistorialCerradoData(
      id: serializer.fromJson<int>(json['id']),
      gastoId: serializer.fromJson<int>(json['gastoId']),
      periodLabel: serializer.fromJson<String>(json['periodLabel']),
      jsonPath: serializer.fromJson<String>(json['jsonPath']),
      totalSpent: serializer.fromJson<double>(json['totalSpent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gastoId': serializer.toJson<int>(gastoId),
      'periodLabel': serializer.toJson<String>(periodLabel),
      'jsonPath': serializer.toJson<String>(jsonPath),
      'totalSpent': serializer.toJson<double>(totalSpent),
    };
  }

  GastosHistorialCerradoData copyWith({
    int? id,
    int? gastoId,
    String? periodLabel,
    String? jsonPath,
    double? totalSpent,
  }) => GastosHistorialCerradoData(
    id: id ?? this.id,
    gastoId: gastoId ?? this.gastoId,
    periodLabel: periodLabel ?? this.periodLabel,
    jsonPath: jsonPath ?? this.jsonPath,
    totalSpent: totalSpent ?? this.totalSpent,
  );
  GastosHistorialCerradoData copyWithCompanion(
    GastosHistorialCerradoCompanion data,
  ) {
    return GastosHistorialCerradoData(
      id: data.id.present ? data.id.value : this.id,
      gastoId: data.gastoId.present ? data.gastoId.value : this.gastoId,
      periodLabel: data.periodLabel.present
          ? data.periodLabel.value
          : this.periodLabel,
      jsonPath: data.jsonPath.present ? data.jsonPath.value : this.jsonPath,
      totalSpent: data.totalSpent.present
          ? data.totalSpent.value
          : this.totalSpent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GastosHistorialCerradoData(')
          ..write('id: $id, ')
          ..write('gastoId: $gastoId, ')
          ..write('periodLabel: $periodLabel, ')
          ..write('jsonPath: $jsonPath, ')
          ..write('totalSpent: $totalSpent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, gastoId, periodLabel, jsonPath, totalSpent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GastosHistorialCerradoData &&
          other.id == this.id &&
          other.gastoId == this.gastoId &&
          other.periodLabel == this.periodLabel &&
          other.jsonPath == this.jsonPath &&
          other.totalSpent == this.totalSpent);
}

class GastosHistorialCerradoCompanion
    extends UpdateCompanion<GastosHistorialCerradoData> {
  final Value<int> id;
  final Value<int> gastoId;
  final Value<String> periodLabel;
  final Value<String> jsonPath;
  final Value<double> totalSpent;
  const GastosHistorialCerradoCompanion({
    this.id = const Value.absent(),
    this.gastoId = const Value.absent(),
    this.periodLabel = const Value.absent(),
    this.jsonPath = const Value.absent(),
    this.totalSpent = const Value.absent(),
  });
  GastosHistorialCerradoCompanion.insert({
    this.id = const Value.absent(),
    required int gastoId,
    required String periodLabel,
    required String jsonPath,
    required double totalSpent,
  }) : gastoId = Value(gastoId),
       periodLabel = Value(periodLabel),
       jsonPath = Value(jsonPath),
       totalSpent = Value(totalSpent);
  static Insertable<GastosHistorialCerradoData> custom({
    Expression<int>? id,
    Expression<int>? gastoId,
    Expression<String>? periodLabel,
    Expression<String>? jsonPath,
    Expression<double>? totalSpent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gastoId != null) 'gasto_id': gastoId,
      if (periodLabel != null) 'period_label': periodLabel,
      if (jsonPath != null) 'json_path': jsonPath,
      if (totalSpent != null) 'total_spent': totalSpent,
    });
  }

  GastosHistorialCerradoCompanion copyWith({
    Value<int>? id,
    Value<int>? gastoId,
    Value<String>? periodLabel,
    Value<String>? jsonPath,
    Value<double>? totalSpent,
  }) {
    return GastosHistorialCerradoCompanion(
      id: id ?? this.id,
      gastoId: gastoId ?? this.gastoId,
      periodLabel: periodLabel ?? this.periodLabel,
      jsonPath: jsonPath ?? this.jsonPath,
      totalSpent: totalSpent ?? this.totalSpent,
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
    if (periodLabel.present) {
      map['period_label'] = Variable<String>(periodLabel.value);
    }
    if (jsonPath.present) {
      map['json_path'] = Variable<String>(jsonPath.value);
    }
    if (totalSpent.present) {
      map['total_spent'] = Variable<double>(totalSpent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GastosHistorialCerradoCompanion(')
          ..write('id: $id, ')
          ..write('gastoId: $gastoId, ')
          ..write('periodLabel: $periodLabel, ')
          ..write('jsonPath: $jsonPath, ')
          ..write('totalSpent: $totalSpent')
          ..write(')'))
        .toString();
  }
}

class $CategoriasTable extends Categorias
    with TableInfo<$CategoriasTable, Categoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriasTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 32,
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
  static const String $name = 'categorias';
  @override
  VerificationContext validateIntegrity(
    Insertable<Categoria> instance, {
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Categoria(
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
  $CategoriasTable createAlias(String alias) {
    return $CategoriasTable(attachedDatabase, alias);
  }
}

class Categoria extends DataClass implements Insertable<Categoria> {
  final int id;
  final String name;
  const Categoria({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  CategoriasCompanion toCompanion(bool nullToAbsent) {
    return CategoriasCompanion(id: Value(id), name: Value(name));
  }

  factory Categoria.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categoria(
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

  Categoria copyWith({int? id, String? name}) =>
      Categoria(id: id ?? this.id, name: name ?? this.name);
  Categoria copyWithCompanion(CategoriasCompanion data) {
    return Categoria(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Categoria(')
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
      (other is Categoria && other.id == this.id && other.name == this.name);
}

class CategoriasCompanion extends UpdateCompanion<Categoria> {
  final Value<int> id;
  final Value<String> name;
  const CategoriasCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  CategoriasCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Categoria> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  CategoriasCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return CategoriasCompanion(id: id ?? this.id, name: name ?? this.name);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _showAutoHelpMeta = const VerificationMeta(
    'showAutoHelp',
  );
  @override
  late final GeneratedColumn<bool> showAutoHelp = GeneratedColumn<bool>(
    'show_auto_help',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_auto_help" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, showAutoHelp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('show_auto_help')) {
      context.handle(
        _showAutoHelpMeta,
        showAutoHelp.isAcceptableOrUnknown(
          data['show_auto_help']!,
          _showAutoHelpMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      showAutoHelp: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_auto_help'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final bool showAutoHelp;
  const AppSetting({required this.id, required this.showAutoHelp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['show_auto_help'] = Variable<bool>(showAutoHelp);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      showAutoHelp: Value(showAutoHelp),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      showAutoHelp: serializer.fromJson<bool>(json['showAutoHelp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'showAutoHelp': serializer.toJson<bool>(showAutoHelp),
    };
  }

  AppSetting copyWith({int? id, bool? showAutoHelp}) => AppSetting(
    id: id ?? this.id,
    showAutoHelp: showAutoHelp ?? this.showAutoHelp,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      showAutoHelp: data.showAutoHelp.present
          ? data.showAutoHelp.value
          : this.showAutoHelp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('showAutoHelp: $showAutoHelp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, showAutoHelp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.showAutoHelp == this.showAutoHelp);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<bool> showAutoHelp;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.showAutoHelp = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.showAutoHelp = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<bool>? showAutoHelp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (showAutoHelp != null) 'show_auto_help': showAutoHelp,
    });
  }

  AppSettingsCompanion copyWith({Value<int>? id, Value<bool>? showAutoHelp}) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      showAutoHelp: showAutoHelp ?? this.showAutoHelp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (showAutoHelp.present) {
      map['show_auto_help'] = Variable<bool>(showAutoHelp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('showAutoHelp: $showAutoHelp')
          ..write(')'))
        .toString();
  }
}

abstract class _$GastosDatabase extends GeneratedDatabase {
  _$GastosDatabase(QueryExecutor e) : super(e);
  $GastosDatabaseManager get managers => $GastosDatabaseManager(this);
  late final $GastosTable gastos = $GastosTable(this);
  late final $GastosItemsTable gastosItems = $GastosItemsTable(this);
  late final $GastosHistorialCerradoTable gastosHistorialCerrado =
      $GastosHistorialCerradoTable(this);
  late final $CategoriasTable categorias = $CategoriasTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    gastos,
    gastosItems,
    gastosHistorialCerrado,
    categorias,
    appSettings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gastos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('gastos_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'gastos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('gastos_historial_cerrado', kind: UpdateKind.delete),
      ],
    ),
  ]);
}

typedef $$GastosTableCreateCompanionBuilder =
    GastosCompanion Function({
      Value<int> id,
      required String motivo,
      required DateTime date,
      required double amount,
      Value<double> initialAmount,
      Value<String> type,
      Value<DateTime?> lastResetDate,
    });
typedef $$GastosTableUpdateCompanionBuilder =
    GastosCompanion Function({
      Value<int> id,
      Value<String> motivo,
      Value<DateTime> date,
      Value<double> amount,
      Value<double> initialAmount,
      Value<String> type,
      Value<DateTime?> lastResetDate,
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

  static MultiTypedResultKey<
    $GastosHistorialCerradoTable,
    List<GastosHistorialCerradoData>
  >
  _gastosHistorialCerradoRefsTable(_$GastosDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.gastosHistorialCerrado,
        aliasName: $_aliasNameGenerator(
          db.gastos.id,
          db.gastosHistorialCerrado.gastoId,
        ),
      );

  $$GastosHistorialCerradoTableProcessedTableManager
  get gastosHistorialCerradoRefs {
    final manager = $$GastosHistorialCerradoTableTableManager(
      $_db,
      $_db.gastosHistorialCerrado,
    ).filter((f) => f.gastoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _gastosHistorialCerradoRefsTable($_db),
    );
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

  ColumnFilters<double> get initialAmount => $composableBuilder(
    column: $table.initialAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastResetDate => $composableBuilder(
    column: $table.lastResetDate,
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

  Expression<bool> gastosHistorialCerradoRefs(
    Expression<bool> Function($$GastosHistorialCerradoTableFilterComposer f) f,
  ) {
    final $$GastosHistorialCerradoTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.gastosHistorialCerrado,
          getReferencedColumn: (t) => t.gastoId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GastosHistorialCerradoTableFilterComposer(
                $db: $db,
                $table: $db.gastosHistorialCerrado,
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

  ColumnOrderings<double> get initialAmount => $composableBuilder(
    column: $table.initialAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastResetDate => $composableBuilder(
    column: $table.lastResetDate,
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

  GeneratedColumn<double> get initialAmount => $composableBuilder(
    column: $table.initialAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get lastResetDate => $composableBuilder(
    column: $table.lastResetDate,
    builder: (column) => column,
  );

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

  Expression<T> gastosHistorialCerradoRefs<T extends Object>(
    Expression<T> Function($$GastosHistorialCerradoTableAnnotationComposer a) f,
  ) {
    final $$GastosHistorialCerradoTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.gastosHistorialCerrado,
          getReferencedColumn: (t) => t.gastoId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GastosHistorialCerradoTableAnnotationComposer(
                $db: $db,
                $table: $db.gastosHistorialCerrado,
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
          PrefetchHooks Function({
            bool gastosItemsRefs,
            bool gastosHistorialCerradoRefs,
          })
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
                Value<double> initialAmount = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime?> lastResetDate = const Value.absent(),
              }) => GastosCompanion(
                id: id,
                motivo: motivo,
                date: date,
                amount: amount,
                initialAmount: initialAmount,
                type: type,
                lastResetDate: lastResetDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String motivo,
                required DateTime date,
                required double amount,
                Value<double> initialAmount = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime?> lastResetDate = const Value.absent(),
              }) => GastosCompanion.insert(
                id: id,
                motivo: motivo,
                date: date,
                amount: amount,
                initialAmount: initialAmount,
                type: type,
                lastResetDate: lastResetDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GastosTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({gastosItemsRefs = false, gastosHistorialCerradoRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (gastosItemsRefs) db.gastosItems,
                    if (gastosHistorialCerradoRefs) db.gastosHistorialCerrado,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (gastosItemsRefs)
                        await $_getPrefetchedData<
                          Gasto,
                          $GastosTable,
                          GastosItem
                        >(
                          currentTable: table,
                          referencedTable: $$GastosTableReferences
                              ._gastosItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GastosTableReferences(
                                db,
                                table,
                                p0,
                              ).gastosItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gastoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (gastosHistorialCerradoRefs)
                        await $_getPrefetchedData<
                          Gasto,
                          $GastosTable,
                          GastosHistorialCerradoData
                        >(
                          currentTable: table,
                          referencedTable: $$GastosTableReferences
                              ._gastosHistorialCerradoRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GastosTableReferences(
                                db,
                                table,
                                p0,
                              ).gastosHistorialCerradoRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gastoId == item.id,
                              ),
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
      PrefetchHooks Function({
        bool gastosItemsRefs,
        bool gastosHistorialCerradoRefs,
      })
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
typedef $$GastosHistorialCerradoTableCreateCompanionBuilder =
    GastosHistorialCerradoCompanion Function({
      Value<int> id,
      required int gastoId,
      required String periodLabel,
      required String jsonPath,
      required double totalSpent,
    });
typedef $$GastosHistorialCerradoTableUpdateCompanionBuilder =
    GastosHistorialCerradoCompanion Function({
      Value<int> id,
      Value<int> gastoId,
      Value<String> periodLabel,
      Value<String> jsonPath,
      Value<double> totalSpent,
    });

final class $$GastosHistorialCerradoTableReferences
    extends
        BaseReferences<
          _$GastosDatabase,
          $GastosHistorialCerradoTable,
          GastosHistorialCerradoData
        > {
  $$GastosHistorialCerradoTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GastosTable _gastoIdTable(_$GastosDatabase db) =>
      db.gastos.createAlias(
        $_aliasNameGenerator(db.gastosHistorialCerrado.gastoId, db.gastos.id),
      );

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

class $$GastosHistorialCerradoTableFilterComposer
    extends Composer<_$GastosDatabase, $GastosHistorialCerradoTable> {
  $$GastosHistorialCerradoTableFilterComposer({
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

  ColumnFilters<String> get periodLabel => $composableBuilder(
    column: $table.periodLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jsonPath => $composableBuilder(
    column: $table.jsonPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalSpent => $composableBuilder(
    column: $table.totalSpent,
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

class $$GastosHistorialCerradoTableOrderingComposer
    extends Composer<_$GastosDatabase, $GastosHistorialCerradoTable> {
  $$GastosHistorialCerradoTableOrderingComposer({
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

  ColumnOrderings<String> get periodLabel => $composableBuilder(
    column: $table.periodLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jsonPath => $composableBuilder(
    column: $table.jsonPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalSpent => $composableBuilder(
    column: $table.totalSpent,
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

class $$GastosHistorialCerradoTableAnnotationComposer
    extends Composer<_$GastosDatabase, $GastosHistorialCerradoTable> {
  $$GastosHistorialCerradoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get periodLabel => $composableBuilder(
    column: $table.periodLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get jsonPath =>
      $composableBuilder(column: $table.jsonPath, builder: (column) => column);

  GeneratedColumn<double> get totalSpent => $composableBuilder(
    column: $table.totalSpent,
    builder: (column) => column,
  );

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

class $$GastosHistorialCerradoTableTableManager
    extends
        RootTableManager<
          _$GastosDatabase,
          $GastosHistorialCerradoTable,
          GastosHistorialCerradoData,
          $$GastosHistorialCerradoTableFilterComposer,
          $$GastosHistorialCerradoTableOrderingComposer,
          $$GastosHistorialCerradoTableAnnotationComposer,
          $$GastosHistorialCerradoTableCreateCompanionBuilder,
          $$GastosHistorialCerradoTableUpdateCompanionBuilder,
          (GastosHistorialCerradoData, $$GastosHistorialCerradoTableReferences),
          GastosHistorialCerradoData,
          PrefetchHooks Function({bool gastoId})
        > {
  $$GastosHistorialCerradoTableTableManager(
    _$GastosDatabase db,
    $GastosHistorialCerradoTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GastosHistorialCerradoTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$GastosHistorialCerradoTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GastosHistorialCerradoTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> gastoId = const Value.absent(),
                Value<String> periodLabel = const Value.absent(),
                Value<String> jsonPath = const Value.absent(),
                Value<double> totalSpent = const Value.absent(),
              }) => GastosHistorialCerradoCompanion(
                id: id,
                gastoId: gastoId,
                periodLabel: periodLabel,
                jsonPath: jsonPath,
                totalSpent: totalSpent,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int gastoId,
                required String periodLabel,
                required String jsonPath,
                required double totalSpent,
              }) => GastosHistorialCerradoCompanion.insert(
                id: id,
                gastoId: gastoId,
                periodLabel: periodLabel,
                jsonPath: jsonPath,
                totalSpent: totalSpent,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GastosHistorialCerradoTableReferences(db, table, e),
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
                                referencedTable:
                                    $$GastosHistorialCerradoTableReferences
                                        ._gastoIdTable(db),
                                referencedColumn:
                                    $$GastosHistorialCerradoTableReferences
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

typedef $$GastosHistorialCerradoTableProcessedTableManager =
    ProcessedTableManager<
      _$GastosDatabase,
      $GastosHistorialCerradoTable,
      GastosHistorialCerradoData,
      $$GastosHistorialCerradoTableFilterComposer,
      $$GastosHistorialCerradoTableOrderingComposer,
      $$GastosHistorialCerradoTableAnnotationComposer,
      $$GastosHistorialCerradoTableCreateCompanionBuilder,
      $$GastosHistorialCerradoTableUpdateCompanionBuilder,
      (GastosHistorialCerradoData, $$GastosHistorialCerradoTableReferences),
      GastosHistorialCerradoData,
      PrefetchHooks Function({bool gastoId})
    >;
typedef $$CategoriasTableCreateCompanionBuilder =
    CategoriasCompanion Function({Value<int> id, required String name});
typedef $$CategoriasTableUpdateCompanionBuilder =
    CategoriasCompanion Function({Value<int> id, Value<String> name});

class $$CategoriasTableFilterComposer
    extends Composer<_$GastosDatabase, $CategoriasTable> {
  $$CategoriasTableFilterComposer({
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
}

class $$CategoriasTableOrderingComposer
    extends Composer<_$GastosDatabase, $CategoriasTable> {
  $$CategoriasTableOrderingComposer({
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

class $$CategoriasTableAnnotationComposer
    extends Composer<_$GastosDatabase, $CategoriasTable> {
  $$CategoriasTableAnnotationComposer({
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
}

class $$CategoriasTableTableManager
    extends
        RootTableManager<
          _$GastosDatabase,
          $CategoriasTable,
          Categoria,
          $$CategoriasTableFilterComposer,
          $$CategoriasTableOrderingComposer,
          $$CategoriasTableAnnotationComposer,
          $$CategoriasTableCreateCompanionBuilder,
          $$CategoriasTableUpdateCompanionBuilder,
          (
            Categoria,
            BaseReferences<_$GastosDatabase, $CategoriasTable, Categoria>,
          ),
          Categoria,
          PrefetchHooks Function()
        > {
  $$CategoriasTableTableManager(_$GastosDatabase db, $CategoriasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => CategoriasCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  CategoriasCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriasTableProcessedTableManager =
    ProcessedTableManager<
      _$GastosDatabase,
      $CategoriasTable,
      Categoria,
      $$CategoriasTableFilterComposer,
      $$CategoriasTableOrderingComposer,
      $$CategoriasTableAnnotationComposer,
      $$CategoriasTableCreateCompanionBuilder,
      $$CategoriasTableUpdateCompanionBuilder,
      (
        Categoria,
        BaseReferences<_$GastosDatabase, $CategoriasTable, Categoria>,
      ),
      Categoria,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({Value<int> id, Value<bool> showAutoHelp});
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({Value<int> id, Value<bool> showAutoHelp});

class $$AppSettingsTableFilterComposer
    extends Composer<_$GastosDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
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

  ColumnFilters<bool> get showAutoHelp => $composableBuilder(
    column: $table.showAutoHelp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$GastosDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
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

  ColumnOrderings<bool> get showAutoHelp => $composableBuilder(
    column: $table.showAutoHelp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$GastosDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get showAutoHelp => $composableBuilder(
    column: $table.showAutoHelp,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$GastosDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$GastosDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$GastosDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> showAutoHelp = const Value.absent(),
              }) => AppSettingsCompanion(id: id, showAutoHelp: showAutoHelp),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> showAutoHelp = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                showAutoHelp: showAutoHelp,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$GastosDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$GastosDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $GastosDatabaseManager {
  final _$GastosDatabase _db;
  $GastosDatabaseManager(this._db);
  $$GastosTableTableManager get gastos =>
      $$GastosTableTableManager(_db, _db.gastos);
  $$GastosItemsTableTableManager get gastosItems =>
      $$GastosItemsTableTableManager(_db, _db.gastosItems);
  $$GastosHistorialCerradoTableTableManager get gastosHistorialCerrado =>
      $$GastosHistorialCerradoTableTableManager(
        _db,
        _db.gastosHistorialCerrado,
      );
  $$CategoriasTableTableManager get categorias =>
      $$CategoriasTableTableManager(_db, _db.categorias);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
