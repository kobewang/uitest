import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uitest/dao/userDao.dart';
import 'package:uitest/utils/myDialog.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/CustomButton.dart';
import 'package:uitest/widgets/customInput.dart';
import 'package:uitest/widgets/verificationCodeButton.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

/// auth:wyj
/// desc:登录页,登录逻辑：先输入手机号，点击获取验证码，去接口请求该手机号是否已经注册，
///     (1)手机号未注册，则发送验证码，验证码成功后，显示使用微信一键登录按钮
///     (2)手机号已注册，则直接显示使用微信一键登录
/// date:20190516
class LoginPage extends StatefulWidget {
  @override
  createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isMobilePanel = true;
  var mid = 0; //短信MID
  var token = '';
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    var respCode = "";
    fluwx.responseFromAuth.listen((response) {
      setState(() {
        respCode = response.code;
        _getAcessToken(respCode);
      });
    });
  }

  ///获取accesstoken
  _getAcessToken(respCode) async {
    var res = await UserDao.wxOauth(respCode,token);
  }

  ///手机号检测
  _mobileCheck() {
    var mobile = _phoneController.text;
    if (mobile == null || mobile == "") {
      MyDialog.showToast("手机号不能为空");
      return false;
    }
    if (!Utils.isMobile(mobile)) {
      MyDialog.showToast("手机输入不正确");
      return false;
    }
  }

  //获取验证码
  Future<bool> _getPhoneCode() async {
    _mobileCheck();
    var mobile = _phoneController.text;
    var res = await UserDao.mobileExist(mobile);
    if (res == null) {
      MyDialog.showToast("网络失败请重试");
      return false;
    }
    if (res.data['Code'] == 0) {
      //手机号已存在，显示微信登录
      setState(() {
        isMobilePanel = false;
      });
      return false;
    }
    //发送登录验证码
    MyDialog.showLoading(context, '加载中');
    res = await UserDao.getMobileCode(mobile);
    if (res != null) {
      Navigator.of(context).pop();
      if (res.data['Code'] != 0) {
        MyDialog.showAlert(context, res.data['Header']['ErrorMessage']);
        return false;
      }
      MyDialog.showToast('已发送到手机');
      mid = res.data['Data']['Mid'];
      return true;
    }
    return false;
  }

  ///微信登录
  _loginWechat() {
    MyDialog.showToast('正在打开微信.');
    fluwx.sendAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test");
  }

  ///提交登录
  _submitLogin() async {
    _mobileCheck();
    var mobile = _phoneController.text;
    String vcode = _codeController.text;
    if (vcode.isEmpty || mid == 0) {
      MyDialog.showToast("请获取验证码");
      return;
    }
    MyDialog.showLoading(context, '提交中.');
    var res = await UserDao.mobileBind(mobile, vcode, mid);
    if (res != null) {
      Navigator.of(context).pop();
      if (res.data['Code'] != 0)
        MyDialog.showAlert(context, res.data['Header']['ErrorMessage']);
      else {
        var directLogin = res.data['Data']['DirectLogin'];
        token = res.data['Data']['Token'];
        if (directLogin == 0) {
          //续要绑定微信
          setState(() {
            isMobilePanel = false;
          });
        }else {
          //直接登录
        }
      }
    }
  }

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
              InkWell(
                  onTap: () {
                    _loginWechat();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 80.0),
                    child: Image.asset('images/login_icon_wechat.png'),
                    width: 120,
                    height: 120,
                  )),
              CustomButton(
                text: "微信一键登录",
                onPressed: () {
                  _loginWechat();
                },
                widthPx: 580,
              ),
            ],
          ),
        ));
  }
}
