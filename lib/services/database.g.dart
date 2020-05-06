// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Card extends DataClass implements Insertable<Card> {
  final int id;
  final String front;
  final String back;
  final int deck;
  Card(
      {@required this.id,
      @required this.front,
      @required this.back,
      this.deck});
  factory Card.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Card(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      front:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}front']),
      back: stringType.mapFromDatabaseResponse(data['${effectivePrefix}back']),
      deck: intType.mapFromDatabaseResponse(data['${effectivePrefix}deck']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || front != null) {
      map['front'] = Variable<String>(front);
    }
    if (!nullToAbsent || back != null) {
      map['back'] = Variable<String>(back);
    }
    if (!nullToAbsent || deck != null) {
      map['deck'] = Variable<int>(deck);
    }
    return map;
  }

  factory Card.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Card(
      id: serializer.fromJson<int>(json['id']),
      front: serializer.fromJson<String>(json['front']),
      back: serializer.fromJson<String>(json['back']),
      deck: serializer.fromJson<int>(json['deck']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'front': serializer.toJson<String>(front),
      'back': serializer.toJson<String>(back),
      'deck': serializer.toJson<int>(deck),
    };
  }

  Card copyWith({int id, String front, String back, int deck}) => Card(
        id: id ?? this.id,
        front: front ?? this.front,
        back: back ?? this.back,
        deck: deck ?? this.deck,
      );
  @override
  String toString() {
    return (StringBuffer('Card(')
          ..write('id: $id, ')
          ..write('front: $front, ')
          ..write('back: $back, ')
          ..write('deck: $deck')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode, $mrjc(front.hashCode, $mrjc(back.hashCode, deck.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Card &&
          other.id == this.id &&
          other.front == this.front &&
          other.back == this.back &&
          other.deck == this.deck);
}

class CardsCompanion extends UpdateCompanion<Card> {
  final Value<int> id;
  final Value<String> front;
  final Value<String> back;
  final Value<int> deck;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.front = const Value.absent(),
    this.back = const Value.absent(),
    this.deck = const Value.absent(),
  });
  CardsCompanion.insert({
    this.id = const Value.absent(),
    @required String front,
    @required String back,
    this.deck = const Value.absent(),
  })  : front = Value(front),
        back = Value(back);
  static Insertable<Card> custom({
    Expression<int> id,
    Expression<String> front,
    Expression<String> back,
    Expression<int> deck,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (front != null) 'front': front,
      if (back != null) 'back': back,
      if (deck != null) 'deck': deck,
    });
  }

  CardsCompanion copyWith(
      {Value<int> id,
      Value<String> front,
      Value<String> back,
      Value<int> deck}) {
    return CardsCompanion(
      id: id ?? this.id,
      front: front ?? this.front,
      back: back ?? this.back,
      deck: deck ?? this.deck,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (front.present) {
      map['front'] = Variable<String>(front.value);
    }
    if (back.present) {
      map['back'] = Variable<String>(back.value);
    }
    if (deck.present) {
      map['deck'] = Variable<int>(deck.value);
    }
    return map;
  }
}

class $CardsTable extends Cards with TableInfo<$CardsTable, Card> {
  final GeneratedDatabase _db;
  final String _alias;
  $CardsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _frontMeta = const VerificationMeta('front');
  GeneratedTextColumn _front;
  @override
  GeneratedTextColumn get front => _front ??= _constructFront();
  GeneratedTextColumn _constructFront() {
    return GeneratedTextColumn(
      'front',
      $tableName,
      false,
    );
  }

  final VerificationMeta _backMeta = const VerificationMeta('back');
  GeneratedTextColumn _back;
  @override
  GeneratedTextColumn get back => _back ??= _constructBack();
  GeneratedTextColumn _constructBack() {
    return GeneratedTextColumn(
      'back',
      $tableName,
      false,
    );
  }

  final VerificationMeta _deckMeta = const VerificationMeta('deck');
  GeneratedIntColumn _deck;
  @override
  GeneratedIntColumn get deck => _deck ??= _constructDeck();
  GeneratedIntColumn _constructDeck() {
    return GeneratedIntColumn(
      'deck',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, front, back, deck];
  @override
  $CardsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cards';
  @override
  final String actualTableName = 'cards';
  @override
  VerificationContext validateIntegrity(Insertable<Card> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('front')) {
      context.handle(
          _frontMeta, front.isAcceptableOrUnknown(data['front'], _frontMeta));
    } else if (isInserting) {
      context.missing(_frontMeta);
    }
    if (data.containsKey('back')) {
      context.handle(
          _backMeta, back.isAcceptableOrUnknown(data['back'], _backMeta));
    } else if (isInserting) {
      context.missing(_backMeta);
    }
    if (data.containsKey('deck')) {
      context.handle(
          _deckMeta, deck.isAcceptableOrUnknown(data['deck'], _deckMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Card map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Card.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CardsTable createAlias(String alias) {
    return $CardsTable(_db, alias);
  }
}

class Deck extends DataClass implements Insertable<Deck> {
  final int id;
  final String name;
  Deck({@required this.id, @required this.name});
  factory Deck.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Deck(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  factory Deck.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Deck(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Deck copyWith({int id, String name}) => Deck(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Deck(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Deck && other.id == this.id && other.name == this.name);
}

class DecksCompanion extends UpdateCompanion<Deck> {
  final Value<int> id;
  final Value<String> name;
  const DecksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  DecksCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
  }) : name = Value(name);
  static Insertable<Deck> custom({
    Expression<int> id,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  DecksCompanion copyWith({Value<int> id, Value<String> name}) {
    return DecksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
  }
}

class $DecksTable extends Decks with TableInfo<$DecksTable, Deck> {
  final GeneratedDatabase _db;
  final String _alias;
  $DecksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $DecksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'decks';
  @override
  final String actualTableName = 'decks';
  @override
  VerificationContext validateIntegrity(Insertable<Deck> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Deck map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Deck.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $DecksTable createAlias(String alias) {
    return $DecksTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CardsTable _cards;
  $CardsTable get cards => _cards ??= $CardsTable(this);
  $DecksTable _decks;
  $DecksTable get decks => _decks ??= $DecksTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cards, decks];
}
