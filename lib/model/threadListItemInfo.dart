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
  int comments;
  int shares;
  String addtime;
  List<String> picList;
  ThreadListItemInfo({this.id,this.userId,this.head,this.name,this.type,this.fType,this.area,this.mobile,this.content,this.views,this.likes,this.comments,this.shares,this.addtime,this.picList});
  factory ThreadListItemInfo.fromJson(Map<String,dynamic> json) {
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
      comments: json['Comments'],
      shares: json['Shares'],
      addtime: json['Addtime'],
      picList: (json['PicList'] as List).map((item){
        return item.toString();
      }).toList()
    );
  }
}
