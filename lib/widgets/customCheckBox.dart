import 'package:flutter/material.dart';
import 'package:uitest/utils/utils.dart';

class CustomCheckBox extends StatefulWidget {
  final bool value;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;
  final ValueChanged<bool> valueChanged;
  final Widget text;
  final double width;

  const CustomCheckBox({
    Key key,
    @required this.value,
    this.onTap,
    this.padding,
    this.margin,
    this.color,
    this.valueChanged,
    this.text,
    this.width=15.0
  }) : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool value;
  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          padding: widget.padding,
          margin: widget.margin,
          child: widget.text == null
              ? Image.asset(
                  (widget.valueChanged == null ? widget.value : value)
                      ? "images/checkbox.png"
                      : "images/checkbox_on.png",
                  color: widget.color,
                  height: widget.width,
                  width:  widget.width,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        (widget.valueChanged == null ? widget.value : value)
                            ? "images/checkbox_on.png"
                            : "images/checkbox.png",
                        color: widget.color,
                        height: widget.width,
                  width:  widget.width,
                      ),
                      margin:
                          EdgeInsets.only(right: Utils.getPXSize(context, 10)),
                    ),
                    widget.text
                  ],
                )),
      onTap: widget.valueChanged == null
          ? widget.onTap
          : () {
              setState(() {
                value = !value;
              });
              widget.valueChanged(value);
            },
    );
  }
}
