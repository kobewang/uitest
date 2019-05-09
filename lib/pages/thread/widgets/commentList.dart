import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// auth:wyj
/// desc:评论列表
/// date:20190507
class CommentList extends StatelessWidget {
  List cmtList;
  CommentList({Key key, this.cmtList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      //内容适配
      shrinkWrap: true,
      itemCount: cmtList.length,
      itemBuilder: (_, index) {
        return Column(children: <Widget>[
          Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //头像
                  cmtList[index]['Header'] == null||cmtList[index]['Header']==''
                      ? Container(width: 30,height:30)
                      : Container(
                          child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(cmtList[index]['Header'])),
                          height: 30,
                          width: 30,
                        ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(cmtList[index]['Name'] ?? ''),
                              Text(cmtList[index]['Addtime'] ?? '')
                            ],
                          )))
                ],
              )),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(width: 30),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(cmtList[index]['Content'] ?? ''),
                        Container(child: Divider(height: 1))
                      ],
                    )))
          ])
        ]);
      },
    );
  }
}
