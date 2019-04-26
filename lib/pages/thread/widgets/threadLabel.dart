import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/customflatbutton.dart';

/// auth:wyj
/// desc:帖子标签
/// date:20190426
class ThreadLabel extends StatelessWidget {
  String labelName;
  MaterialColor color;
  ThreadLabel({Key key, this.labelName, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomFlatButton(
      height: 20,
      width: 60,
      textColor: color,
      child: Text(
        labelName,
        style: TextStyle(fontSize: Utils.getPXSize(context, 20), color: color),
      ),
    );
  }
}
