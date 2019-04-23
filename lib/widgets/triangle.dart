import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
/// 画三角形
///
///
class Triangle extends StatelessWidget{
  Color myColor;
  double width;
  int orientation;//朝向 1 正三角 0 倒三角
  Triangle({Key key,this.width=7.0,this.myColor,this.orientation}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return new ClipPath(
      clipper: new _TriangleCliper(orientation:orientation),
      child: new SizedBox(
        width: width,
        height: width,
        child: Container(color: myColor),
      ),
    );
  }
}

class   _TriangleCliper extends CustomClipper<Path>{
  int orientation;//朝向 1 正三角 0 倒三角
  _TriangleCliper({Key key,this.orientation});
  @override
  Path getClip(Size size) {
    print('orientaion:${orientation}');
    Path path = new Path();
    if(orientation==1){
      path.moveTo(0, size.height);//按坐标画，从起点到终点
      path.lineTo(size.width/2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    else{
      //倒三角
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width/2, size.height);
      path.lineTo(0, 0);
    }
    path.close();//构成封闭多边形
    return path;
  }
  @override
  bool shouldReclip(_TriangleCliper oldClipper) {
    return false;
  }
}