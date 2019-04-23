import 'package:flutter/material.dart';

class CustomFlatButton extends StatefulWidget {
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;

  const CustomFlatButton({
    Key key,
    this.textColor,
    this.backgroundColor,
    this.onPressed,
    this.child,
    this.padding,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  _CustomFlatButtonState createState() => _CustomFlatButtonState();
}

class _CustomFlatButtonState extends State<CustomFlatButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: OutlineButton(
        borderSide: new BorderSide(color: widget.textColor ?? Colors.blue),
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(5),

        ),
        textColor: widget.textColor ?? Colors.white,
        color: widget.backgroundColor ?? Colors.blue,
        padding: widget.padding ?? EdgeInsets.all(0),
        child: widget.child,
        onPressed: widget.onPressed,
      ),
    );
  }
}
