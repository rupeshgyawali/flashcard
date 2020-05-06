import 'package:flash_card/services/database.dart';
import 'package:flash_card/ui/add_card_page.dart';
import 'package:flash_card/ui/deck_content_page.dart';
import 'package:flash_card/ui/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(FlashCardApp());

class AppDatabase extends InheritedWidget {
  const AppDatabase({
    Key key,
    @required this.database,
    @required Widget child,
  })  : assert(database != null),
        assert(child != null),
        super(key: key, child: child);

  final MyDatabase database;

  static AppDatabase of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDatabase>();
  }

  @override
  bool updateShouldNotify(AppDatabase old) => true;
}

class FlashCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppDatabase(
      database: MyDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder>{
          '/': (context) => HomePage(),
          '/deck_content': (context) => DeckContentPage(),
          '/add_card': (context) => AddCardPage(),
        },
        // home: HomePage(),
        initialRoute: '/',
      ),
    );
  }
}
