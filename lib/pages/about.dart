import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uitest/config/constants.dart';
import 'package:uitest/dao/commonDao.dart';
import 'package:uitest/pages/layout/titleLayout.dart';
import 'package:uitest/utils/myDialog.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/listItem.dart';
import 'package:url_launcher/url_launcher.dart';

/// auth:wyj
/// desc:关于
/// date:2019-05-14
class AboutPage extends StatefulWidget {
  @override
  createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  Future<void> onRefresh() async {
    if (Platform.isIOS) return;
    var res = await CommonDao.appVersion();
    if (res != null) {
      var curCode = int.parse(res.data['Data']['Android']['Vcode']);
      if (curCode > Constants.APP_VERSION_ANDROID_CODE) {
        MyDialog.showAlert(
          context,
          '',
          ok: () {
            launch(res.data['Data']['Android']['DownUrl']);
          },
          okLabel: '立即下载更新',
          cancel: () {},
          cancelLabel: '暂不更新',
          barrierDismissible: false,
        );
      } else {
        MyDialog.showToast('当前已是最新版本');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TitleLayout(
        title: '关于我们',
        body: RefreshIndicator(
            onRefresh: onRefresh,
            child: Container(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                listLogo(),
                ListItemPublic.listItemBlock(),
                listItem('客服电话', Constants.COMPANY_PHONE),
                listDivider(Constants.COMPANY_PHONE.isEmpty),
                listItem('客服微信', Constants.COMPANY_WECHAT),
                listDivider(Constants.COMPANY_WECHAT.isEmpty),
                listItem('客服QQ', Constants.COMPANY_QQ),
                listDivider(Constants.COMPANY_QQ.isEmpty),
                listItem(
                    '版本号',
                    Platform.isIOS
                        ? Constants.APP_VERSION_IOS
                        : Constants.APP_VERSION_ANDROID),
                Expanded(child: listCopyRight())
              ],
            ))));
  }

  //ui-logo
  listLogo() {
    return Container(
      height: Utils.getPXSize(context, 400),
      color: Colors.white,
      padding: EdgeInsets.only(top: Utils.getPXSize(context, 80)),
      child: Center(
          child: Column(
        children: <Widget>[
          Image.network(Constants.APP_LOGO),
          Container(margin: EdgeInsets.only(top: 20), child: Text(Constants.COMPANY_NAME))
        ],
      )),
    );
  }

  //ui-item
  listItem(String title, String value) {
    if (value.isEmpty)
      return Container();
    else {
      var widget = Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: Utils.getPXSize(context, 100),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title,
                style: TextStyle(
                  fontSize: Utils.getPXSize(context, 30),
                  color: Color(0xff333333),
                )),
            Row(children: <Widget>[
              Text(value,
                  style: TextStyle(
                    fontSize: Utils.getPXSize(context, 30),
                    color: Color(0xff999999),
                  )),
              Icon(
                Icons.chevron_right,
                color: Color(0xff999999),
              )
            ])
          ]));
      return InkWell(
          onTap: () {
            if (title == '版本号') {
              onRefresh();
            } else {
              Clipboard.setData(new ClipboardData(text: value));
              MyDialog.showToast('已复制到剪贴板');
            }
          },
          child: widget);
    }
  }

  //ui-间隔
  listDivider(bool isHide) {
    if (isHide) return Container();
    return Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: ListItemPublic.listItemDivider(Color(0xff999999)));
  }

  //ui-版权
  listCopyRight() {
    if (Constants.COMPANY_NAME.isEmpty) return Container();
    return Container(
      margin: EdgeInsets.only(
        bottom: Utils.getPXSize(context, 20),
      ),
      child: Center(
        child: Text(
          "© ${Constants.COMPANY_NAME}",
          style: TextStyle(
            fontSize: Utils.getPXSize(context, 20),
            color: Color(0xffb2b2b2),
          ),
        ),
      ),
    );
  }
}
