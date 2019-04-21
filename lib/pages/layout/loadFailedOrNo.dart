import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/widgets/customflatbutton.dart';
///
/// desc:加载失败或加载为空
///
class LoadFailedOrNo extends StatelessWidget {
  final bool isFailed;
  final VoidCallback onReload;
  final EdgeInsetsGeometry padding;
  final String text;
  const LoadFailedOrNo({
    Key key,
    @required this.isFailed,
    this.onReload,
    this.padding,
    this.text
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Center(
        child: Column(
          mainAxisAlignment: padding==null?MainAxisAlignment.center:MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(isFailed?'images/load-failed.png':'images/load-nocontent.png',width: 80,height: 80,),
            Container(height: 10),
            Text(text?? (isFailed?'页面加载失败，请稍后重试':'暂无可用记录'),
            style: TextStyle(fontSize: 10,color: Color(0xFF999999)),
            ),
            Container(height: 10),
            onReload==null ?Container():
            CustomFlatButton(
              width:80,
              height:20,
              borderRadius:BorderRadius.all(Radius.circular(15)),
              child:Text('重新加载',style:TextStyle(fontSize: 10)),
              onPressed:onReload
            )
          ],
        ),
      ),
    );
  }
}