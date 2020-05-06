import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Cards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get front => text()();
  TextColumn get back => text()();
  IntColumn get deck => integer().nullable()();
}

@DataClassName("Deck")
class Decks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Cards, Decks])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Deck>> allDecks() => select(decks).get();
  Stream<List<Deck>> watchAllDecks() => select(decks).watch();
  Future<int> addDeck(DecksCompanion deck) => into(decks).insert(deck);

  Future<List<Card>> allCardsInDeck(Deck deck) =>
      (select(cards)..where((card) => card.deck.equals(deck.id))).get();
  Future<int> addCard(Card card) => into(cards).insert(card);
}
