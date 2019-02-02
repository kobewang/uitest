import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:uitest/net/code.dart';
import 'package:uitest/net/resultData.dart';
///http网络请求处理
class  HttpManager {
  ///Host地址
  static final String API_HOST = "https://api.yms.cn";
  ///分类详细
  static final String API_TYPE_DETAIL = API_HOST+"/tm/type/detail";
  static final String API_GROUP_LIST = API_HOST+"/tm/group/list";
  static netFetch(url,params,Map<String,String> header, Options option,{noTip = false}) async {
    Map<String,String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "post");
      option.headers =  headers;
    }
    ///超时
    option.connectTimeout = 15000;
    Dio dio = new Dio();
    Response response;
    try {
      response = await dio.request(url, data:params, options:option);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = 0;
      }
      return new ResultData(Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),false,errorResponse.statusCode);
    }
    try {
        return new ResultData(response.data, true, Code.SUCCESS,headers: response.headers);
    } catch (e) {
      return new ResultData(response.data, false, response.statusCode,headers:response.headers);
    }
    return new ResultData(Code.errorHandleFunction(response.statusCode, "", noTip), false, response.statusCode);
  }

}