import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vertical_marquee/flutter_vertical_marquee.dart';
import 'package:uitest/config/constants.dart';
import 'package:uitest/dao/companyDao.dart';
import 'package:uitest/model/companyInfo.dart';
import 'package:uitest/pages/layout/listlayout.dart';
import 'package:uitest/widgets/CustomButton.dart';
import 'package:url_launcher/url_launcher.dart';

/// auth:wyj
/// desc:公司列表
/// date:20190531

class CompanyListPage extends StatefulWidget {
  @override
  createState() => CompanyListPageState();
}

class CompanyListPageState extends State<CompanyListPage> {
  Color greyColor = Color(0xff808080);
  List typeList = Constants.companyTypeList;
  List<String> listMarquee = [];
  List<CompanyInfo> listData = null;
  var loadFailed = false;
  var isNoMore = false;
  var curPage = 1;
  var totalCount = 0;
  var bottomDivider = 10.0; //底部间隔
  @override
  initState() {
    listMarquee.add('·恭喜，入驻跑马灯1');
    listMarquee.add('·恭喜，入驻跑马灯2');
  }

  Future<List<CompanyInfo>> _getList() async {
    var res = await CompanyDao.list(page: curPage);
    if (res == null) {
      setState(() {
        loadFailed = true;
        return null;
      });
    }
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
    setState(() {
      loadFailed = false;
      if (listData == null || curPage == 1)
        listData = CompanyInfo.getList(res.data['Data']['List']);
      else
        listData.addAll(CompanyInfo.getList(res.data['Data']['List']));
      totalCount = res.data['Data']['Count'];
      if (listData.length == totalCount) isNoMore = true;
    });
    return listData;
  }

  Future<List<CompanyInfo>> _onRefresh() async {
    curPage = 1;
    return _getList();
  }

  Future<List<CompanyInfo>> _getMore() async {
    curPage = curPage + 1;
    return _getList();
  }

  /**
 * 在浏览器中打开
 */
  static Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('浏览器打开失败:' + url);
    }
  }

  _tabNavClick(int typeId, String typeName) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          elevation: 0,
        ),
        body: Container(
            color: Color(0xFFececec),
            child: ListLayout(
              refresh: _onRefresh,
              more: _getMore,
              loadFailded: loadFailed,
              builder: (context, index) {
                return ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    if (index == 0) return gridNav();

                    ///grid导航
                    if (index == 1) return settled();

                    ///我要入驻
                    return listItem(context, index);
                  },
                );
              },
            ))

        ///list列表
        );
  }

  ///grid导航
  gridNav() {
    return Container(
        height: 110,
        color: Colors.white,
        margin: EdgeInsets.only(bottom: bottomDivider), //间隔
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
              childAspectRatio: 0.8 //宽高比
              ),
          itemCount: typeList.length,
          itemBuilder: (_, index) {
            var typeName = typeList[index]['Name'];
            var typeId = typeList[index]['Id'];
            var tabIcon = Container(
                height: 100,
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
                child: Container(
                    margin: EdgeInsets.only(top: 14, bottom: 14),
                    child: tabIcon));
          },
        ));
  }

  ///入驻-跑马灯
  settled() {
    var controller = MarqueeController();
    var marquee = GestureDetector(
        child: Container(
          height: 40.0,
          child: Marquee(
            textList:
                listMarquee, // List<Text>, textList and textSpanList can only have one of code.
            fontSize: 14.0, // text size
            scrollDuration: Duration(seconds: 1), // every scroll duration
            stopDuration: Duration(seconds: 3), //every stop duration
            tapToNext: false, // tap to next
            textColor: Colors.black, // text color
            controller: controller, // the controller can get the position
          ),
        ),
        onTap: () {
          print(controller.position); // get the position
        });
    return Container(
        height: 40,
        margin: EdgeInsets.only(bottom: bottomDivider), //间隔
        color: Colors.white,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: CustomButton(
                  text: "我要入驻",
                  onPressed: () {
                    //_submitLogin(store);  launchURL(url);
                    launchURL(
                        'https://www.22.cn/42bbccdafd76f99abe202da9324e3038.txt');
                  },
                  heightPx: 60,
                  widthPx: 200,
                ),
              ),
              Expanded(child: marquee)
            ]));
  }

  ///list item
  listItem(context, index) {
    var item = listData[index - 2];
    return Container(
        margin: EdgeInsets.only(bottom: bottomDivider, left: 5, right: 5), //间隔
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(5),
                child: Image.network(item.headImg, width: 80, height: 80)),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 10,top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.name,
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              item.address,
                              style: TextStyle(color: greyColor, fontSize: 12),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                itemStars(item.star),
                                Text('人气:${item.views}',
                                    style: TextStyle(
                                        color: greyColor, fontSize: 12))
                              ],
                            )
                          ],
                        )),
                        Container(
                          child: CircleAvatar(
                              child: Icon(Icons.phone),
                              backgroundColor: Theme.of(context).primaryColor),
                          height: 40,
                          width: 40,
                        ),
                      ],
                    )))
          ],
        ));
  }

  itemStars(int stars) {
    var widgets = <Widget>[];
    for (var i = 0; i < stars; i++) {
      widgets.add(Icon(Icons.star, color: greyColor));
    }

    return Row(children: widgets);
  }
}
