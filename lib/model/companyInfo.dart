/// auth:wyj
/// desc:公司介绍
/// date:20190605

class CompanyInfo {
  int id;
  String headImg;
  String name;
  String mobile;
  String weixin;
  String area;
  String type;
  String job;
  String jianJie;
  String gongSi;
  List<String> picList;
  int star;
  int likes;
  int views;
  int follows;
  String address;
  String wxQrImg;
  String notice;
  String xcxQrCode;
  String logoImg;
  String shareImg;
  String shareUrl;
  String shareTitle;
  double longitude;
  double latitude;
  String distance;
  CompanyInfo({
    this.id,
    this.headImg,
    this.name,
    this.mobile,
    this.weixin,
    this.area,
    this.type,
    this.job,
    this.jianJie,
    this.gongSi,
    this.picList,
    this.star,
    this.likes,
    this.views,
    this.follows,
    this.address,
    this.wxQrImg,
    this.notice,
    this.xcxQrCode,
    this.logoImg,
  });
  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
        id: json['Id'],
        headImg: json['HeadImg'] ?? '',
        name: json['Name'] ?? '',
        mobile: json['Mobile'] ?? '',
        weixin: json['Weixin'] ?? '',
        area: json['Area'] ?? '',
        type: json['Type'] ?? '',
        job: json['Job'] ?? '',
        jianJie: json['JianJie'] ?? '',
        gongSi: json['GongSi'] ?? '',
        picList: json['PicList'] == null
            ? []
            : (json['PicList'] as List).map((item) {
                return item.toString();
              }).toList(),
        star: json['Star'] ?? 0,
        likes: json['Likes'] ?? 0,
        views: json['Views'] ?? 0,
        follows: json['Follows'] ?? 0,
        address: json['Address'] ?? '',
        wxQrImg: json['WxQrImg'] ?? '',
        notice: json['Notice'] ?? '',
        xcxQrCode: json['XcxQrCode'] ?? '',
        logoImg: json['LogoImg'] ?? '');
  }
  static getList(data) {
    List<CompanyInfo> list = new List<CompanyInfo>();
    for (var item in data) {
      list.add(CompanyInfo.fromJson(item));
    }
    return list;
  }
}
