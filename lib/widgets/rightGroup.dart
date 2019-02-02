import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uitest/model/typeInfo.dart';
import 'package:uitest/pages/groupes.dart';
import 'package:uitest/utils/eventBus.dart';

/// 右侧分组列表
///
/// auth:wyj date:20190131
class RightGroup extends StatefulWidget {
  bool isGroup = true;
  RightGroup({Key key,this.isGroup}):super(key:key);
  @override
  createState ()=> RightGroupState();
}
class RightGroupState extends State<RightGroup> {
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
      margin: EdgeInsets.only(top: 5.0,bottom: 5.0,right: 2.0),
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
          boxShadow: [
          new BoxShadow(color: Colors.grey[300],offset: new Offset(1.0,1.0),blurRadius: 1.0),
          new BoxShadow(color: Colors.grey[300],offset: new Offset(-1.0,-1.0),blurRadius: 1.0),
          new BoxShadow(color: Colors.grey[300],offset: new Offset(1.0,-1.0),blurRadius: 1.0),
          new BoxShadow(color: Colors.grey[300],offset: new Offset(-1.0,1.0),blurRadius: 1.0),
          ]
      ),   
      child: 
        Container(
          color: Colors.white,
          child: 
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: typeInfo.groupList.length+1,
            itemBuilder: (context,index){
              if(index==0) {
                return new Container(
                  margin: EdgeInsets.only(bottom: 2.0,left: 5.0),
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      Text('分组信息',style: TextStyle(fontWeight: FontWeight.bold)),
                      Divider(color: Colors.grey,height: 1.0)
                    ],
                  )
                  
                );
              } else {
                var item = new Container(
                  margin: EdgeInsets.only(bottom: 2.0),
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          Expanded(child: 
                            Text('【${typeInfo.groupList[index-1].id}】${typeInfo.groupList[index-1].name}')
                          ),
                          Icon(Icons.arrow_right)
                        ],
                      ),
                      Divider(color: Colors.grey,height: 1.0)
                    ],
                  )
                );
                if(widget.isGroup) { //跳转到分组列表
                  return GestureDetector(
                    child: item,
                    onTap: (){
                          Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new GroupesPage(typeId: typeInfo.id)));
                    },
                  );
                } else {
                  return item;
                }
              }
            },
          )
        )
    );
  }
}

