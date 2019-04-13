import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// auth:
/// desc:
/// date:
class SettingPage extends StatefulWidget {
	@override
	createState()=> SettingPageState();
}
class SettingPageState extends State<SettingPage> {
	//参数定义
	int _page=1;
	List listData=[];

	@override
	initial() {
    super.initState();
	}

  //接口登录方法
  loginApi() async {

  }
	//登录点击事件
	_loginClickEvent() async {

	}

	@override  //以build为界限，以上：(1)参数（2）方法 (3)事件，事件以_开头；以下：界面UI部分
	build(BuildContext context) {  
		return null;
	}

	//子主键
	listItem() {
	}
}