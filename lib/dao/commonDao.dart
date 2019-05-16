import 'package:uitest/config/constants.dart';
import 'package:uitest/dao/DataResult.dart';
import 'package:uitest/net/api.dart';

/// auth:wyj
/// desc:通用模块
/// date:2019-05-15
class CommonDao {
  /// 版本
  static appVersion() async {
    var res = await HttpManager.netPost(
        HttpManager.API_APP_VERSION, {'Plat': Constants.PLATID}, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }
}
