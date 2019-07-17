import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// auth:wyj
/// desc:公司简介
/// date:20190712
class CompanyIntro extends StatefulWidget {
  @override
  createState() => CompanyIntroState();
}

class CompanyIntroState extends State<CompanyIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('公司介绍'),
        centerTitle: true,
        elevation: 1,
      ),
      body: ListView(
        children: <Widget>[rowHead(), rowBanner(), rowIntro(), rowBusiness(),rowContact()],
      ),
    );
  }

  //行-logo
  rowHead() {
    return Container(
        padding: EdgeInsets.all(5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundImage:
                    NetworkImage('https://www.22.cn/Content/images/logo.png'),
              ),
              Expanded(
                  child: Container(
                      height: 80,
                      //color: Colors.grey,
                      margin: EdgeInsets.only(right: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '浙江贰贰网络有限公司dkj的范德萨范德萨放多少',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  '400-660-2252',
                                  style: TextStyle(fontSize: 16),
                                ))
                          ])))
            ]));
  }

  //行-banner
  rowBanner() {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Image.network(
          'http://www.zgdlfzw.com/user/Uid_6186/2018/4/i_20180403_180641856.jpg'),
    );
  }

  //行-公用title
  rowTitle(String title, Widget child) {
    return Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            Divider(
              height: 1.0,
              color: Colors.black,
            ),
            child
          ],
        ));
  }

  //行-介绍
  rowIntro() {
    var child = Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(
          '    "爱名网"于2008年12月由贺建国、梁天文等域名资深人士共同创建，经过近1年的试运营，2009年9月，“爱名网”团队在“中国电子商务之都”正式成立独立的运营公司－－杭州爱名网络有限公司（电商集团ebeGroup成员企业）。',
          style: TextStyle(fontSize: 16),
        ));
    return rowTitle('公司介绍', child);
  }

  //行-工商信息
  rowBusiness() {
    var child = Container(
        //width: MediaQuery.of(context).size.width-50,
        //height: 400,
        child: Column(
      children: <Widget>[
        rowBusinessItem('企业法人:', '梁天文'),
        rowBusinessItem('注 册 号  :', '42342424242'),
        rowBusinessItem('信用代码:', '154545454545455'),
        rowBusinessItem('注册资本:', '2000万'),
        rowBusinessItem('成立日期:', '2019-07-01'),
        rowBusinessItem(
            '经营范围:', '地方撒旦了佛挡杀佛第三方发多少防守打法范德萨放范德萨范德萨范德萨发送到范德萨发送到范德萨发送范德萨发送到'),
        rowBusinessItem('公司住所:', '浙江省杭州市西湖区紫霞街道放到'),
        rowBusinessItem('营业期限:', '20190205-20190202'),
        rowBusinessItem('企业状态:', '存续'),
      ],
    ));
    return rowTitle('工商信息', child);
  }

  //行-联系信息
  rowContact() {
    var child = Container(
      child:  Column(children: <Widget>[
        rowBusinessItem('联系姓名:', '邵冬冬'),
        rowBusinessItem('Q Q 号码:', '1545454'),
        rowBusinessItem('微信号码:', '1545454'),
        rowBusinessItem('电话号码:', '15157191181'),
        rowBusinessItem('手机号码:', '15157191181'),
        rowBusinessItem('传真号码:', '0571-88276005'),
        rowBusinessItem('官方网站:', 'www.22.cn'),
        rowBusinessItem('联系地址:', '浙江省杭州市西湖区紫霞街道放到'),

      ],)
    );
    return rowTitle('联系我们', child);
  }

  //行-工商信息-item
  rowBusinessItem(String title, String value) {
    return Container(
      margin: EdgeInsets.only(top: 5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Text(
        title,
        style: TextStyle(color: Color(0xffaeaeae)),
      ),
      Container(
          width: 250,
          margin: EdgeInsets.only(left: 20),
          child: Text(value, maxLines: 4, overflow: TextOverflow.ellipsis))
    ]));
  }
}
