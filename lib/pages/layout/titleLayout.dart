import 'package:flutter/material.dart';

/// auth:wyj
/// desc:全局 titlelayout
/// date:20190524

class TitleLayout extends StatelessWidget {
  String title;
  Widget body;
  TitleLayout({Key key, this.title, this.body}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 1,
      ),
      body: body,
    );
  }
}
