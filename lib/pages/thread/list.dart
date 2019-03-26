import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// 帖子列表页
///
/// auth:wyj date:20190326
class ThreadList extends StatefulWidget {
  @override
  createState() => ThreadListState();
}

class ThreadListState extends State<ThreadList> {
  List listData=[{'head'}];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('帖子列表'),
        ),
        body: Column(children: <Widget>[]));
  }
}
