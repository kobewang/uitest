import 'package:flutter/material.dart';
import 'package:uitest/model/tmsearchInfo.dart';
class ChildPage extends StatefulWidget {
  final callback;
  ChildPage({Key key,this.callback}):super(key:key);
  @override
  createState()=> ChildPageState();
}
class  ChildPageState extends State<ChildPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: 
      Column(
        children: <Widget>[
          FlatButton(child: Text('子组件'),
          onPressed: (){
            TmSearchInfo searchInfo = new TmSearchInfo(tmTypes: '1,2,3',cbTypes: '2,2',price: 5000,len: 2,tmNameKey: '商标名称',tmRegnoKey: '注册号',tmGroupKey: '分组号',tmRangeKey: '范围');
            widget.callback(searchInfo);
          },
          )
        ],
      )
    );
  }
  
}