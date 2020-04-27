import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FlashCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final double width;
  final double height;
  final bool flipOnTap;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final BoxConstraints constraints;

  FlashCard(
      {Key key,
      this.front,
      this.back,
      this.width,
      this.height,
      this.flipOnTap = true,
      this.padding,
      this.elevation,
      this.constraints})
      : super(key: key);

  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard>
    with SingleTickerProviderStateMixin {
  AnimationStatus _status = AnimationStatus.dismissed;
  AnimationController _controller;
  Animation<double> _frontAnimation;
  Animation<double> _backAnimation;

  bool frontFacing = true;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _frontAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: math.pi / 2).chain(
          CurveTween(curve: Curves.easeIn),
        ),
        weight: 50.0,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(math.pi / 2),
        weight: 50.0,
      ),
    ]).animate(_controller);

    _backAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(math.pi / 2),
        weight: 50.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -math.pi / 2, end: 0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50.0,
      ),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      _status = status;
    });

    super.initState();
  }

  void startAnimation() {
    if (_status == AnimationStatus.dismissed ||
        _status == AnimationStatus.completed) {
      if (_status == AnimationStatus.dismissed) {
        _controller.forward();
      } else if (_status == AnimationStatus.completed) {
        _controller.reverse();
      }

      setState(() {
        frontFacing = !frontFacing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.flipOnTap ? startAnimation : () {},
      child: Stack(
        children: <Widget>[
          _widgetBuild(isFliped: false),
          _widgetBuild(isFliped: true),
        ],
      ),
    );
  }

  Widget _widgetBuild({bool isFliped}) {
    return IgnorePointer(
      ignoring: isFliped ? frontFacing : !frontFacing,
      child: FlipTransition(
        animation: isFliped ? _backAnimation : _frontAnimation,
        child: Card(
          elevation: widget.elevation,
          child: AnimatedContainer(
            width: widget.width,
            height: widget.height,
            padding: widget.padding ?? EdgeInsets.all(0.0),
            constraints: widget.constraints,
            child: Center(
              child: isFliped ? widget.back : widget.front,
            ),
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          ),
        ),
      ),
    );
  }
}

class FlipTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  FlipTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
