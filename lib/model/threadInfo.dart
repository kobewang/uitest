/// auth:wyj
/// desc:帖子详情Model
/// date:20190426

class ThreadInfo {
  int id;
  int userId;
  String head;
  String name;
  String type;
  String fType;
  List<String> label;
  String area;
  String mobile;
  String content;
  String addtime;
  List<String> picList;
  int likes;
  int isLike;
  int isFollow;
  int comments;
  int shares;
  int views;
  List<String> viewList;
  String address;
  int isVip;
  int isRed;
  String auditStatus;
  ThreadInfo(
      {this.id,
      this.userId,
      this.head,
      this.name,
      this.type,
      this.fType,
      this.label,
      this.area,
      this.mobile,
      this.content,
      this.addtime,
      this.picList,
      this.likes,
      this.isLike,
      this.isFollow,
      this.comments,
      this.shares,
      this.views,
      this.viewList,
      this.address,
      this.isVip,
      this.isRed,
      this.auditStatus});
  factory ThreadInfo.fromJson(Map<String, dynamic> json) {
    return ThreadInfo(
        id: json['Id'],
        userId: json['UserId'],
        head: json['Head'],
        name: json['Name'],
        type: json['Type'],
        fType: json['Ftype'],
        label: json['Label']==null?[]: (json['Label'] as List).map((item) {
          return item.toString();
        }).toList(),
        area: json['Area'],
        mobile: json['Mobile'],
        content: json['Content'],
        addtime: json['Addtime'],
        picList: json['PicList']==null?[]:(json['PicList'] as List).map((item) {
          return item.toString();
        }).toList(),
        likes: json['Likes'],
        isLike: json['IsLike'],
        isFollow: json['IsFollow'],
        comments: json['Comments'],
        shares: json['Shares'],
        views: json['Views'],
        viewList: json['ViewList'] ==null?[]: (json['ViewList'] as List).map((item){
          return item.toString();
        }).toList(),
        address: json['Address'],
        isVip: json['IsVIP'],
        isRed: json['IsRed'],
        auditStatus: null
        );
  }
}
