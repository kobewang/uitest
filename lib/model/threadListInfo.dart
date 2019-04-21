import 'package:uitest/model/threadListItemInfo.dart';

/// auth:wyj
/// desc:帖子列表model
/// date：20190421
class ThreadListInfo {
static getList(data) {
   List<ThreadListItemInfo> list=new List<ThreadListItemInfo>();
   for(var item in data) {
     list.add(ThreadListItemInfo.fromJson(item));
   }
   return list;
 }
}