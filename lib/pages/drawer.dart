import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as Math;

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
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  CurvedAnimation curved; //曲线动画，动画插值，
  AnimationController controller; //动画控制器
  bool forward = true;
  bool typeOpen = true;
  @override
  void initState() {
    super.initState();
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
                        children: typeList()))
                : Container(width: 0, height: 0),
            ListTile(title: Text('dddd')),
            ListTile(title: Text('333')),
            ListTile(title: Text('fdsfds')),
          ],
        ),
      ),
    );
  }

  List<Widget> typeList() {
    var listWidget = List<Widget>();
    for (var i = 0; i < 14; i++) {
      listWidget.add(new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text('化学原料'), Text('化学原料'), Text('化学原料')]));
    }
    return listWidget;
  }

  Widget buildSubItem(BuildContext context, int index) {
    return Text('dddddss');
  }
}
