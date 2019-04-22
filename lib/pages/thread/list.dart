import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/dao/threadDao.dart';
import 'package:uitest/model/threadListInfo.dart';
import 'package:uitest/model/threadListItemInfo.dart';
import 'package:uitest/pages/layout/listlayout.dart';

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

  Future<List<ThreadListItemInfo>> loadList() async {
    print('page:${_curPage}');
    var res = await ThreadDao.list(page: _curPage);
    //print(res.data['Data']);
    if (res == null) {
      setState(() {
        _loadFailed = true;
        return null;
      });
    }
    setState(() {
      _loadFailed = false;
      list.addAll(ThreadListInfo.getList(res.data['Data']['List']));
      print(list.length);
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('帖子列表'),
        ),
        body: ListLayout(
          loadFailded: _loadFailed,
          refresh: loadList,
          more: () {
            _curPage = _curPage + 1;
            return loadList();
          },
          builder: (_, __) {
            return ListView.separated(
              itemCount: list.length,
              separatorBuilder: (_, i) {
                return Divider(
                  height: 1,
                  color: Color(0xFFececec),
                );
              },
              itemBuilder: (_, i) {
                return threadItem(_,i);
              },
            );
          },
        ));
  }
  //UI-详情Item
  Widget threadItem(BuildContext context,int index) {
    return Container(
      padding: EdgeInsets.only(left: 3,right: 3,top: 3,bottom: 3),
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //作者行
          //内容行
          //图片行
          //地址行
          //状态行

        ],
      )
    );
  } 
}
