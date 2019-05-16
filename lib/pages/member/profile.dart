import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
/// auth:wyj
/// desc:个人设置
/// date:20190514
class ProfilePage extends StatefulWidget {
  @override
  createState() => ProfilePageState();
}
class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Title(title:'个人设置中心');
  }
}
