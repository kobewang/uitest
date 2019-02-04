import 'dart:convert';

import 'package:uitest/dao/DataResult.dart';
import 'package:uitest/model/goodsInfo.dart';
import 'package:uitest/model/groupInfo.dart';
import 'package:uitest/model/typeInfo.dart';
import 'package:uitest/net/api.dart';

class TypesDao {
  static detail(int typeId) async {
    var params = {
      "Type": typeId
    };
    var res = await HttpManager.netFetch(HttpManager.API_TYPE_DETAIL, params, null, null);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      TypeInfo typeInfo = TypeInfo.fromJson(data['Data']);
      var resGroup = await groupList(typeId);
      typeInfo.groupList = resGroup.data;
      return new DataResult(typeInfo, true);
    }
    return new DataResult(null,false);
  }

  static groupList(int typeId) async {
    var params = {
      "Type": typeId,
      "Key": ''
    };
    var res = await HttpManager.netFetch(HttpManager.API_GROUP_LIST, params, null, null);
    List<GroupInfo> groupList = new List<GroupInfo>();
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      print('res.data:${res.data}');
      for(var i=0 ; i<data['Data']['List'].length; i++) {
        GroupInfo groupInfo = GroupInfo.fromJson(data['Data']['List'][i]);
        groupList.add(groupInfo);
      }
    }
    return new DataResult(groupList, true);
  }

  static goodsList(String groupId) async {
     print('groupId:${groupId}');
    var params = {
      "GroupId": groupId,
      "Key": ''
    };
     var res = await HttpManager.netFetch(HttpManager.API_GOODS_LIST, params, null, null);
    List<GoodsInfo> goodsList = new List<GoodsInfo>();
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      for(var i=0 ; i<data['Data']['List'].length; i++) {
        GoodsInfo goodsInfo = GoodsInfo.fromJson(data['Data']['List'][i]);
        goodsList.add(goodsInfo);
      }
    }
    return new DataResult(goodsList, true);
  }
}