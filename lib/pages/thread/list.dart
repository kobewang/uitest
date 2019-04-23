import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/dao/threadDao.dart';
import 'package:uitest/model/threadListInfo.dart';
import 'package:uitest/model/threadListItemInfo.dart';
import 'package:uitest/pages/layout/listlayout.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/CustomButton.dart';
import 'package:uitest/widgets/customflatbutton.dart';
import 'package:uitest/widgets/triangle.dart';

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
      if (list == null)
        list = ThreadListInfo.getList(res.data['Data']['List']);
      else
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
          centerTitle: true,
          elevation: 0, //阴影
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                Widget>[
              //头像
              Container(
                child: CircleAvatar(
                    backgroundImage: NetworkImage(threadInfo.head)),
                height: 40,
                width: 40,
              ),
              //作者，类型，电话
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 5, right: rightEdge),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //作者
                              Row(children: <Widget>[
                                Container(
                                  width: 150,
                                  child:
                                Text(threadInfo.name,
                                overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            Utils.getPXSize(context, 32)))),
                                threadInfo.isVip == 1
                                    ? Image.asset(
                                        'images/diamond.png',
                                        width: 20,
                                        height: 20,
                                      )
                                    : Container()
                              ]),
                              //类别+商圈
                              Container(
                                  margin: EdgeInsets.only(top: 2),
                                  child: Row(children: <Widget>[
                                    getTdLable(threadInfo.area, Colors.orange),
                                    Container(
                                        margin: EdgeInsets.only(left: 3),
                                        child: getTdLable(
                                            threadInfo.type, Colors.green))
                                  ]))
                            ],
                          ),
                          CustomButton(
                            text: '电话',
                            widthPx: 120,
                            heightPx: 55,
                            fontSizePx: 26,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      )))
            ]),
            //内容行
            getRowChild(Text(
              threadInfo.content ?? '',
              style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: Utils.getPXSize(context, 28)),
            )),

            //图片行
            getRowChild(threadPicList(index)),
            //时间行
            getRowChild(Row(
              children: <Widget>[
                Text(
                  threadInfo.addtime,
                  style: TextStyle(
                      fontSize: Utils.getPXSize(context, 24),
                      color: Color(0xFF666666)),
                )
              ],
            )),
            //地址行
            getRowChild(Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                Expanded(
                    child: Text(threadInfo.address ?? '',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: Utils.getPXSize(context, 30))))
              ],
            )),
            //状态行
            getRowChild(getTdStatus(index, rightEdge))
          ],
        ));
  }

  //UI-帖子图片,9宫图
  Widget threadPicList(int index) {
    var num = list[index].picList.length;
    if (num == 0) return Container();
    int yu = num % 3; //取余
    int zhen = num ~/ 3; //取整
    var row = yu == 0 ? zhen : zhen + 1; //行数
    var picWidth = 220.0;
    var picHeight = 220.0;
    var listRows = new List<Widget>();
    for (var i = 0; i < row; i++) {
      var listPics = new List<Widget>();
      for (var j = 0; j < 3; j++) {
        var picIndex = i * 3 + j;
        if (picIndex < num) {
          var img = list[index].picList[(picIndex)];
          listPics.add(Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.network(img,
                      width: Utils.getPXSize(context, picWidth),
                      height: Utils.getPXSize(context, picHeight)))));
        } else {
          //不够的补空
          listPics.add(Container());
        }
      }
      listRows.add(Row(children: listPics));
    }
    return Column(children: listRows);
  }

  ///UI-标签
  Widget getTdLable(String title, Color color) {
    return CustomFlatButton(
      height: 20,
      width: 60,
      textColor: color,
      child: Text(
        title,
        style: TextStyle(fontSize: Utils.getPXSize(context, 20), color: color),
      ),
    );
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
    var colorStatusGrey = Colors.grey[300]; //状态行灰色
    var fontSize = Utils.getPXSize(context, 26);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: 10),
            child:
                Triangle(myColor: colorStatusGrey, width: 10, orientation: 1)),
        Container(
            margin: EdgeInsets.only(right: rightEdge),
            decoration:
                new BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
              new BoxShadow(
                  color: colorStatusGrey,
                  offset: Offset(1.0, 1.0),
                  blurRadius: 1.0),
              new BoxShadow(
                  color: colorStatusGrey,
                  offset: Offset(-1.0, -1.0),
                  blurRadius: 1.0),
              new BoxShadow(
                  color: colorStatusGrey,
                  offset: Offset(1.0, -1.0),
                  blurRadius: 1.0),
              new BoxShadow(
                  color: colorStatusGrey,
                  offset: Offset(-1.0, 1.0),
                  blurRadius: 1.0),
            ]),
            height: 25.0,
            width: MediaQuery.of(context).size.width - 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 5),
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                        size: 15,
                      )),
                  Text(list[index].views.toString(),
                      style: TextStyle(
                          fontSize: fontSize,
                          color: Theme.of(context).primaryColor)),
                  Text('人浏览',
                      style: TextStyle(
                          fontSize: fontSize, color: Color(0xFF666666))),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 5),
                    child: Icon(
                      Icons.thumb_up,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ),
                  Text(list[index].likes.toString(),
                      style: TextStyle(
                          fontSize: fontSize,
                          color: Theme.of(context).primaryColor)),
                  Text('人点赞',
                      style: TextStyle(
                          fontSize: fontSize, color: Color(0xFF666666))),
                ]))
      ],
    );
  }
}
