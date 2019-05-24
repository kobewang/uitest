import 'package:flutter/material.dart';
import 'package:uitest/utils/utils.dart';

class CustomListItem extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Widget icon;
  final double height;
  final Widget child;
  final Widget endChild;
  final VoidCallback onPressed;
  final bool bottomDivider;

  const CustomListItem({
    Key key,
    this.padding,
    this.backgroundColor,
    this.icon,
    this.height,
    this.endChild,
    this.onPressed,
    this.child,
    this.bottomDivider = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
            disabledColor: backgroundColor ?? Colors.white,
            color: backgroundColor ?? Colors.white,
            padding: padding ??
                EdgeInsets.only(
                  left: Utils.getPXSize(context, 40),
                  right: Utils.getPXSize(context, 40),
                ),
            child: Container(
              height: height ?? Utils.getPXSize(context, 100),
              child: Row(
                children: <Widget>[
                  icon ?? Container(),
                  Expanded(
                    child: child,
                  ),
                  endChild ?? Container(),
                ],
              ),
            ),
            onPressed: onPressed,
          ),
          Container(
            color: backgroundColor ?? Colors.white,
            padding: padding ??
                EdgeInsets.only(
                  left: Utils.getPXSize(context, 40),
                  right: Utils.getPXSize(context, 40),
                ),
            child: bottomDivider
                ? Divider(
                    height: Utils.getPXSize(context, 1),
                  )
                : null,
          )
        ],
      ),
    );
  }
}
