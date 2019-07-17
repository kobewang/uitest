import 'package:uitest/config/constants.dart';
import 'package:uitest/dao/DataResult.dart';
import 'package:uitest/net/api.dart';

class CompanyDao {
  //帖子列表
  static list({int page = 1,String type='',String area='',String job='',String key='',int sort=0}) async {
    var params = {
      "pageIndex": page,
      "pageListRequest": {
        "LastId": 0,
        "PageSize": Constants.PAGE_SIZE,
        "Sort": "",
        "KeyWord": "",
        "PageIndex": page
      },
      "listRequest": {
        "Type": type,
        "Area": area,
        "Job": job,
        "Key": key,
        "Sort": sort,
        "Longitude": 0,
        "Latitude": 0
      }
    };
    var res = await HttpManager.netPost(
        HttpManager.API_COMPANY_LIST, params, null, null);
    print(params);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null, false);
  }
}
