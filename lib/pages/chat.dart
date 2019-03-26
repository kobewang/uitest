import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// 实时聊天demo
///
///
class ChatPage extends StatefulWidget {
  @override
  createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  var isShowEmoji = false; //是否显示表情
  var isLoading = true;
  var themeColor = Color(0xfff5a623);
  var primaryColor = Color(0xff203152);
  var toHeadImg = "https://www.22.cn/Content/images/logo.png";
  var groupChatId = '2222';
  List listData = [
    {"isMy": 1, "type": 0, "content": "你好"},
    {"isMy": 0, "type": 0, "content": "你好，有什么需求"},
    {"isMy": 1, "type": 0, "content": "我想问个问题"},
    {"isMy": 0, "type": 0, "content": "您请说"},
    {
      "isMy": 1,
      "type": 1,
      "content":
          "https://gss0.bdstatic.com/94o3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D220/sign=9a8c284463d0f703e2b292de38fb5148/37d3d539b6003af32a18a233342ac65c1138b6c6.jpg"
    }, //图片
    {"isMy": 1, "type": 2, "content": "emoji1.jpg"}, //表情
  ];
  TextEditingController inputCtrl = new TextEditingController();
  ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  listMessage() {
    return Flexible(
        child: groupChatId == ''
            ? Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
            : ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  return listItem(context, index);
                },
                reverse: false, //倒序
                controller: listScrollController,
              ));
  }

  showEmoji() {
    return Text('表情包');
  }

  onSendMessage(String content) {}

  inputChat() {
    return Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
            border: Border(
                top: new BorderSide(color: Color(0xffE8E8E8), width: 0.5)),
            color: Colors.white),
        child: Row(
          children: <Widget>[
            Material(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  child: IconButton(
                    icon: new Icon(Icons.image),
                    onPressed: () {},
                    color: primaryColor,
                  ),
                ),
                color: Colors.white),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: new Icon(Icons.face),
                onPressed: () {},
                color: primaryColor,
              ),
            ),
            Flexible(
                child: Container(
                    child: TextField(
              style: TextStyle(color: primaryColor, fontSize: 15.0),
              controller: inputCtrl,
              decoration: InputDecoration.collapsed(
                  hintText: '请输入..', hintStyle: TextStyle(color: Colors.grey)),
              focusNode: focusNode,
            ))),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: new Icon((Icons.send)),
                onPressed: () => onSendMessage,
              ),
            )
          ],
        ));
  }

  loading() {
    return Positioned(
        child: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
                ),
                color: Colors.white.withOpacity(0.8),
              )
            : Container());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('聊天Demo')),
        body: WillPopScope(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  listMessage(),
                  isShowEmoji ? showEmoji() : Container(),
                  inputChat()
                ],
              ),
              //loading()
            ],
          ),
        ));
  }

  listItem(context, index) {
    //右边：我
    if (listData[index]['isMy'] == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          listData[index]['type'] == 0
              ? Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: 200,
                  margin: EdgeInsets.only(bottom: 10, right: 10),
                  child: Text(listData[index]['content'],
                      style: TextStyle(color: primaryColor)),
                      decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(8.0)),
                  )
              : Container(
                  width: 0,
                  height: 0,
                )
        ],
      );
    }
    //左边：对方
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              //对方头像
              CircleAvatar(
                  child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      ),
                      width: 35.0,
                      height: 35.0,
                      padding: EdgeInsets.all(10.0),
                    ),
                imageUrl: toHeadImg,
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              )),
              //对方信息
              listData[index]['type'] == 0
                  ? Container(
                      child: Text(listData[index]['content'],style: TextStyle(color: Colors.white),),
                      padding:EdgeInsets.fromLTRB(15, 10, 15, 10),
                      width: 200,
                      decoration: BoxDecoration(color: primaryColor,borderRadius:BorderRadius.circular(8.0) ),
                      margin: EdgeInsets.only(left: 10),
                    )
                  : Text('')
            ],
          )
        ],
      ),
    );
  }
}
