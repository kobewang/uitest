import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// auth:wyj
/// desc:帖子发布页
/// date:20190509

class PublishThreadPage extends StatefulWidget {
  int typeId;
  String typeName;
  PublishThreadPage({Key key, this.typeId, this.typeName}) : super(key: key);
  @override
  createState() => PublishThreadPageState();
}

class PublishThreadPageState extends State<PublishThreadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('发布${widget.typeName}信息'), centerTitle: true, elevation: 1),
        body: ListView(
          children: <Widget>[
            
          ],
        ));
  }
}
