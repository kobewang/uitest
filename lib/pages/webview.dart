import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:uitest/utils/utils.dart';

/// webview公用
///
/// auth:wyj date:20190319
class WebViewPage extends StatefulWidget {
  String title;
  String url;
  WebViewPage({Key key, this.title, this.url}) : super(key: key);
  @override
  createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  bool loading = true;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  @override
  void initState() {
    super.initState();
    //flutterWebviewPlugin.onProgressChanged.listion((progress){});
    flutterWebviewPlugin.onStateChanged.listen((state) {});
    flutterWebviewPlugin.onStateChanged.listen((url) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(new Text(widget.title,
        style: new TextStyle(color: Colors.white, fontSize: 14.0)));
    if (loading) titleContent.add(new Container(width: 50.0));
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[],
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
      hidden: true,
      initialChild: Center(child: const CircularProgressIndicator()),
    );
  }
}
