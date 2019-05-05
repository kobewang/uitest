import 'package:uitest/config/constants.dart';
import 'package:uitest/dao/DataResult.dart';
import 'package:uitest/model/threadInfo.dart';
import 'package:uitest/net/api.dart';

/// 帖子Dao
///
/// auth:wyj date:20190326
class ThreadDao {
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
}
