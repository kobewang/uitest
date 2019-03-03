import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as Math;

import 'package:uitest/utils/tmtypes.dart';

/// 侧拉drawer测试
///
/// auth:wyj date:20190301
class DrawerPage extends StatefulWidget {
  @override
  createState() => DrawerPageState();
}

class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    return Math.sin(t * Math.pi / 2);
  }
}

class DrawerPageState extends State<DrawerPage>
    with SingleTickerProviderStateMixin {
  List typeList=[];
  List priceList=[
    {'name':'5千以下','id':'5000','checked':'off'},
    {'name':'5千-1万','id':'10000','checked':'off'},
    {'name':'1万-3万','id':'30000','checked':'off'},
    {'name':'3万-5万','id':'50000','checked':'off'},
    {'name':'5万-10万','id':'100000','checked':'off'},
    {'name':'待议价','id':'999999','checked':'off'},
  ];
  List priceCbType=[
    {'name':'中文','id':'0','checked':'off'},
    {'name':'英文','id':'1','checked':'off'},
    {'name':'图形','id':'2','checked':'off'},
    {'name':'中文英文','id':'3','checked':'off'},
    {'name':'中文图形','id':'4','checked':'off'},
    {'name':'中英图形','id':'6','checked':'off'}
  ];
  List priceLen=[
    {'name':'1个字','id':'1','checked':'off'},
    {'name':'2个字','id':'2','checked':'off'},
    {'name':'3个字','id':'3','checked':'off'},
    {'name':'4个字','id':'4','checked':'off'},
    {'name':'5个字','id':'5','checked':'off'},
    {'name':'5字以上','id':'6','checked':'off'},
  ];
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  CurvedAnimation curved; //曲线动画，动画插值，
  AnimationController controller; //动画控制器
  bool forward = true;
  bool typeOpen = true;
  @override
  void initState() {
    super.initState();
    TmTypes.TYPES.forEach((item){
      typeList.add({'name':item['title'],'id':item['id'],'checked':'on'});
    });
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 3));
    //controller.repeat();
    curved =
        new CurvedAnimation(parent: controller, curve: new ShakeCurve()); //翻转
    //curved = new CurvedAnimation(parent: controller, curve: Curves.easeIn); //翻转
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('drwader测试'),
        leading: Icon(Icons.search),
        actions: <Widget>[
          InkWell(
            child: Icon(Icons.search),
            onTap: () {
              _scaffoldKey.currentState.openEndDrawer(); // 右侧打开
            },
          )
        ],
      ),
      body: Center(
          child: AnimatedBuilder(
        animation: controller,
        child: Container(
          width: 150,
          height: 150,
          child: Icon(Icons.keyboard_arrow_up),
        ),
        builder: (BuildContext context, Widget _widget) {
          return new Transform.rotate(
            child: _widget,
            angle: controller.value * 6.3,
          );
        },
      )),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 20,
              color: Colors.blue[100],
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RotationTransition(
                        turns: curved,
                        child: InkWell(
                          child: typeOpen
                              ? Icon(Icons.keyboard_arrow_down)
                              : Icon(Icons.keyboard_arrow_up),
                          onTap: () {
                            setState(() {
                              typeOpen = !typeOpen;
                            });
                          },
                        )),
                    Text('商标分类')
                  ]),
            ),
            typeOpen
                ? Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: typeListWidget()))
                : Container(width: 0, height: 0),
          //length
          Divider(height: 1,color: Colors.grey),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              Text('长度')
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 30,
                    width: 80,
                    color: Color(0xFFf6f6f6),
                    child: Center(child:Text('1个字'))
                  ),                  
                  Text('2个字'),
                  Text('3个字'),
                ],
              )
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('4个字'),
                  Text('5个字'),
                  Text('6个字'),
                ],
              )
            ],)
          ])
          ],
        ),
      ),
    );
  }

  List<Widget> typeListWidget() {
    var listWidget = List<Widget>();
    print(typeList.length);
    for (var i = 0; i < 14; i++) {
      print(typeList[i*3+0]['name']);
      listWidget.add(new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(typeList[i*3+0]['name']), 
            Text(typeList[i*3+1]['name']), 
            Text(typeList[i*3+2]['name'])
            ]
           )
        );
    }
    return listWidget;
  }

  Widget buildSubItem(BuildContext context, int index) {
    return Text('dddddss');
  }
}
