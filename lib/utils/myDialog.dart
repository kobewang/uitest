import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/loadingDialog.dart';

/// Dialog弹窗toast
///
/// auth:wyj date:20190222
class  MyDialog {
  static showToast(String msg,{String gravity:'center'}) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: gravity=="center"?
      ToastGravity.CENTER
      :(gravity=="bottom")?ToastGravity.BOTTOM:ToastGravity.TOP
    );
  }

  //加载中
  static showLoading(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (_){
        return LoadingDialog(text: msg);
      }
    );
  }

  static showAlert(
    BuildContext context,
    String msg, {
    Widget child,
    double childHeight,
    String okLabel: "确定",
    VoidCallback ok,
    String cancelLabel,
    VoidCallback cancel,
    bool barrierDismissible: true,
  }) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (_) {
          if (child == null && msg != null && msg != "") {
            child = Text(
              msg,
              style: TextStyle(
                fontSize: Utils.getPXSize(context, 30.0),
                color: Color.fromRGBO(105, 105, 105, 1.0),
              ),
              maxLines: 20,
            );
            childHeight =
                40.0 * (msg.length / 15 + (msg.length % 15 == 0 ? 0 : 1));
          }

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(30),
              height: 30 +
                  childHeight +
                  30 +
                  Utils.getPXSize(context, 90) +
                  10 +
                  (cancelLabel != null || cancel != null
                      ? Utils.getPXSize(context, 90) + 10
                      : 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: child,
                  ),
                  //确定按钮
                  okLabel != null && okLabel != ""
                      ? Container(
                          height: Utils.getPXSize(context, 90.0),
                          width: Utils.getPXSize(context, 360.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (ok != null) {
                                  ok();
                                }
                              },
                              child: Text(
                                okLabel,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Utils.getPXSize(context, 32.0),
                                ),
                              )),
                        )
                      : Container(),
                  //取消按钮
                  cancelLabel != null || cancel != null
                      ? Container(
                          margin: EdgeInsets.only(top: 10),
                          height: Utils.getPXSize(context, 90.0),
                          width: Utils.getPXSize(context, 400.0),
                          child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (cancel != null) {
                                  cancel();
                                }
                              },
                              child: Text(
                                cancelLabel ?? "取消",
                                style: TextStyle(
                                  fontSize: Utils.getPXSize(context, 28.0),
                                  color: Color.fromRGBO(137, 137, 137, 1.0),
                                ),
                              )),
                        )
                      : Container()
                ],
              ),
            ),
          );
        });
  }

}