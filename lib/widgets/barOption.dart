import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluwx/fluwx.dart';
import 'package:share/share.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
class BarOptionWidget extends StatelessWidget {
  final OptionControl control;
  @override
  BarOptionWidget(this.control);  
  @override
  Widget build(BuildContext context) {
    return new PopupMenuButton(
      onSelected: 
      (String value){
        print('control.url:${control.url}');
        switch(value){
          case 'share':Share.share(control.url);break;       
          case 'pyq':
            fluwx.WeChatScene scene = fluwx.WeChatScene.TIMELINE;           
              fluwx.share(WeChatShareTextModel(
              text: "text from fluwx",
              transaction: "transaction}",
              scene: scene
            )).then((data) {
            print(data);
          });
          break;
          case 'copy':Share.share(control.url);break;
          case 'browser':Share.share(control.url);break;
        }
          
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        new PopupMenuItem(value: "share",child: Text('分享')),
        new PopupMenuItem(value: "pyq",child: Text('朋友圈')),
        new PopupMenuItem(value: "browser",child: Text('浏览器')),
        new PopupMenuItem(value: "copy",child: Text('复制')),
      ],
    );
  }
}

class OptionControl {
  String url = "https://example.com";
}
