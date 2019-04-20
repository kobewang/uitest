import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluwx/fluwx.dart';
import 'package:uitest/utils/utils.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:uitest/widgets/mydialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_qq_bridge/flutter_qq_bridge.dart';

/// auth:wyj
/// desc:分享页测试
/// date:20190405
class SharePage extends StatefulWidget {
  @override
  createState() => SharePageState();
}

class SharePageState extends State<SharePage> {

  @override
  initState() {
    registerQQ();  
  }
  registerQQ() async {
    await FlutterQqBridge.registerQq('androidAppId', 'iOSAppId');
  }


  //底部弹窗分享
  showShareBottom() {
    showModalBottomSheet(
        builder: (_) {
          return BottomShareModalContent();
        },
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            InkWell(
                child: Icon(Icons.share),
                onTap: () {
                  showShareBottom();
                })
          ],
        ),
        body: Center(child: Text('body')));
  }
}

///底部弹窗内容
class BottomShareModalContent extends StatefulWidget {
  String title;
  String url;
  BottomShareModalContent({Key key,@required this.title,this.url}):super(key:key);
  @override
  createState() => BottomModalContentState();
}

class BottomModalContentState extends State<BottomShareModalContent> {
  List iconList = [
    {'title': '微信', 'img': 'images/share_wechat.png'},
    {'title': '朋友圈', 'img': 'images/share_pyq.png'},
    {'title': 'QQ', 'img': 'images/share_qq.png'},
    {'title': '微博', 'img': 'images/share_weibo.png'},
    {'title': '复制链接', 'img': 'images/share_url.png'},
    {'title': '浏览器', 'img': 'images/share_browser.png'},
    {'title': '', 'img': ''},
    {'title': '', 'img': ''}
  ];
  /**
 * 在浏览器中打开
 */
static Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('浏览器打开失败:'+url);
  }
}
  //分享Item点击
  gridItemClick(String title) {
    switch (title) {
      case '微信':
       fluwx.WeChatScene scene = fluwx.WeChatScene.SESSION;
        fluwx
            .share(WeChatShareTextModel(
                text: widget.title,
                transaction: "",
                scene: scene))
            .then((data) {
        });
        break;
      case '朋友圈':
        fluwx.WeChatScene scene = fluwx.WeChatScene.TIMELINE;
        fluwx
            .share(WeChatShareTextModel(
                text: widget.title,
                transaction: "",
                scene: scene))
            .then((data) {
        });
        break;
      case 'QQ':
        print('请先配置QQ开放应用');
        break;
      case '微博':
        print('请先配置微博开放应用');//fake_weibo
        break;
      case '复制链接':
          Clipboard.setData(new ClipboardData(text: widget.url));  
        break;
      case '浏览器':
        launchURL(widget.url);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: Utils.getPXSize(context, 600),
      padding: EdgeInsets.only(top: Utils.getPXSize(context, 30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              child: Center(
                  child: Text(
            '分享到',
            style: TextStyle(
                fontSize: Utils.getPXSize(context, 36),
                color: Color(0xFF555555)),
          ))),
          Container(
            height: Utils.getPXSize(context, 384),
            margin: EdgeInsets.only(top: Utils.getPXSize(context, 50)),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  childAspectRatio: 1 //宽高比
                  ),
              itemCount: 8,
              itemBuilder: (__, index) {
                return gridItem(__, index);
              },
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Expanded(
              child: InkWell(
                  child: Center(child: Text('取消')),
                  onTap: () {
                    Navigator.of(context).pop();
                  }))
        ],
      ),
    );
  }

  //分享图标Item
  gridItem(BuildContext context, int index) {
    return InkWell(
        onTap: () {
          gridItemClick(iconList[index]['title']);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            iconList[index]['img'] == ''
                ? Container()
                : Image.asset(
                    iconList[index]['img'],
                    width: 50.0,
                    height: 50.0,
                  ),
            iconList[index]['title'] == ''
                ? Container()
                : Text(
                    iconList[index]['title'],
                    style: TextStyle(
                        fontSize: Utils.getPXSize(context, 26),
                        color: Color(0xFF555555)),
                  )
          ],
        ));
  }
}
