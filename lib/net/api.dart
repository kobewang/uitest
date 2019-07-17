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
  static final String API_GROUP_DETAIL = API_HOST+"/tm/group/detail";
  static final String API_GROUP_LIST = API_HOST+"/tm/group/list";
  static final String API_GOODS_LIST = API_HOST+"/tm/goods/list";
  static final String API_GOODS_SEARCH = API_HOST+"/tm/goods/search";
  //static final String API_TM_REG = API_HOST+"/tm/reg";
  static final String API_TM_REG = API_HOST+"/xcxpic/uploadtmreg";
  static final String API_APP_VERSION = API_HOST+"/public/appversion";
  ///帖子相关
  static final String API_MENU_LIST = API_HOST+"/public/menu";
  static final String API_TYPE_LIST = API_HOST+"/thread/type";
  static final String API_IMG_UPLOAD = API_HOST+"/xcxpic/upload";
  static final String API_THREAD_ADD = API_HOST+"/thread/add";
  static final String API_THREAD_FINISH = API_HOST+"/thread/finish";
  static final String API_THREAD_LIST = API_HOST+"/thread/list";
  static final String API_THREAD_MY_LIST = API_HOST+"/thread/my";
  static final String API_THREAD_DETAIL= API_HOST+"/thread/detail";
  static final String API_THREAD_LIKE= API_HOST+"/thread/like2";
  static final String API_THREAD_REPORT= API_HOST+"/thread/jubao";
  static final String API_COMMENT_ADD = API_HOST+"/thread/comments/add2";
  static final String API_COMMENT_LIST = API_HOST+"/thread/comments/list";
  ///财务相关
  static final String API_FINANCE_LIST= API_HOST+"/finance/list";
  ///用户相关
  static final String API_USER_WX_LOGIN =API_HOST+'/user/wx/login';
  static final String API_USER_MOBILE_EXIST =API_HOST+'/user/mobile/exist';
  static final String API_USER_GET_VCODE = API_HOST+'/user/getmcode';
  static final String API_USER_BIND_MOBILE = API_HOST + '/user/mobilebind';
  static final String API_USER_GET_INFO = API_HOST + '/user/info';
  ///名片相关
  static final String API_COMPANY_LIST= API_HOST+'/card/list'; 


  static netPost(url,params,Map<String,String> header, Options option,{noTip = false}) async {
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
    option.connectTimeout = 15000;
    Dio dio = new Dio();
    Response response;
    print(url);
    print(params);
    try {
      response = await dio.post(url, data:params, options:option);
    } on DioError catch (e) {
      print('DioError:${e.response}');
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
      print('response.data:${response.data}');
        return new ResultData(response.data, true, Code.SUCCESS,headers: response.headers);
    } catch (e) {
      return new ResultData(response.data, false, response.statusCode,headers:response.headers);
    }
  }

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