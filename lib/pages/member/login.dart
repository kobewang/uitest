import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uitest/dao/userDao.dart';
import 'package:uitest/pages/member/user.dart';
import 'package:uitest/utils/myDialog.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/CustomButton.dart';
import 'package:uitest/widgets/customInput.dart';
import 'package:uitest/widgets/verificationCodeButton.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:uitest/redux/models/appstate.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

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
  var weChatAuthListen;
  Store<AppState> _initStore;
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    weChatAuthListen = fluwx.responseFromAuth.listen(wechatAuthResponse);
  }
  @override
  void dispose() {
    weChatAuthListen?.cancel();
    super.dispose();
  }
  ///微信登录返回
  void wechatAuthResponse(fluwx.WeChatAuthResponse wechatAuthResponse) async {
    if (wechatAuthResponse?.errCode != 0) {
      MyDialog.showAlert(context, wechatAuthResponse?.errStr ?? "微信登录失败");
      return;
    }
    _getAcessToken(wechatAuthResponse.code);
    /*
    var rep = await UserDao.weixinCallback(wechatAuthResponse.code);
    if (rep == null || rep?.msg != "success") {
      Utils.showMsg(rep?.msg ?? "微信登录失败");
      return;
    }
    //已经绑定的，登录信息
    var token = rep.data["token"]?.toString() ?? "";
    if (rep?.msg == "success" && token != null && token.isNotEmpty) {
      //登录成功
      await _loginSuccess(_initStore, token);

      print(token);
      return;
    }
    var backInfo = WeiXinCallBackInfo.fromJson(rep.data);
    if (backInfo == null) {
      Utils.showMsg("微信登录信息获取失败");
      return;
    }
 */
  }

  ///获取accesstoken
  _getAcessToken(respCode) async {
    var res = await UserDao.wxOauth(respCode, token);
    if (res != null) {
      if (res.data['Code'] == 0) {
        token = res.data['Data'].toString();
      } else {
        MyDialog.showToast('微信登录回调失败');
      }
    }
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
  _submitLogin(Store<AppState> store) async {
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
        } else {
          //直接登录
          await _loginSuccess(store, token);
        }
      }
    }
  }

  ///登录成功
  _loginSuccess(Store<AppState> store, String token) async {
    UserDao.refreshUserInfo(store, token);
    //跳转返回
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).push(new MaterialPageRoute(builder: (_){return UserPage();}));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      onInit: (store) {
        _initStore = store;
      },
      builder: (_, store) {
        return Scaffold(
            appBar:
                AppBar(title: Text('登录'), centerTitle: true, elevation: 1.0),
            body: ListView(
              children: <Widget>[
                Center(
                  child: Container(
                      padding: EdgeInsets.all(Utils.getPXSize(context, 30.0)),
                      margin:
                          EdgeInsets.only(top: Utils.getPXSize(context, 80.0)),
                      width: Utils.getPXSize(context, 680),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1.0)),
                      child:
                          isMobilePanel ? mobilePanel(store) : wechatPanel()),
                ),
              ],
            ));
      },
      converter: (store) => store,
    );
  }

  //ui-短信验证登录
  mobilePanel(Store<AppState> store) {
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
              _submitLogin(store);
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
              Text(token)
            ],
          ),
        ));
  }
}
