/// auth:wyj
/// desc:财务info
/// date:20190524
class FinanceInfo {
  int id;
  String addtime;//时间
  String remark;//备注
  String coin;//类型
  String amount;//数量
  int isAdd;//增加或减少
  FinanceInfo({this.id,this.addtime,this.remark,this.coin,this.amount,this.isAdd});
  factory FinanceInfo.fromJson(Map<String, dynamic> json) {
    return FinanceInfo(
    id:json['Id'],
    addtime:json['Addtime']??'',
    remark:json['Remark']??'',
    coin: json['Coin']??'',
    amount: json['Amount']??'',
    isAdd:json['IsAdd']??0
    );
  }
  static getList(data) {
   List<FinanceInfo> list=new List<FinanceInfo>();
   for(var item in data) {
     list.add(FinanceInfo.fromJson(item));
   }
   return list;
 }
}