import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  static String FormateType(int typeId) {
    if (typeId < 10)
      return '0' + typeId.toString();
    else
      return typeId.toString();
  }

  static double _designWidth = 750.0;

  /// 跳转webview
  static gotoWebView(String title,String url) {

  }

  /// 获取px等比大小
  static double getPXSize(BuildContext context, double size) {
    return size * (MediaQuery.of(context).size.width / _designWidth);
  }

  ///文件选择，type默认为空，picture选择系统文件夹，camera选择相机
  static Future<File> selectImage(BuildContext context,
      {String type = ""}) async {
    if (type != null && type != "") {
      if (type == "picture") {
        return await ImagePicker.pickImage(source: ImageSource.gallery);
      } else if (type == "camera") {
        return await ImagePicker.pickImage(source: ImageSource.camera);
      }
    }
    //弹窗选择
    File image;
    await showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("系统相册"),
                  onTap: () async {
                    image = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  height: 1,
                  color: Color(0xffececec),
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text("照相机"),
                  onTap: () async {
                    image =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
    return image;
  }
}
