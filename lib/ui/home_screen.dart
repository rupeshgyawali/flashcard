import 'package:flutter/material.dart';

import 'card_deck.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
