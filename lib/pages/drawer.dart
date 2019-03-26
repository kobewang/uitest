import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/model/tmsearchInfo.dart';
import 'package:uitest/utils/tmtypes.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/mydrawer.dart';

/// 侧拉drawer测试
///
/// auth:wyj date:20190301
class DrawerPage extends StatefulWidget {
  @override
  createState() => DrawerPageState();
}

class DrawerPageState extends State<DrawerPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  void drawerCallBack(val) {
    TmSearchInfo searchInfo=new TmSearchInfo();
    searchInfo=val;
    print('val:${val.tmTypes}');
    print('searchInfo.cbTypes:${searchInfo.tmTypes}');
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
          child: Text('test')
      ),
      endDrawer:MyDrawer(callBack: (val)=>drawerCallBack(val),),
    );
  }
}
