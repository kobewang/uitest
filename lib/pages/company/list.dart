import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// auth:wyj
/// desc:公司列表
/// date:20190531

class CompanyListPage extends StatefulWidget {
  @override
  createState() => CompanyListPageState();
}

class CompanyListPageState extends State<CompanyListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
      ),
      body: Center(
        child: Text('公司列表'),
      ),
    );
  }
}
