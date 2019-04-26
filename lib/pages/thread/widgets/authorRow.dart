import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/model/threadInfo.dart';
import 'package:uitest/pages/thread/widgets/threadLabel.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/CustomButton.dart';

/// auth:wyj
/// desc:公用作者行
/// date:20190426

class ThreadAuthorRow extends StatelessWidget {
  dynamic threadInfo;
  ThreadAuthorRow({Key key, this.threadInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var rightEdge = 7.0; //右边距
    return //作者行
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          //头像
          Container(
            child: CircleAvatar(backgroundImage: NetworkImage(threadInfo.head)),
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
                            threadInfo.isVip == 1
                                ? Image.asset(
                                    'images/diamond.png',
                                    width: 20,
                                    height: 20,
                                  )
                                : Container(),
                            Container(
                                width: 150,
                                child: Text(threadInfo.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize:
                                            Utils.getPXSize(context, 32)))),
                          ]),
                          //类别+商圈
                          Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Row(children: <Widget>[
                                ThreadLabel(
                                    labelName: threadInfo.area,
                                    color: Colors.orange),
                                Container(
                                    margin: EdgeInsets.only(left: 3),
                                    child: ThreadLabel(
                                        labelName: threadInfo.type,
                                        color: Colors.green))
                              ]))
                        ],
                      ),
                      CustomButton(
                        text: '电话',
                        widthPx: 120,
                        heightPx: 55,
                        fontSizePx: 26,
                        color: Color(0xFF63BAD0),
                      )
                    ],
                  )))
        ]);
  }
}
