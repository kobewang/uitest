import 'dart:convert';

import 'package:uitest/dao/DataResult.dart';
import 'package:uitest/model/groupInfo.dart';
import 'package:uitest/model/typeInfo.dart';
import 'package:uitest/net/api.dart';

class TypesDao {
  static Detail(int typeId) async {
    var params = {
      "Type": typeId
    };
    var res = await HttpManager.netFetch(HttpManager.API_TYPE_DETAIL, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      TypeInfo typeInfo = TypeInfo.fromJson(data['Data']);
      var resGroup = await GroupList(typeId);
      typeInfo.groupList = resGroup.data;
      return new DataResult(typeInfo, true);
    }
    return new DataResult(null,false);
  }

  static GroupList(int typeId) async {
    var params = {
      "Type": typeId,
      "Key": ''
    };
    var res = await HttpManager.netFetch(HttpManager.API_GROUP_LIST, params, null, null);
    List<GroupInfo> groupList = new List<GroupInfo>();
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      for(var i=0 ; i<data['Data']['List'].length; i++) {
        GroupInfo groupInfo = GroupInfo.fromJson(data['Data']['List'][i]);
        groupList.add(groupInfo);
      }
    }
    return new DataResult(groupList, true);
  }
}