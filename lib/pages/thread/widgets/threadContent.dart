import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:uitest/pages/thread/detail.dart';
import 'package:uitest/utils/utils.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

/// auth:wyj
/// desc:帖子内容
class ThreadContent extends StatelessWidget {
  String content;
  int id;
  ThreadContent({Key key, this.content, this.id}) : super(key: key);
  @override
  build(BuildContext context) {
    var document =
        parse(content);
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (contexzt) {
            return ThreadDetailPage(tid: id);
          }));
        },
        child:
        Html(
  data: content,
  //Optional parameters:
  padding: EdgeInsets.all(8.0),
  backgroundColor: Colors.white70,
  defaultTextStyle: TextStyle(fontFamily: 'serif'),
  linkStyle: const TextStyle(
    color: Colors.redAccent,
  ),
  onLinkTap: (url) {
    // open url in a webview
  },
  
 
)
        /*
         Text(
          document.outerHtml ?? '',
          style: TextStyle(
              color: Color(0xFF111111), fontSize: Utils.getPXSize(context, 28)),
        )*/
        );
  }
}
