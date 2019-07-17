import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/utils/utils.dart';

/// auth:wyj
/// desc:公司详情
/// date:20190708
class CompanyDetail extends StatefulWidget {
  @override
  createState() => CompanyDetailState();
}

class CompanyDetailState extends State<CompanyDetail> {
  List gridList = [
    {
      'Name': '公司介绍',
      'Icon': 'https://img.yms.cn/upload/company/introduce-orange.png'
    },
    {
      'Name': '产品展示',
      'Icon': 'https://img.yms.cn/upload/company/goods_purple.png'
    },
    {
      'Name': '信息发布',
      'Icon': 'https://img.yms.cn/upload/company/fabu_green.png'
    },
    {
      'Name': '联系方式',
      'Icon': 'https://img.yms.cn/upload/company/contact-yellow.png'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('公司详情'),
        centerTitle: true,
        elevation: 1,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          rowCard(),
          rowGridNav(),
          Expanded(child: rowListNav())
        ],
      )),
    );
  }

  //名片卡片行
  rowCard() {
    return Container(
        //color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        height: 200,
        width: Utils.getPXSize(context, 700),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
              color: Colors.grey[300],
              offset: Offset(1.0, 1.0),
              blurRadius: 1.0),
          BoxShadow(
              color: Colors.grey[300],
              offset: Offset(-1.0, -1.0),
              blurRadius: 1.0),
          BoxShadow(
              color: Colors.grey[300],
              offset: Offset(1.0, -1.0),
              blurRadius: 1.0),
          BoxShadow(
              color: Colors.grey[300],
              offset: Offset(-1.0, 1.0),
              blurRadius: 1.0),
        ]),
        child: Container(
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
            child: Column(
              children: <Widget>[
                //卡片头
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              'https://www.22.cn/Content/images/logo.png'),
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '浙江贰贰网络有限公司',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text('IT、互联网'),
                            Text('浙江杭州')
                          ],
                        ))
                  ],
                ),
                //卡片间隔
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Divider(
                      height: 2,
                      color: Colors.grey,
                    )),
                //卡片底部
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      cardFootTitle('法定代表人', '梁天文'),
                      cardFootTitle('注册资本', '1000万'),
                      cardFootTitle('成立日期', '20190709'),
                    ]),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(bottom: 2),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Color(0xFF919191),
                              size: 20,
                            ),
                            Expanded(
                                child: Text('浙江省杭州市西湖区紫霞街176号杭州互联网创新创业园2号楼11楼',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(0xFF919191),
                                        fontSize:
                                            Utils.getPXSize(context, 24))))
                          ],
                        )))
              ],
            )));
  }

  //卡片底部文字
  cardFootTitle(String title, String value) {
    return Column(children: <Widget>[
      Text(
        title,
        style: TextStyle(color: Color(0xff6f6f6f)),
      ),
      Text(value)
    ]);
  }

  //grid导航列表
  rowGridNav() {
    return Container(
        height: 110,
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 10), //间隔
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
              childAspectRatio: 0.8 //宽高比
              ),
          itemCount: gridList.length,
          itemBuilder: (_, index) {
            var typeName = gridList[index]['Name'];
            var tabIcon = Container(
                height: 100,
                child: Column(children: <Widget>[
                  CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.blue[100],
                      backgroundImage:
                          NetworkImage('${gridList[index]['Icon']}')),
                  Text(typeName),
                ]));

            return InkWell(
                onTap: () {
                  //_tabNavClick(typeId, typeName);
                },
                child: Container(
                    margin: EdgeInsets.only(top: 14, bottom: 14),
                    child: tabIcon));
          },
        ));
  }

  //list导航列表
  rowListNav() {
    return ListView(children: <Widget>[
      listItem('公司动态'),
      listItem('公司相册'),
      listItem('公司信用'),
      listItem('招商代理'),
      listItem('人才招聘'),
    ]);
  }

  //list-item
  listItem(String title) {
    return Container(
        height: 60,
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                    fontSize: Utils.getPXSize(context, 30),
                    color: Color(0xff333333),
                  )),
              Icon(
                Icons.chevron_right,
                color: Color(0xff999999),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: 
          Divider(height: 1, color: Color(0xff999999))
          )
        ]));
  }
}
