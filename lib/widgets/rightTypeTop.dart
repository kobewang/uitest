import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/model/typeInfo.dart';
import 'package:uitest/utils/eventBus.dart';
import 'package:uitest/utils/utils.dart';
/// 右侧顶部详细
/// 
/// auth:wyj date:20190131
class RightTypeTop extends StatefulWidget {
  @override
  createState ()=> RightTypeTopState();
}
class RightTypeTopState extends State<RightTypeTop> {
  TypeInfo typeInfo =new TypeInfo(id: 1,name: '商标分类',summary: '分类详细描述',groupList: []);

  @override
  void initState() {
    eventBus.on<TypeSelectEvent>().listen((TypeSelectEvent data) =>
      show(data.typeInfo)
    );
  }
  void show(TypeInfo info) {
    setState(() {
      typeInfo = info;      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width-4.0,
      margin: EdgeInsets.only(top: 5.0,bottom: 5.0,right: 2.0),
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
          boxShadow: [
          new BoxShadow(color: Colors.blue[300],offset: new Offset(1.0,1.0),blurRadius: 1.0),
          new BoxShadow(color: Colors.blue[300],offset: new Offset(-1.0,-1.0),blurRadius: 1.0),
          new BoxShadow(color: Colors.blue[300],offset: new Offset(1.0,-1.0),blurRadius: 1.0),
          new BoxShadow(color: Colors.blue[300],offset: new Offset(-1.0,1.0),blurRadius: 1.0),
          ]
      ),   
      child: 
        Container(color: Colors.white,child: 
           new Column(
             children: <Widget>[
              Text('第${Utils.FormateType(typeInfo.id)}类 ${typeInfo.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0)),
              Expanded(child:           
                Container(child: 
                  Text(typeInfo.summary,maxLines:3,overflow: TextOverflow.ellipsis)
                )
              )
              ],
            ) 
        )
    );
  }
}

