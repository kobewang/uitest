import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class  GoodsInfo {
  String id;
  String typeId;
  String typeName;
  GoodsInfo({this.id,this.typeId,this.typeName});
  factory GoodsInfo.fromJson(Map<String, dynamic> json) {
    return GoodsInfo(
      id: json['Id'],
      typeId: json['TypeId'],
      typeName: json['TypeName']
    );
  }
  
}