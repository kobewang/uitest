import 'package:redux/redux.dart';
import 'package:uitest/config/constants.dart';
import 'package:uitest/config/localStorage.dart';
import 'package:uitest/model/userInfo.dart';
import 'package:uitest/net/api.dart';
import 'package:uitest/redux/actions/userinfoAction.dart';
import 'package:uitest/redux/models/appstate.dart';
import 'DataResult.dart';

/// 用户Dao
///
/// auth:wyj date:20190308
class UserDao {
  //微信Oauth登录
  static wxOauth(String code, token) async {
    var params = {
      "userRequest": {
        "Token": token,
        "Plat": Constants.PLATID,
        "TimeStamp": 0,
        "Sign": ""
      },
      "Code": code
    };
    var res = await HttpManager.netPost(
        HttpManager.API_USER_WX_LOGIN, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      if (res.data['Code'] == 0) {
        var token = res.data['Data'].toString();
      }
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  ///查询手机号是否已注册
  static mobileExist(String mobile) async {
    var params = {
      "userRequest": {
        "Token": "",
        "Plat": Constants.PLATID,
        "TimeStamp": 0,
        "Sign": ""
      },
      "MobileNum": mobile
    };
    var res = await HttpManager.netPost(
        HttpManager.API_USER_MOBILE_EXIST, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  ///获取验证码
  static getMobileCode(String mobile) async {
    var params = {
      "userRequest": {
        "Token": 'appreg',
        "Plat": Constants.PLATID,
        "TimeStamp": 0,
        "Sign": ""
      },
      "MobileNum": mobile
    };
    var res = await HttpManager.netPost(
        HttpManager.API_USER_GET_VCODE, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  //手机绑定验证
  static mobileBind(String mobile, String vcode, int mCode) async {
    var params = {
      "userRequest": {
        "Token": 'appreg',
        "Plat": Constants.PLATID,
        "TimeStamp": 0,
        "Sign": ""
      },
      "MobileNum": mobile,
      "Vcode": vcode,
      "Mcode": mCode
    };
    var res = await HttpManager.netPost(
        HttpManager.API_USER_BIND_MOBILE, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  static getUserInfo(String token) async {
    UserInfo userInfo;
    var params = {
      "Token": token,
      "Plat": Constants.PLATID,
      "TimeStamp": 0,
      "Sign": ""
    };
    var res = await HttpManager.netPost(
        HttpManager.API_USER_GET_INFO, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      userInfo=UserInfo.fromJson(data['Data']);
      return userInfo;
    }
    return userInfo;
  }
  ///更新用户信息
  static refreshUserInfo(Store<AppState> store,String token) async {
    await LocalStorage.setUserToken(token);
    var userInfo= await getUserInfo(token);
    if(store!=null) {
      store.dispatch(UserInfoAction(userInfo:userInfo));
    }
    //发送极光注册ID
  }
}
