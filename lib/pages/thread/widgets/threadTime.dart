import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/utils/utils.dart';

/// auth:wyj
/// desc:帖子时间控件
/// date:20190430
class ThreadTime extends StatelessWidget {
  String addtime;
  @override
  ThreadTime({Key key, this.addtime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(addtime??'',
            style: TextStyle(
              fontSize: Utils.getPXSize(context, 24),
              color: Color(0xFF919191),
            ))
      ],
    );
  }
}
