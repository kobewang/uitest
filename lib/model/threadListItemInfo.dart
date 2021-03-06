/// auth:wyj
/// desc:帖子列表详情model
/// date:20190421
class ThreadListItemInfo {
  int id;
  int userId;
  String head;
  String name;
  String type;
  String fType;
  String area;
  String mobile;
  String content;
  int views;
  int likes;
  int isLike;
  int comments;
  int shares;
  String addtime;
  List<String> picList;
  String address;
  int isVip;
  int isRed;
  String auditStatus;
  ThreadListItemInfo(
      {this.id,
      this.userId,
      this.head,
      this.name,
      this.type,
      this.fType,
      this.area,
      this.mobile,
      this.content,
      this.views,
      this.likes,
      this.isLike,
      this.comments,
      this.shares,
      this.addtime,
      this.picList,
      this.address,
      this.isVip,
      this.isRed,
      this.auditStatus});
  factory ThreadListItemInfo.fromJson(Map<String, dynamic> json) {
    return ThreadListItemInfo(
        id: json['Id'],
        userId: json['UserId'],
        head: json['Head'],
        name: json['Name'],
        type: json['Type'],
        fType: json['Ftype'],
        area: json['Area'],
        mobile: json['Mobile'],
        content: json['Content'],
        views: json['Views'],
        likes: json['Likes'],
        isLike: json['IsLike'],
        comments: json['Comments'],
        shares: json['Shares'],
        addtime: json['Addtime'],
        picList: json['PicList'] == null
            ? []
            : (json['PicList'] as List).map((item) {
                return item.toString();
              }).toList(),
        address: json['Address'],
        isVip: json['IsVIP'],
        isRed: json['IsRed'],
        auditStatus:json['AuditStatus']??'');
  }
}
