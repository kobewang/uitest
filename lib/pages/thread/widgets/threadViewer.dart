import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/triangle.dart';

/// auth:wyj
/// desc:帖子浏览列表
/// date:2019-05-05

class ThreadViewer extends StatelessWidget {
  List viewList;
  var rowCount = 10; //每行几个
  ThreadViewer({Key key, this.viewList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var colorStatusGrey = Colors.grey[300]; //状态行灰色
    int yu = viewList.length % rowCount; //取余
    int zhen = viewList.length ~/ rowCount; //取整
    var row = yu == 0 ? zhen : zhen + 1; //行数
    var rowWidget = viewList.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Triangle(
                        myColor: colorStatusGrey, width: 10, orientation: 1)),
                Container(
                    margin: EdgeInsets.only(right: 0),
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        boxShadow: [
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
                    height: 75.0,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return getRow(index + 1);
                      },
                      itemCount: row,
                    ))
              ]);
    return rowWidget;
  }

  getRow(row) {
    List<Widget> listWidget = [];
    for (var i = (row - 1) * rowCount; i < row * rowCount; i++) {
      if (viewList.length > i) {
        listWidget.add(
          Container(
            margin: EdgeInsets.only(top: 3, bottom: 3, right: 3, left: 2),
            child: viewList[i] == null
                ? Container()
                : CircleAvatar(
                    backgroundImage: NetworkImage(viewList[i] ?? '')),
            height: 30,
            width: 30,
          ),
        );
      }
    }
    return Row(children: listWidget);
  }
}
