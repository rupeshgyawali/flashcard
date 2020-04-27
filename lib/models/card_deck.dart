import 'package:flash_card/models/flash_card.dart';

class CardDeck {
  final String name;
  final List<FlashCard> cards;

  CardDeck({this.name, this.cards});

  FlashCard addCard(FlashCard card) {
    this.cards.add(card);
    return card;
  }

  int numberOfCards() {
    return this.cards.length;
  }
}
