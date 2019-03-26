import 'package:uitest/dao/DataResult.dart';
import 'package:uitest/net/api.dart';

/// 帖子Dao
///
/// auth:wyj date:20190326
class  ThreadDao {
  static list({int page=1}) async{
  var params ={};
    var res = await HttpManager.netPost(HttpManager.API_TM_REG, params, null, null);
    print(params);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null,false);
  }
}