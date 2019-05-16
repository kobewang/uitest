import 'package:flutter/material.dart';
import 'package:uitest/utils/utils.dart';

class CustomInput extends StatelessWidget {
  final String iconPath; //图标路径地址
  final double iconSize;

  ///图标大小
  final Icon icon;
  final Color iconColor; //图标color
  final String placeholder; //占位符文字
  final TextEditingController controller;
  final Widget rightChild;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle textStyle;
  final TextStyle placeholderStyle;
  final bool borderLine;
  final double height;
  final EdgeInsetsGeometry contentPadding;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final int maxLength;

  CustomInput(
      {Key key,
      this.controller,
      this.iconPath,
      this.iconSize = 15.0,
      this.icon,
      this.iconColor,
      this.placeholder,
      this.rightChild,
      this.keyboardType,
      this.obscureText = false,
      this.textStyle,
      this.placeholderStyle,
      this.borderLine = true,
      this.height = 100.0,
      this.contentPadding,
      this.textDirection,
      this.textAlign: TextAlign.left,
      this.maxLength = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.getPXSize(context, height),
      child: Row(
        children: <Widget>[
          Container(
              margin: icon == null && iconPath == null
                  ? null
                  : EdgeInsets.only(right: Utils.getPXSize(context, 30)),
              child: icon != null
                  ? icon
                  : (iconPath == null || iconPath.isEmpty
                      ? null
                      : Image.asset(
                          iconPath,
                          width: iconSize,
                          height: iconSize,
                          color: iconColor ?? null,
                        ))),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: borderLine
                    ? Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(236, 236, 236, 1.0),
                        ),
                      )
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Directionality(
                        textDirection: textDirection ?? TextDirection.ltr,
                        child: TextField(
                          textDirection: textDirection ?? TextDirection.ltr,
                          textAlign: textAlign,
                          keyboardType: keyboardType,
                          keyboardAppearance: Brightness.light,
                          controller: controller,
                          maxLength: maxLength,
                          obscureText: obscureText,
                          style: textStyle ??
                              TextStyle(
                                fontSize: Utils.getPXSize(context, 30.0),
                                color: Colors.black,
                              ),
                          decoration: InputDecoration(
                            counterText: '',
                            counterStyle: TextStyle(fontSize: 0),
                            contentPadding: contentPadding,
                            hintText: placeholder,
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            /*
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.blue, //边框颜色为绿色
                            )),
                            */
                            hintStyle: placeholderStyle ??
                                TextStyle(
                                  fontSize: Utils.getPXSize(context, 30.0),
                                  color: Color(0xff999999),
                                ),
                          ),
                        )),
                  ),
                  rightChild ?? Container()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
