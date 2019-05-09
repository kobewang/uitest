import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/pages/thread/detail.dart';
import 'package:uitest/pages/thread/widgets/threadTime.dart';
import 'package:uitest/utils/myDialog.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/triangle.dart';
import 'package:uitest/dao/threadDao.dart';

/// auth:wyj
/// desc:帖子数据状态,阅读，点赞，店铺
/// date:20190429
class ThreadStatus extends StatefulWidget {
  dynamic threadInfo;
  double rightEdge;
  var isLike = false;

  ///是否列表用
  bool isList;
  ThreadStatus({Key key, this.threadInfo, this.rightEdge, this.isList})
      : super(key: key);
  @override
  createState() => ThreadStatusState();
}

class ThreadStatusState extends State<ThreadStatus> {
  //点赞事件
  _likeClick()  async{
    MyDialog.showLoading(context, '提交中..');
    var res= await ThreadDao.like(widget.threadInfo.id,widget.threadInfo.isLike == 0?true:false);
    if(res!=null) {
      Navigator.of(context).pop();
       setState(() {
         var oldIsLike=widget.threadInfo.isLike;
        widget.threadInfo.isLike = oldIsLike == 0?1:0;
        widget.threadInfo.likes = oldIsLike == 0?widget.threadInfo.likes + 1:widget.threadInfo.likes - 1;
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    var colorStatusGrey = Colors.grey[300]; //状态行灰色
    var fontSize = Utils.getPXSize(context, 26);
    var rowWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.isList
            ? Container(
                margin: EdgeInsets.only(left: 5),
                child: Triangle(
                    myColor: colorStatusGrey, width: 10, orientation: 1))
            : Container(),
        Container(
          margin: EdgeInsets.only(right: widget.rightEdge),
          decoration: widget.isList
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
          width: MediaQuery.of(context).size.width,
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
                  Text(widget.threadInfo.views.toString(),
                      style: TextStyle(
                          fontSize: fontSize,
                          color: Theme.of(context).primaryColor)),
                  Text('人浏览',
                      style: TextStyle(
                          fontSize: fontSize, color: Color(0xFF666666))),
                  GestureDetector(
                      onTap: () {
                        _likeClick();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        child: Icon(
                          Icons.thumb_up,
                          color: widget.threadInfo.isLike == 1
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          size: 15,
                        ),
                      )),
                  Text(widget.threadInfo.likes.toString(),
                      style: TextStyle(
                          fontSize: fontSize,
                          color: Theme.of(context).primaryColor)),
                  Text('人点赞',
                      style: TextStyle(
                          fontSize: fontSize, color: Color(0xFF666666))),
                ]),
                widget.isList
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (contexzt) {
                            return ThreadDetailPage(tid: widget.threadInfo.id);
                          }));
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text('立即查看>>',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: fontSize))))
                    : ThreadTime(addtime: widget.threadInfo.addtime)
              ]),
        )
      ],
    );
    return GestureDetector(
        child: rowWidget,
        onTap: () {
          if (widget.isList) {
            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (contexzt) {
              return ThreadDetailPage(tid: widget.threadInfo.id);
            }));
          }
        });
  }
}
