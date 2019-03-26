import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/widgets.dart';

const double _kDefaultIndicatorRadius = 10.0;

class LoadingIcon extends StatefulWidget {
  const LoadingIcon({
    Key key,
    this.animating = true,
    this.radius = _kDefaultIndicatorRadius,
  })  : assert(animating != null),
        assert(radius != null),
        assert(radius > 0),
        super(key: key);
  final bool animating;
  final double radius;
  @override
  createState() => LoadingIconState();
}

class LoadingIconState extends State<LoadingIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    if (widget.animating) _controller.repeat();
  }
   @override
  void didUpdateWidget(LoadingIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animating != oldWidget.animating) {
      if (widget.animating)
        _controller.repeat();
      else
        _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.radius * 4,
      width: widget.radius * 4,
      child:
        Column(
          children: <Widget>[
            Icon(Icons.access_alarm),
       CustomPaint(
        painter: _CupertinoActivityIndicatorPainter(
          position: _controller,
          radius: widget.radius*2,
        ),
      ),      
          ],
        )
      
    );
  }
}
const double _kTwoPI = math.pi * 2.0;
const int _kTickCount = 12;
const int _kHalfTickCount = _kTickCount ~/ 2;
const Color _kTickColor = CupertinoColors.lightBackgroundGray;
const Color _kActiveTickColor = Color(0xFF9D9D9D);

class _CupertinoActivityIndicatorPainter extends CustomPainter {
  _CupertinoActivityIndicatorPainter({
    this.position,
    double radius,
  }) : tickFundamentalRRect = RRect.fromLTRBXY(
           -radius,
           1.0 * radius / _kDefaultIndicatorRadius,
           -radius / 2.0,
           -1.0 * radius / _kDefaultIndicatorRadius,
           1.0,
           1.0,
       ),
       super(repaint: position);

  final Animation<double> position;
  final RRect tickFundamentalRRect;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    canvas.save();
    canvas.translate(size.width / 2.0, size.height / 2.0);

    final int activeTick = (_kTickCount * position.value).floor();

    for (int i = 0; i < _kTickCount; ++ i) {
      final double t = (((i + activeTick) % _kTickCount) / _kHalfTickCount).clamp(0.0, 1.0);
      paint.color = Color.lerp(_kActiveTickColor, _kTickColor, t);
      canvas.drawRRect(tickFundamentalRRect, paint);
      canvas.rotate(-_kTwoPI / _kTickCount);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CupertinoActivityIndicatorPainter oldPainter) {
    return oldPainter.position != position;
  }
}
