import 'package:uitest/config/constants.dart';
import 'package:uitest/config/localStorage.dart';
import 'package:uitest/dao/DataResult.dart';
import 'package:uitest/net/api.dart';

/// auth:wyj
/// desc:财务dao
/// date:20190524
class FinanceDao {
  static list({int page}) async {
    var token=await LocalStorage.getUserToken();
    var params = {
      "pageRequest": {
        "LastId": 0,
        "PageSize": Constants.PAGE_SIZE,
        "Sort": "",
        "KeyWord": "",
        "PageIndex": page
      },
      "userRequest": {
        "Token": token,
        "Plat": Constants.PLATID,
        "TimeStamp": 0,
        "Sign": ""
      }
    };
    var res = await HttpManager.netPost(
        HttpManager.API_FINANCE_LIST, params, null, null);
    //print(params);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }
}
