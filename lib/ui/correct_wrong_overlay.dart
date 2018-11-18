import 'package:flutter/material.dart';
import 'dart:math';

class CorrectWrongOverlay extends StatefulWidget{

  final bool _isCorrect;
  final VoidCallback _onTap;

  CorrectWrongOverlay(this._isCorrect, this._onTap);

  @override
  State<StatefulWidget> createState() {
    return CorrectWrongOverlayState();
  }
}

class CorrectWrongOverlayState extends State<CorrectWrongOverlay> with SingleTickerProviderStateMixin{

  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 2));
    _animation = new CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);
    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.black54,
      child: new InkWell(
        onTap: () => widget._onTap(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: new Transform.rotate(
                angle: _animation.value * 2 * pi,
                child: new Icon(widget._isCorrect ? Icons.done : Icons.clear, size: _animation.value * 80.0),
              ),
              decoration: new BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            ),
            new Padding(padding: new EdgeInsets.only(bottom: 20.0)),
            new Text(widget._isCorrect ? "Correct" : "Wrong", style: new TextStyle(color: Colors.white, fontSize: 30.0),)
          ],
        ),
      ),
    );
  }
}