import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uitest/utils/tmtypes.dart';
import 'package:uitest/widgets/leftTypeList.dart';
import 'package:uitest/widgets/rightGroup.dart';
import 'package:uitest/widgets/rightTypeTop.dart';
/// 分组列表
///
/// auth:wyj date:20190131
class GroupesPage extends StatefulWidget {
  int typeId;
  GroupesPage({Key key,this.typeId}) : super(key:key);
  @override
  createState ()=> GroupesPageState();
}
class GroupesPageState extends State<GroupesPage> {
  List leftTypeList=[];
  @override
  void initState() {
    super.initState();
    setState(() {
      getTypes();      
    });
    
  }
  void getTypes() {
    TmTypes.TYPES.forEach((item){
      if( int.parse(item['id'].toString()) > 0 ) {
      if( int.parse(item['id'].toString()) == 1 )
        item['checked']='on';
      else
        item['checked']='off';
      leftTypeList.add(item);
      }
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
          LeftTypeList(isType: true,leftList: leftTypeList),
          //右侧list
          Expanded(child: 
          Container(
            margin: EdgeInsets.only(left: 15.0),
            child: 
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RightTypeTop(),
                Expanded (child: 
                  RightGroup()
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