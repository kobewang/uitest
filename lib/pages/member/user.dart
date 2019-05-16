import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uitest/config/constants.dart';
import 'package:uitest/pages/member/integral.dart';
import 'package:uitest/pages/member/profile.dart';
import 'package:uitest/pages/thread/mylist.dart';
import 'package:uitest/utils/utils.dart';

import '../about.dart';

/// auth:wyj
/// desc:用户中心
/// date:20190511

class UserPage extends StatefulWidget {
  @override
  createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  var iconW = 30.0;
  gotoClick(String title) {
    switch (title) {
      case 'mylist':
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return MyThreadList();
        }));
        break;
      case 'profile':
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return ProfilePage();
        }));
        break;
      case 'integral':
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return IntegralPage();
        }));
        break;
      case 'share': //分享朋友圈
        break;
      case 'about':
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return AboutPage();
        }));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          listHead(),
          listBlock(),
          listItem(
              Image.asset(
                'images/ic_publish.png',
                width: iconW,
                height: iconW,
                color: Theme.of(context).primaryColor,
              ),
              '我发布的', () {
            gotoClick('mylist');
          }),
          listDivider(),
          listItem(
              Icon(
                Icons.account_balance_wallet,
                size: iconW,
                color: Colors.orange,
              ),
              '我的积分', () {
            gotoClick('integral');
          }),
          listDivider(),
          listItem(Icon(Icons.settings, size: iconW), '设置中心', () {}),
          listDivider(),
          listItem(
              Icon(
                Icons.share,
                size: iconW,
                color: Colors.green,
              ),
              '邀请好友', () {
            gotoClick('share');
          }),
          listDivider(),
          listItem(
              Icon(
                Icons.info,
                size: iconW,
                color: Colors.blueGrey,
              ),
              '关于我们', () {
            gotoClick('about');
          }),
        ],
      ),
    );
  }

  //ui-head
  listHead() {
    return Container(
      height: Utils.getPXSize(context, 220),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        //行-设置
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 20,
                )),
          ],
        ),
        //行-头像
        Row(
          children: <Widget>[
            Container(
                height: 60,
                width: 60,
                child: CircleAvatar(
                    backgroundImage: NetworkImage(Constants.DEFAULT_HEAD_IMG))),
            Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Kobewang', style: TextStyle(color: Colors.white)),
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        child:
                            Text('普通会员', style: TextStyle(color: Colors.white)))
                  ],
                ))
          ],
        )
      ]),
    );
  }

  //ui-listitem
  listItem(Widget icon, String title, VoidCallback ontapClick) {
    return InkWell(
        onTap: ontapClick,
        child: Container(
            height: 50,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    icon,
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(title, style: TextStyle(fontSize: 15)))
                  ]),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 30,
                  )
                ])));
  }

  //ui-listdivider
  listDivider() {
    return Divider(height: 1, color: Colors.grey);
  }

  //ui-listblock
  listBlock() {
    return Container(
      height: 10,
      color: Color(0xFFececec),
    );
  }
}
