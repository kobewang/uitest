import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:uitest/model/userInfo.dart';
import 'package:uitest/pages/layout/titleLayout.dart';
import 'package:uitest/pages/thread/widgets/customlistItem.dart';
import 'package:uitest/redux/models/appstate.dart';
import 'package:uitest/utils/utils.dart';

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
    return StoreConnector<AppState, UserInfo>(
        onInit: (store) {},
        builder: (_, userInfo) {
          return TitleLayout(
            title: '设置',
            body: ListView(children: <Widget>[
              listItem('images/my_set_name.png', '昵称', userInfo?.name ?? '',
                  true, isRightArrow:true,bottomDivider:true),
              listItem('images/my_set_grade.png', '等级', userInfo?.grade ?? '',
                  true, isRightArrow:true,bottomDivider:true),
              listItem('images/my_set_head.png', '头像', userInfo?.headImg ?? '',
                  false, isRightArrow:true,bottomDivider:true),
              listItem('images/my_set_mobile.png', '手机', userInfo?.mobile ?? '',
                  true,  isRightArrow:true,bottomDivider:true),
              //listItem('images/my_set_truecard.png','实名',userInfo?.??'',true,false),
              listItem('images/my_set_city.png', '省市', userInfo?.mobile ?? '',
                  true,  isRightArrow:true,bottomDivider:true),
              listItem('images/my_set_addr.png', '地址', userInfo?.address ?? '',
                  true, isRightArrow:true,bottomDivider:true),
            ]),
          );
        },
        converter: (store) {
          return store.state.userInfo;
        });
  }

  ///list-item
  listItem(
      String imgIcon,
      String title,
      String value,
      bool isTextWiget,
      {
      bool isRightArrow=true,
      bool bottomDivider=true,
      ValueChanged<Store<AppState>> onPressed}) {
    return StoreConnector<AppState, Store<AppState>>(
        builder: (context, store) {
          final fontStyle1 = TextStyle(
              color: Color(0xff555555), fontSize: Utils.getPXSize(context, 30));
          return CustomListItem(
            height: Utils.getPXSize(context, 100),
            icon: Container(
              width: Utils.getPXSize(context, 40),
              child: Image.asset(imgIcon),
            ),
            child: Container(
              margin: EdgeInsets.only(
                left: Utils.getPXSize(context, 30),
                right: Utils.getPXSize(context, 16),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      style: fontStyle1,
                    ),
                  ),
                  value ?? Container()
                ],
              ),
            ),
            endChild: isRightArrow ? Icon(Icons.chevron_right) : null,
            onPressed: onPressed == null
                ? null
                : () {
                    onPressed(store);
                  },
            bottomDivider: bottomDivider,
          );
        },
        converter: (store) => store);
  }
}
