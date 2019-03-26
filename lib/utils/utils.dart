import 'package:flutter/material.dart';

class Utils{
  static String FormateType(int typeId) {
    if(typeId<10)
      return '0'+typeId.toString();
    else 
      return typeId.toString();     
  }
   static double _designWidth = 750.0;
  /// 获取px等比大小
  static double getPXSize(BuildContext context,double size) {
    return size * (MediaQuery.of(context).size.width/_designWidth);
  }
}