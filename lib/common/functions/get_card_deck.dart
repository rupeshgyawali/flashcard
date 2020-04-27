import 'package:flash_card/models/flash_card.dart';
import 'package:flash_card/models/card_deck.dart';

CardDeck getCardDeck() {
  CardDeck deck = CardDeck(name: 'Deck 1', cards: <FlashCard>[]);
  for (var i = 0; i < 7; i++) {
    deck.addCard(
      FlashCard(
        front: 'Front $i',
        back: 'Back $i',
      ),
    );
  }

  return deck;
}
