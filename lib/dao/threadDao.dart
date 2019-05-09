import 'package:uitest/config/constants.dart';
import 'package:uitest/dao/DataResult.dart';
import 'package:uitest/model/reportInfo.dart';
import 'package:uitest/model/threadInfo.dart';
import 'package:uitest/net/api.dart';

/// 帖子Dao
///
/// auth:wyj date:20190326
class ThreadDao {
  static String token = 'abctoken123';

  /// 菜单
  static menuList() async {
    var res =
        await HttpManager.netPost(HttpManager.API_MENU_LIST, {}, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  /// 类型列表
  static typeList() async {
    var res =
        await HttpManager.netPost(HttpManager.API_TYPE_LIST, {}, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }
  //帖子列表
  static list({int page = 1}) async {
    var params = {
      "pageRequest": {
        "LastId": 0,
        "PageSize": Constants.PAGE_SIZE,
        "Sort": "",
        "KeyWord": "",
        "PageIndex": page
      },
      "userRequest": {"Token": "", "Plat": 0, "TimeStamp": 0, "Sign": ""},
      "tdListRequest": {
        "Type": 0,
        "Area": 0,
        "Key": "",
        "IsRed": 0,
        "UserId": 0,
        "CardId": 0
      }
    };
    var res = await HttpManager.netPost(
        HttpManager.API_THREAD_LIST, params, null, null);
    //print(params);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  /// 帖子详情
  static Future<ThreadInfo> detail(int threadId) async {
    ThreadInfo tdInfo;
    var params = {"Token": "", "Plat": 0, "TimeStamp": 0, "Sign": ""};
    print(HttpManager.API_THREAD_DETAIL + '?Id=' + threadId.toString());
    var res = await HttpManager.netPost(
        HttpManager.API_THREAD_DETAIL + '?Id=' + threadId.toString(),
        params,
        null,
        null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      tdInfo = ThreadInfo.fromJson(data['Data']);
      return tdInfo;
    }
    return tdInfo;
  }

  /// 发布评论
  static addComment(int threadId, String comment) async {
    var params = {
      "userRequest": {
        "Token": token,
        "Plat": Constants.PLATID,
        "TimeStamp": 0,
        "Sign": ""
      },
      "cmtAddRequest": {
        "Tid": threadId,
        "RepPid": 0,
        "ReplyUid": 0,
        "Content": comment,
        "FormId": "",
        "Star": 0,
        "Type": 0
      }
    };
    var res = await HttpManager.netPost(
        HttpManager.API_COMMENT_ADD, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  /// 评论列表
  static listComment(int threadId) async {
    var params = {
      "LastId": 0,
      "PageSize": Constants.PAGE_SIZE,
      "Sort": "",
      "KeyWord": "",
      "PageIndex": 1
    };
    print(HttpManager.API_COMMENT_LIST + '?tid=' + threadId.toString());
    print(params);
    var res = await HttpManager.netPost(
        HttpManager.API_COMMENT_LIST + '?tid=' + threadId.toString(),
        params,
        null,
        null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  ///点赞
  static like(int threadId, bool isLike) async {
    var params = {
      "userRequest": {
        "Token": token,
        "Plat": Constants.PLATID,
        "TimeStamp": 0,
        "Sign": ""
      },
      "Tid": threadId,
      "Act": isLike ? 1 : 0,
      "FormId": "",
      "Plat": 0
    };
    var res = await HttpManager.netPost(
        HttpManager.API_THREAD_LIKE, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }

  ///举报
  static report(ReportInfo reportInfo) async {
    var params = {
      "userRequest": {
        "Token": token,
        "Plat": Constants.PLATID,
        "TimeStamp": 0,
        "Sign": ""
      },
      "jubaoInfo": {
        "LinkId": reportInfo.linkId,
        "Mobile": reportInfo.mobile,
        "Tag": reportInfo.tag,
        "Content": reportInfo.content,
        "FormId": ""
      }
    };
    var res = await HttpManager.netPost(
        HttpManager.API_THREAD_REPORT, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }
}
