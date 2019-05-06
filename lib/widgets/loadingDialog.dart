import 'package:flutter/material.dart';
class  LoadingDialog extends Dialog {
  String  text='加载中';
  LoadingDialog({Key key,this.text}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Material(//创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        child:  new SizedBox(
          width: 120.0,
          height: 120.0,
          child: Container(
            decoration: ShapeDecoration(
              color: Color(0xFFffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0)
                )
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                new Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(text,style: new TextStyle(fontSize: 12.0)),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}