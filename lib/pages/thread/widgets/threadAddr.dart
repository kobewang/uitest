import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/utils/utils.dart';
/// auth:wyj
/// desc:帖子地址
/// date:20190430
class ThreadAddr extends StatelessWidget {
  String address;
  @override
  ThreadAddr({Key key,this.address}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Color(0xFF919191),
                  size: 20,
                ),
                Expanded(
                    child: Text(address ?? '',
                        style: TextStyle(
                            color: Color(0xFF919191),
                            fontSize: Utils.getPXSize(context, 24))))
              ],
            );
  }
}
