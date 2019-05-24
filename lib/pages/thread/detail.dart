import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/dao/threadDao.dart';
import 'package:uitest/model/threadInfo.dart';
import 'package:uitest/pages/member/login.dart';
import 'package:uitest/pages/thread/add.dart';
import 'package:uitest/pages/thread/report.dart';
import 'package:uitest/pages/thread/widgets/authorRow.dart';
import 'package:uitest/pages/thread/widgets/commentList.dart';
import 'package:uitest/pages/thread/widgets/nineMap.dart';
import 'package:uitest/pages/thread/widgets/threadAddr.dart';
import 'package:uitest/pages/thread/widgets/threadContent.dart';
import 'package:uitest/pages/thread/widgets/threadStatus.dart';
import 'package:uitest/pages/thread/widgets/threadTime.dart';
import 'package:uitest/pages/thread/widgets/threadViewer.dart';
import 'package:uitest/utils/myDialog.dart';
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
  List listComment = [];
  String _commentStr = '';
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
    var res = await ThreadDao.listComment(widget.tid);
    if (res != null) {
      setState(() {
        listComment = res.data['Data']['List'];
      });
    }
  }

  //首页点击事件
  _indexClickEvent() {}
  //发布点击事件
  _publishClickEvent() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_){
      return ThreadAddPage();
    }));
  }
  
  //拨号点击事件
  _mobileClickEvent() {}
  //私信点击
  _messageClickEvent(){
   Navigator.of(context).push(new MaterialPageRoute(builder:(_){
     return LoginPage();
   }));
  }
  //评论提交
  _commentClickEvent() async {
    if (_commentStr.isEmpty) {
      MyDialog.showToast('请输入评论内容');
      return;
    }
    MyDialog.showLoading(context, '提交中..');
    var res = await ThreadDao.addComment(widget.tid, _commentStr);
    if (res != null) {
      Navigator.of(context).pop();
      if (res.data['Code'] == 0) {
        MyDialog.showToast('评论成功');
        List cmtList = listComment;
        cmtList.addAll([
          {'Header': '', 'Name': '我', 'Addtime': '刚刚', 'Content': _commentStr}
        ]);
        setState(() {
          cmtBoxShow = false;
          cmtList = listComment;
        });
      } else {
        MyDialog.showToast(res.data['Data']);
      }
    }
  }

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
                  //时间行
                  //listItemTime(),
                  //地址行
                  listItemAddr(),
                  //分隔
                  listDivider(),
                  //状态行
                  listItemStatus(),
                  //阅览数
                  listItemViewer(),
                  //块状间隔
                  listBlockDivider(),
                  //评论行
                  listItemComment(),
                  //块状间隔
                  listBlockDivider(),
                  //举报行
                  listItemReport(),
                  //块状间隔
                  listBlockDivider()
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
                  _publishClickEvent();
                }),
                bottomMenuItem('私信', 1, () {
                  _messageClickEvent();
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
  listItemLayout(Widget child, {double marginTop = 0.0}) {
    return Container(
        margin: EdgeInsets.only(top: marginTop),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: child);
  }

  ///UI-list-分隔行
  listDivider() {
    return listItemLayout(
        Divider(
          height: 2,
        ),
        marginTop: 3);
  }

  ///UI-作者
  listItemAuth() {
    var child = ThreadAuthorRow(threadInfo: threadInfo);
    return listItemLayout(child, marginTop: 10);
  }

  ///UI-正文
  listItemContent() {
    return listItemLayout(
        ThreadContent(content: threadInfo.content, id: threadInfo.id),
        marginTop: 6);
  }

  ///UI-图片行
  listItemPics() {
    return listItemLayout(NineMap(threadInfo: threadInfo));
  }

  ///UI-时间行
  listItemTime() {
    return listItemLayout(ThreadTime(addtime: threadInfo.addtime));
  }

  ///UI-块-分割
  listBlockDivider() {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle, color: Colors.grey[300]),
        height: 10,
        margin: EdgeInsets.only(top: 20.0));
  }

  ///UI-地址行
  listItemAddr() {
    return listItemLayout(ThreadAddr(address: threadInfo.address));
  }

  ///UI-状态行
  listItemStatus() {
    return listItemLayout(
        ThreadStatus(threadInfo: threadInfo, rightEdge: 0.0, isList: false));
  }

  ///UI-阅读列表
  listItemViewer() {
    return listItemLayout(ThreadViewer(viewList: threadInfo.viewList));
  }

  bool cmtBoxShow = false; //显示评论框
  ///UI-评论
  listItemComment() {
    var cmtWidget = Container(
        //height: 40,
        padding: EdgeInsets.only(top: 5),
        child: Column(children: <Widget>[
          //表头行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('评论', style: TextStyle(fontSize: 15)),
              !cmtBoxShow
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          cmtBoxShow = !cmtBoxShow;
                        });
                      },
                      child: Text('发布',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15)))
                  : commentBth()
            ],
          ),
          Container(margin: EdgeInsets.only(top: 3), child: Divider(height: 1)),

          //暂无评论
          Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: !cmtBoxShow
                  ? listComment == null||listComment.length==0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.note_add,
                              color: Color(0xff858585),
                              size: 30,
                            ),
                            Text('还没有评论..',
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xff858585)))
                          ],
                        )
                      : CommentList(cmtList: listComment)
                  : Column(children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0xffd3d3d3), width: 1)),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            obscureText: false, //是否隐藏输入
                            textInputAction: TextInputAction.newline,
                            onChanged: (val) {
                              _commentStr = val;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "请输入评论内容",
                                hintStyle: TextStyle(
                                    fontSize: 15, color: Color(0xff858585))),
                          )),
                    ])),
        ]));
    return listItemLayout(cmtWidget);
  }

  ///评论操作按钮
  commentBth() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CustomButton(
              text: '取消',
              widthPx: 110,
              heightPx: 40,
              fontSizePx: 20,
              color: Colors.white,
              isOutLine: true,
              fontColor: Colors.black,
              borderColor: Color(0xff858585),
              onPressed: () {
                setState(() {
                  cmtBoxShow = false;
                });
              },
            ),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: CustomButton(
                  text: '发表',
                  widthPx: 110,
                  heightPx: 40,
                  fontSizePx: 20,
                  onPressed: () {
                    _commentClickEvent();
                  },
                )),
          ],
        ));
  }

  ///UI-举报行
  listItemReport() {
    var reportWidget = Container(
        padding: EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('如遇无效、虚假、诈骗信息，请立即举报',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 15)),
                Text(
                  '不法分子会通过微信等传播大量诈骗信息，请各位网友知晓并注意防范，不要轻易相信诈骗内容，增强自我防范意识，注意保护好个人隐私及密码保护以防被不法分子所利用。',
                  style: TextStyle(color: Color(0xff989694), fontSize: 12.5),
                )
              ],
            )),
            Container(
                width: 100,
                child: Column(
                  children: <Widget>[
                    Image.asset('images/ic_report.png',
                        color: Color(0xff57b6e7), width: 50, height: 50),
                    Text(
                      '举报',
                      style: TextStyle(
                        color: Color(0xff57b6e7),
                      ),
                    )
                  ],
                ))
          ],
        ));
    return listItemLayout(GestureDetector(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return ReportPage(threadId: widget.tid);
          }));
        },
        child: reportWidget));
  }
}
