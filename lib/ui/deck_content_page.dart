import 'package:flash_card/services/database.dart' as data;
import 'package:flutter/material.dart';
// import 'package:path/path.dart';

import 'card_deck.dart';

class DeckContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data.Deck args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(args.name),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            // color: Colors.black,
            icon: Icon(Icons.add),
            tooltip: 'Add Flash Cards',
            onPressed: () {},
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05)
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 100.0),
          child: Center(
            child: CardDeckWidget(),
          ),
        ),
      ),
    );
  }
}
