import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/pages/thread/gallery.dart';
import 'package:uitest/utils/utils.dart';
/// auth:wyj
/// desc:九宫图-圆角
/// date:20190429
class NineMap extends StatelessWidget {
  dynamic threadInfo;
  @override
  NineMap({Key key,this.threadInfo}):super(key:key);

  @override
  Widget build(BuildContext context) {
     var num = threadInfo.picList.length;
    if (num == 0) return Container();
    int yu = num % 3; //取余
    int zhen = num ~/ 3; //取整
    var row = yu == 0 ? zhen : zhen + 1; //行数
    var picWidth = 210.0;
    var picHeight = 210.0;
    var listRows = new List<Widget>();
    for (var i = 0; i < row; i++) {
      var listPics = new List<Widget>();
      for (var j = 0; j < 3; j++) {
        var picIndex = i * 3 + j;
        if (picIndex < num) {
          var img = threadInfo.picList[(picIndex)].toString();
          if(!img.contains('-thumb.'))
            img=img.replaceAll('.jpg', '-thumb.jpg').replaceAll('.png', '-thumb.png');
          listPics.add(
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                  return GalleryPage(galleryList:threadInfo.picList,initialIndex: picIndex,);
                }));
              },
              child: 
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(img,
                      width: Utils.getPXSize(context, picWidth),
                      height: Utils.getPXSize(context, picHeight)))))
          );
        } else {
          //不够的补空
          listPics.add(Container());
        }
      }
      listRows.add(Row(children: listPics));
    }
    return Column(children: listRows);
  }
}