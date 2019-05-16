import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// auth:wyj
/// desc:listview-item的公用组件
/// date:20190514

class ListItemPublic {
  static listItemBlock() {
    return Container(
      height: 10,
      color: Color(0xFFececec),
    );
  }
  static listItemDivider(Color dColor) {
    return Divider(height: 1, color:dColor??Colors.grey);
  }
}