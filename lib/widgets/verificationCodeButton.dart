import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/customOutlinButton.dart';

class VerifcationCodeButton extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final int countdownSecond;
  final Future<bool> Function() onPressed;
  final Color color;
  final Color countdownColor;
  final double width;
  final double height;
  final bool noneBorder;

  const VerifcationCodeButton({
    Key key,
    this.countdownSecond,
    this.onPressed,
    this.text,
    this.color,
    this.countdownColor,
    this.width,
    this.height,
    this.textStyle,
    this.noneBorder = false,
  }) : super(key: key);

  @override
  _VerifcationCodeButtonState createState() => _VerifcationCodeButtonState();
}

class _VerifcationCodeButtonState extends State<VerifcationCodeButton>
    with SingleTickerProviderStateMixin {
  var second = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = widget.color ?? Color(0xff1882d6);
    if (second > 0) {
      color = widget.countdownColor ?? Color(0xff999999);
    }
    return CustomOutlineButton(
      width: widget.width ?? Utils.getPXSize(context, 160),
      height: widget.height ?? Utils.getPXSize(context, 50),
      textColor: color,
      borderColor: color,
      noneBorder: widget.noneBorder,
      child: Center(
        child: Text(
          second > 0 ? "$second 秒" : widget.text,
          style: widget.textStyle ??
              TextStyle(
                fontSize: Utils.getPXSize(context, 28),
              ),
        ),
      ),
      onPressed: () {
        if (second > 0) {
          return;
        }
        if (widget.onPressed != null) {
          widget.onPressed().then((b) {
            if (b) {
              setState(() {
                second = widget.countdownSecond;
              });
              timer = Timer.periodic(Duration(seconds: 1), (t) {
                setState(() {
                  second = second - 1;
                });
                if (second < 1) {
                  timer.cancel();
                }
              });
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
