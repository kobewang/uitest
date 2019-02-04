import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uitest/dao/typesDao.dart';
import 'package:uitest/model/groupInfo.dart';
import 'package:uitest/model/typeInfo.dart';
import 'package:uitest/utils/tmtypes.dart';
import 'package:uitest/widgets/leftTypeList.dart';
import 'package:uitest/widgets/rightGroup.dart';
import 'package:uitest/widgets/rightTypeTop.dart';
/// 分组列表
///
/// auth:wyj date:20190131
class GroupesPage extends StatefulWidget {
  TypeInfo typeInfo;
  String groupId;
  GroupesPage({Key key,this.typeInfo,this.groupId}) : super(key:key);
  @override
  createState ()=> GroupesPageState();
}
class GroupesPageState extends State<GroupesPage> {
  List leftTypeList=[];
  String groupHeadStr="";
  @override
  void initState() {
    super.initState();
    setState(() {
      getTypes();    
    });
        
  }
  void getTypes() async{
    /*
    var result= await TypesDao.GroupList(widget.typeId);
    List<GroupInfo> list = result.data;
    print(list.length);
    list.forEach((item){
      print(item.name);
      var typeItem={'id':item.id.toString(),'title':item.name,'checked':'on'};
      leftTypeList.add(typeItem);
    });
    */
    widget.typeInfo.groupList.forEach((item){
      var typeItem={'title':item.id,'checked':'off'};
      if(widget.groupId==item.id){
        typeItem['checked']='on';
        groupHeadStr='【'+item.id+'】'+item.name;
      }
      leftTypeList.add(typeItem);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color.fromRGBO(255, 255, 254, 1.0),
      appBar:new AppBar(
        title: Text('搜索'),
      ),
      body: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //左侧list
          LeftTypeList(isType: false,leftList: leftTypeList),
          //右侧list
          Expanded(child: 
          Container(
            margin: EdgeInsets.only(left: 15.0),
            child: 
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RightTypeTop(isGroup: false, typeInfo: widget.typeInfo,),
                Expanded (child: 
                  RightGroup(isGroup: false,headStr:groupHeadStr)
                )
              ],
            )
          )
          )
        ],
      )
    );
  }
}