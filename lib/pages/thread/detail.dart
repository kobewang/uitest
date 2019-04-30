import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/dao/threadDao.dart';
import 'package:uitest/model/threadInfo.dart';
import 'package:uitest/pages/thread/widgets/authorRow.dart';
import 'package:uitest/pages/thread/widgets/nineMap.dart';
import 'package:uitest/pages/thread/widgets/threadContent.dart';
import 'package:uitest/pages/thread/widgets/threadTime.dart';
import 'package:uitest/pages/thread/widgets/threadAddr.dart';
import 'package:uitest/pages/thread/widgets/threadLabel.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/CustomButton.dart';

/// auth: wyj
/// desc: 帖子详情
/// date: 20190425
class ThreadDetailPage extends StatefulWidget {
  int tid;
  ThreadDetailPage({Key key, this.tid}) : super(key: key);
  @override
  createState() => ThreadDetailPageState();
}

class ThreadDetailPageState extends State<ThreadDetailPage> {
  //参数定义
  ThreadInfo threadInfo;
  @override
  initState() {
    loadData();
    super.initState();
  }

  //接口获取详情
  Future<void> loadData() async {
    var info = await ThreadDao.detail(widget.tid);
    setState(() {
      threadInfo = info;
    });
  }

  //首页点击事件
  _indexClickEvent() {}
  _publishClickEvent() {}
  //拨号点击事件
  _mobileClickEvent() {}

  @override //以build为界限，以上：(1)参数（2）方法 (3)事件，事件以_开头；以下：界面UI部分
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('帖子详情'), elevation: 0, centerTitle: true),
      bottomNavigationBar: bottomMenu(),
      body: threadInfo == null
          ? Center(child: CupertinoActivityIndicator())
          : RefreshIndicator(
              onRefresh: loadData,
              child: ListView(
                children: <Widget>[
                  //作者行
                  listItemAuth(),
                  //分隔行
                  listDivider(),
                  //正文行
                  listItemContent(),
                  //图片行
                  listItemPics(),
                  //状态行
                  listItemStatus(),
                  //阅览数
                  listItemViewer(),
                  //评论部分
                  listItemComment()
                ],
              )),
    );
  }

  ///UI-底部固定菜单
  Widget bottomMenu() {
    return BottomAppBar(
      child: Container(
          height: 50,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                bottomMenuItem('首页', 1, () {
                  print('首页');
                }),
                bottomMenuItem('发布', 1, () {
                  print('发布');
                }),
                bottomMenuItem('私信', 1, () {
                  print('私信');
                }),
                bottomMenuItem('一键拨号', 2, () {
                  loadData();
                }, mobile: '151****11*1'),
              ])),
    );
  }

  ///UI-底部菜单项
  Widget bottomMenuItem(String title, int flexWeight, VoidCallback callBack,
      {String mobile = ''}) {
    var isMobile = title == '一键拨号';
    var greyColor = Color(0xFF64727b);
    var iconW = 20.0;
    Widget icon;
    switch (title) {
      case '首页':
        icon = Image.asset('images/ic_home.png',
            color: greyColor, width: iconW, height: iconW);
        break;
      case '发布':
        icon = Image.asset('images/ic_publish.png',
            color: greyColor, width: iconW, height: iconW);
        break;
      case '私信':
        icon = Image.asset('images/ic_chat.png',
            color: greyColor, width: iconW, height: iconW);
        break;
    }
    return Expanded(
        child: GestureDetector(
            onTap: callBack,
            child: Container(
                color: isMobile ? Theme.of(context).primaryColor : Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    isMobile
                        ? Text(
                            title,
                            style: TextStyle(color: Colors.white),
                          )
                        : icon,
                    Text(
                      isMobile ? mobile : title,
                      style:
                          TextStyle(color: isMobile ? Colors.white : greyColor),
                    )
                  ],
                ))),
        flex: flexWeight);
  }

  ///UI-item layout
  listItemLayout(Widget child,{double marginTop= 0.0}) {
    return Container(
        margin: EdgeInsets.only(top:marginTop),
        padding: EdgeInsets.only(left: 10, right: 10), child: child);
  }
  ///UI-分隔行
  listDivider() {
    return listItemLayout(Divider(height: 2,),marginTop: 3);
  }
  ///UI-作者
  listItemAuth() {
    var child = ThreadAuthorRow(threadInfo: threadInfo);
    return listItemLayout(child,marginTop: 10);
  }

  ///UI-正文
  listItemContent() {
    return listItemLayout(ThreadContent(content:threadInfo.content,id:threadInfo.id),marginTop: 6);
  }

  ///UI-图片行
  listItemPics() {
    return listItemLayout(NineMap(threadInfo:threadInfo));
  }

  ///UI-状态行
  listItemStatus() {
    return listItemLayout(Text('状态'));
  }

  ///UI-阅读列表
  listItemViewer() {
    return listItemLayout(Text('阅读'));
  }

  ///UI-评论
  listItemComment() {
    return listItemLayout(Text('评论'));
  }
}

