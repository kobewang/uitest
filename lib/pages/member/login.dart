import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uitest/utils/myDialog.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/CustomButton.dart';
import 'package:uitest/widgets/customInput.dart';
import 'package:uitest/widgets/verificationCodeButton.dart';

/// auth:wyj
/// desc:登录页
/// date:20190516
class LoginPage extends StatefulWidget {
  @override
  createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isMobilePanel = true;
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();
  //获取验证码
  Future<bool> _getPhoneCode() async {
    var mobile = _phoneController.text;
    if (mobile == null || mobile == "") {
      MyDialog.showToast("手机号不能为空");
      return false;
    }
    setState(() {
      isMobilePanel = false;
    });
    return false;
    //判断是否绑定微信，未绑定：获取验证码然后绑定微信登录
    //已绑定微信：直接授权微信登录

    /*
    try {
      var sendResponse = await DomainPlusApi.sendLoginSmsVeryCode(mobile);
      Navigator.of(context).pop();
      if (sendResponse == null) {
        Utils.showMsg("验证码获取失败");
        return false;
      }
      if (sendResponse.success()) {
        isSendCode = true;
        return true;
      }
      if (sendResponse.code == "100011") {
        //激活弹窗
        Utils.showAlert(
          context,
          null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "您是否为名优金融用户？",
                style: TextStyle(
                  color: Color(0xff555555),
                  fontSize: Utils.getPXSize(context, 30),
                ),
              ),
              Text(
                "名优金融用户可免注册直接激活账户后使用",
                style: TextStyle(
                  color: Color(0xff555555),
                  fontSize: Utils.getPXSize(context, 30),
                ),
              ),
            ],
          ),
          childHeight: Utils.getPXSize(context, 200),
          okLabel: "是，去激活",
          ok: () {
            Navigator.of(context).pushNamed("/login/activate");
          },
          cancelLabel: "否",
        );
        return false;
      }
      Utils.showMsg(sendResponse.msg ?? "验证码获取失败");
    } catch (e) {
      Navigator.of(context).pop();
      Utils.showMsg("验证码获取失败");
    }
    return false;
    */
  }

  ///提交登录
  _submitLogin() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('登录'), centerTitle: true, elevation: 1.0),
        body: ListView(
          children: <Widget>[
            Center(
              child: Container(
                  padding: EdgeInsets.all(Utils.getPXSize(context, 30.0)),
                  margin: EdgeInsets.only(top: Utils.getPXSize(context, 80.0)),
                  width: Utils.getPXSize(context, 680),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1.0)),
                  child: isMobilePanel ? mobilePanel() : wechatPanel()),
            ),
          ],
        ));
  }

  //ui-短信验证登录
  mobilePanel() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: Utils.getPXSize(context, 30.0),
            right: Utils.getPXSize(context, 30.0),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: Utils.getPXSize(context, 20.0)),
          child: Column(
            children: <Widget>[
              CustomInput(
                controller: _phoneController,
                iconPath: "images/ic_mobile.png",
                iconSize: 20.0,
                iconColor: Theme.of(context).primaryColor,
                placeholder: "请输入手机号",
                keyboardType: TextInputType.number,
              ),
              CustomInput(
                controller: _codeController,
                iconPath: "images/ic_vcode.png",
                iconSize: 20.0,
                iconColor: Theme.of(context).primaryColor,
                placeholder: "请输入验证码",
                keyboardType: TextInputType.number,
                rightChild: VerifcationCodeButton(
                  text: "获取验证码",
                  onPressed: _getPhoneCode,
                  countdownSecond: 60,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: Utils.getPXSize(context, 50.0),
          ),
          child: CustomButton(
            text: "登录",
            onPressed: () {
              _submitLogin();
            },
            widthPx: 580,
          ),
        ),
      ],
    );
  }

  //ui-微信绑定登录
  wechatPanel() {
    return Container(
        height: 300,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:80.0),
                child:
              Image.asset('images/login_icon_wechat.png'),width: 120,height: 120,),
              Text('点击微信一键登录',
                  style: TextStyle(
                    color: Color.fromRGBO(153, 153, 153, 1.0),
                    fontSize: Utils.getPXSize(context, 30.0),
                    height: 1.5,
                  ))
            ],
          ),
        ));
  }
}
