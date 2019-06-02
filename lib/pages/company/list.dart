import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/config/constants.dart';
import 'package:uitest/pages/layout/listlayout.dart';

/// auth:wyj
/// desc:公司列表
/// date:20190531

class CompanyListPage extends StatefulWidget {
  @override
  createState() => CompanyListPageState();
}

class CompanyListPageState extends State<CompanyListPage> {
  List typeList = Constants.companyTypeList;
  _tabNavClick(int typeId, String typeName) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          elevation: 0,
        ),
        body: Column(children: <Widget>[
          ///grid导航
          gridNav(),

          ///我要入驻
          settled(),
          ListLayout()

          ///list列表
        ]));
  }

  ///grid导航
  gridNav() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
          childAspectRatio: 0.8 //宽高比
          ),
      padding: EdgeInsets.all(10),
      itemCount: typeList.length,
      itemBuilder: (_, index) {
        var typeName = typeList[index]['Name'];
        var typeId = typeList[index]['Id'];
        var tabIcon = Container(
            height: 80,
            child: Column(children: <Widget>[
              CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.blue[100],
                  backgroundImage: NetworkImage(
                      'https://img.yms.cn/upload/menu/${typeList[index]['IconName']}')),
              Text(typeName),
            ]));

        return InkWell(
            onTap: () {
              _tabNavClick(typeId, typeName);
            },
            child: Container(margin: EdgeInsets.only(top: 14), child: tabIcon));
      },
    );
  }

  ///入驻
  settled() {
    
  }

  ///list item
  listItem() {}
}
