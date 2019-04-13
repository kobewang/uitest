import 'package:uitest/config/constants.dart';
import 'package:uitest/dao/DataResult.dart';
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
        "PageSize":Constants.PAGE_SIZE,
        "Sort": "",
        "KeyWord": "",
        "PageIndex": page
      },
      "userRequest": {
        "Token": "",
        "Plat": 0,
        "TimeStamp": 0,
        "Sign": ""
      },
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
    print(params);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }
}
