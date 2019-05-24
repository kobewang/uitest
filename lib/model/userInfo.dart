/// auth:wyj
/// desc:用户Model
/// date:20190520
class UserInfo {
  int id;
  //头像
  String headImg;
  //昵称
  String name;
  //余额
  double balance;
  //积分
  double coin;
  //信用
  int credit;
  //发帖总数
  int threadNum;
  //点赞数
  int likes;
  //等级
  String grade;
  //签到总数
  int checkTotal;
  //连续签到数
  int checkContinue;
  String mobile;
  int isMobile;
  //未读消息数
  int unReadMsg;
  //省份
  String province;
  //城市
  String city;
  //地址
  String address;
  UserInfo.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        headImg = json['HeadImg'],
        name = json['Name'],
        balance = json['Balance'],
        coin = json['Coin'],
        credit = json['Credit'],
        threadNum =json['ThreadNum'] ?? 0,
        likes = json['Likes'] ?? 0,
        grade = json['Grade'],
        checkTotal = json['CheckTotal'] ?? 0,
        checkContinue = json['CheckContinue'] ?? 0,
        mobile = json['Mobile'],
        isMobile = json['IsMobile'] ?? 0,
        unReadMsg = json['UnReadMsg'] ?? 0,
        province = json['Province'] ?? '',
        city = json['City'] ?? '',
        address = json['Address'] ?? '';
  Map<String,dynamic> toJson()=>{
    'id':id,
    'headImg':headImg,
    'name':name,
    'balance':balance,
    'coin':coin,
    'credit':credit,
    'threadNum':threadNum,
    'likes':likes,
    'grade':grade,
    'checkTotal':checkTotal,
    'checkContinue':checkContinue,
    'mobile':mobile,
    'isMobile':isMobile,
    'unReadMsg':unReadMsg,
    'province':province,
    'city':city,
    'address':address
  };     
}
