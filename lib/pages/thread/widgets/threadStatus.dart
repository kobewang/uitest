import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/pages/thread/detail.dart';
import 'package:uitest/pages/thread/widgets/threadTime.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/triangle.dart';

/// auth:wyj
/// desc:帖子数据状态,阅读，点赞，店铺
/// date:20190429
class ThreadStatus extends StatelessWidget {
  dynamic threadInfo;
  double rightEdge;

  ///是否列表用
  bool isList;
  ThreadStatus({Key key, this.threadInfo, this.rightEdge, this.isList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorStatusGrey = Colors.grey[300]; //状态行灰色
    var fontSize = Utils.getPXSize(context, 26);
    var rowWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        isList
            ? Container(
                margin: EdgeInsets.only(left: 5),
                child: Triangle(
                    myColor: colorStatusGrey, width: 10, orientation: 1))
            : Container(),
        Container(
          margin: EdgeInsets.only(right: rightEdge),
          decoration: isList
              ? new BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
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
                ])
              : BoxDecoration(),
          height: 25.0,
          width: MediaQuery.of(context).size.width - 50,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 0, right: 5),
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                        size: 15,
                      )),
                  Text(threadInfo.views.toString(),
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
                  Text(threadInfo.likes.toString(),
                      style: TextStyle(
                          fontSize: fontSize,
                          color: Theme.of(context).primaryColor)),
                  Text('人点赞',
                      style: TextStyle(
                          fontSize: fontSize, color: Color(0xFF666666))),
                ]),
                isList
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (contexzt) {
                            return ThreadDetailPage(tid: threadInfo.id);
                          }));
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text('立即查看>>',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: fontSize))))
                    : ThreadTime(addtime: threadInfo.addtime)
              ]),
        )
      ],
    );
    return GestureDetector(
        child: rowWidget,
        onTap: () {
          if (isList) {
            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (contexzt) {
              return ThreadDetailPage(tid: threadInfo.id);
            }));
          }
        });
  }
}
