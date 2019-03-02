import 'dart:io';

import 'package:dio/dio.dart';
import 'package:uitest/dao/DataResult.dart';
import 'package:uitest/model/regtmInfo.dart';
import 'package:uitest/net/api.dart';

class  TmDao  {
  static addRegTm(RegTmInfo info,File imgFile) async {
    var params = FormData.from({
      "TmName": info.tmName,
      "TmType":info.tmType,
      "ReMark":info.reMark,
      "ApplyName":info.applyName,
      "Province":info.province,
      "City":info.city,
      "Area":info.area,
      "Address":info.address,
      "Mobile":info.mobile,
      "filename":new UploadFileInfo(imgFile,"YYZZImg.jpg",contentType: ContentType.parse('image/jpeg')),
      "files":[imgFile,"YYZZImg.jpg"]
    });
    var res = await HttpManager.netPost(HttpManager.API_TM_REG, params, null, null);
    print(params);
    if (res != null && res.result && res.data.length > 0) {
      var data = res.data;
      return new DataResult(data, true);
    }
    return new DataResult(null,false);
  }
  
}