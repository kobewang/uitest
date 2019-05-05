import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/dao/threadDao.dart';
import 'package:uitest/model/threadListInfo.dart';
import 'package:uitest/model/threadListItemInfo.dart';
import 'package:uitest/pages/layout/listlayout.dart';
import 'package:uitest/pages/thread/detail.dart';
import 'package:uitest/pages/thread/widgets/authorRow.dart';
import 'package:uitest/pages/thread/widgets/nineMap.dart';
import 'package:uitest/pages/thread/widgets/threadAddr.dart';
import 'package:uitest/pages/thread/widgets/threadContent.dart';
import 'package:uitest/pages/thread/widgets/threadStatus.dart';
import 'package:uitest/pages/thread/widgets/threadTime.dart';


/// 帖子列表页
///
/// auth:wyj date:20190326
class ThreadList extends StatefulWidget {
  @override
  createState() => ThreadListState();
}

class ThreadListState extends State<ThreadList> {
  List<ThreadListItemInfo> list;
  int _curPage = 1;
  var _loadFailed = true;

  ///加载列表
  Future<List<ThreadListItemInfo>> loadList() async {
    var res = await ThreadDao.list(page: _curPage);
    if (res == null) {
      setState(() {
        _loadFailed = true;
        return null;
      });
    }
    setState(() {
      _loadFailed = false;
      if (list == null || _curPage == 1)
        list = ThreadListInfo.getList(res.data['Data']['List']);
      else
        list.addAll(ThreadListInfo.getList(res.data['Data']['List']));
      print(list.length);
    });
    return list;
  }

  ///详情点击事件
  _detailClick(int id) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (contexzt) {
      return ThreadDetailPage(tid: id);
    }));
  }

  @override //以build为界限，以上：(1)参数（2）方法 (3)事件，事件以_开头；以下：界面UI部分
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('帖子列表'),
          centerTitle: true,
          elevation: 0, //阴影
        ),
        body: ListLayout(
          loadFailded: _loadFailed,
          refresh: () {
            _curPage = 1;
            return loadList();
          },
          more: () {
            _curPage = _curPage + 1;
            return loadList();
          },
          builder: (_, __) {
            return ListView.separated(
              itemCount: list.length,
              separatorBuilder: (_, i) {
                return Container(
                  height: 10,
                  color: Color(0xFFececec),
                );
              },
              itemBuilder: (_, i) {
                return threadItem(_, i);
              },
            );
          },
        ));
  }

  //UI-详情Item
  Widget threadItem(BuildContext context, int index) {
    var threadInfo = list[index];
    var rightEdge = 7.0; //右边距
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //作者行
            ThreadAuthorRow(threadInfo: threadInfo),
            //内容行
            getRowChild(ThreadContent(content: threadInfo.content,id:threadInfo.id)),
            //图片行
            getRowChild(threadPicList(index)),
            //时间行
            getRowChild(ThreadTime(addtime: threadInfo.addtime)),
            //地址行
            getRowChild(ThreadAddr(address: threadInfo.address)),
            //状态行
            getRowChild(getTdStatus(index, rightEdge))
          ],
        ));
  }

  //UI-帖子图片,9宫图
  Widget threadPicList(int index) {
    return NineMap(threadInfo: list[index]);
  }

  ///UI-返回统一间距的row控件
  Widget getRowChild(Widget childWidget) {
    var leftMargin = 40.0; //统一靠左距离
    var rowMargin = 5.0; //统一行间距
    return Container(
        margin: EdgeInsets.only(left: leftMargin, top: rowMargin),
        child: childWidget);
  }

  ///UI-返回数据状态
  Widget getTdStatus(int index, double rightEdge) {
    return ThreadStatus(
        threadInfo: list[index], rightEdge: rightEdge, isList: true);
  }
}
