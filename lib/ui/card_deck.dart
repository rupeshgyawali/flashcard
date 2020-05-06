import 'package:flash_card/common/functions/get_card_deck.dart';
import 'package:flash_card/models/card_deck.dart';
import 'package:flash_card/ui/flash_card.dart';
import 'package:flutter/material.dart';

class CardDeckWidget extends StatefulWidget {
  @override
  _CardDeckWidgetState createState() => _CardDeckWidgetState();
}

class _CardDeckWidgetState extends State<CardDeckWidget>
    with SingleTickerProviderStateMixin {
  double _posIncr = 0.0;
  double _growSize = 1.0;
  double _elevation = 10.0;

  CardDeck deck;

  @override
  void initState() {
    super.initState();
    deck = getCardDeck();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      bringfront();
    });
  }

  void bringfront() {
    setState(() {
      _posIncr = 15.0;
    });
  }

  void growOnDisplayCard() {
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _growSize = 1.15;
        _elevation = 20.0;
      });
    });
  }

  void _onSwiped() {
    setState(() {
      deck.cards.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Stack(
        // alignment: Alignment.center,
        overflow: Overflow.visible,
        children: deck.cards.map((item) {
          double _posx, _posy;
          bool onDisplayCard = false;
          double scale = 1.0;

          if (deck.cards.indexOf(item) <= deck.cards.length - 4) {
            _posx = 0;
            _posy = 0;
          } else {
            _posx =
                (deck.cards.indexOf(item) - deck.cards.length + 4) * _posIncr;
            _posy =
                (deck.cards.indexOf(item) - deck.cards.length + 4) * _posIncr;
          }

          if (deck.cards.indexOf(item) == deck.cards.length - 1) {
            onDisplayCard = true;
            scale = _growSize;
          }
          return AnimatedPositioned(
            top: _posy * (1 + 2 * (scale - 1)),
            left: _posx * (1 - 9 * (scale - 1)),
            child: SwipeableFlashCard(
              onSwiped: _onSwiped,
              child: FlashCard(
                elevation: onDisplayCard ? _elevation : 10.0,
                width: 250.0 * scale,
                height: 350.0 * scale,
                flipOnTap: onDisplayCard,
                front: Text(item.front),
                back: Text(item.back),
              ),
            ),
            duration: Duration(
              milliseconds: _growSize == 1.0 ? 500 : 200,
            ),
            onEnd: growOnDisplayCard,
            curve: Curves.easeIn,
          );
        }).toList(),
      ),
    );
  }
}

class SwipeableFlashCard extends StatefulWidget {
  SwipeableFlashCard({Key key, this.child, this.onSwiped}) : super(key: key);

  final Widget child;
  final VoidCallback onSwiped;

  @override
  _SwipeableFlashCardState createState() => _SwipeableFlashCardState();
}

enum SwipeDirection {
  left,
  right,
}

class _SwipeableFlashCardState extends State<SwipeableFlashCard>
    with SingleTickerProviderStateMixin {
  Offset _childOffset;
  AnimationController _controller;
  // AnimationStatus _status = AnimationStatus.dismissed;
  // Animation<double> _leftSwipe;
  // Animation<double> _rightSwipe;
  // Animation<double> _calcledSwipe;

  SwipeDirection _swipeDirection = SwipeDirection.right;

  @override
  void initState() {
    super.initState();
    _childOffset = Offset.zero;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              widget.onSwiped();
            }
          });

    // _rightSwipe = Tween<double>(begin: 0, end: 200).animate(_controller);
    // _leftSwipe = Tween<double>(begin: 0, end: -200).animate(_controller);
  }

  void startSwipedAnimation() {
    if (_childOffset.dx > 100.0) {
      setState(() {
        _swipeDirection = SwipeDirection.right;
      });
      _controller.forward();
    } else if (_childOffset.dx < -100.0) {
      setState(() {
        _swipeDirection = SwipeDirection.left;
      });
      _controller.forward();
    } else {
      setState(() {
        _childOffset = Offset.zero;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SwipedTransition(
        animation: _controller,
        swipeDirection: _swipeDirection,
        child: Transform.translate(
          child: widget.child,
          offset: _childOffset,
        ),
      ),
      onPanStart: (details) {
        // print(details);
      },
      onPanUpdate: (details) {
        setState(() {
          // print(details);
          _childOffset = Offset(_childOffset.dx + details.delta.dx,
              _childOffset.dy - details.delta.dx.abs() * 0.5);
          // print(_childOffset);
        });
      },
      onPanEnd: (details) {
        startSwipedAnimation();
      },
    );
  }
}

class SwipedTransition extends StatelessWidget {
  SwipedTransition({this.animation, this.child, this.swipeDirection});

  final Animation<double> animation;
  final Widget child;
  final SwipeDirection swipeDirection;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Transform.translate(
          offset: swipeDirection == SwipeDirection.right
              ? Offset(animation.value * 200.0, animation.value * -100.0)
              : Offset(animation.value * -200.0, animation.value * -100.0),
          child: child,
        );
      },
    );
  }
}
