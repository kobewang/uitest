import 'package:flutter/material.dart';
import 'package:uitest/model/tmsearchInfo.dart';

class DetailPage extends StatefulWidget {
  int id;
  DetailPage({Key key, this.id}) : super(key: key);
  @override
  createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('app')),
        body: Center(child: Text(widget.id.toString())));
  }
}
