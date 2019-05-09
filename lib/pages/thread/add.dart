import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/config/constants.dart';
import 'package:uitest/dao/threadDao.dart';
import 'package:uitest/pages/thread/publish.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/CustomButton.dart';
import 'package:uitest/widgets/picker.dart';

/// auth:wyj
/// desc:发布帖子
/// date:20190508
class ThreadAddPage extends StatefulWidget {
  @override
  createState() => ThreadAddPageState();
}

class ThreadAddPageState extends State<ThreadAddPage> {
  List typeList = Constants.typeList;
  //加载类型菜单
  Future<void> loadMenu() async {}

  //导航点击,加载二级菜单
  _tabNavClick(int typeId,String typeName) {
    Navigator.of(context).push(new MaterialPageRoute(builder:(_){return PublishThreadPage(typeId:typeId,typeName:typeName);}));
  }
  @override
  void initState() {
    loadMenu();
    super.initState();
  }

  ///获取pickitems
  List<PickerItem> _getPickItems(typeItem) {
    List<PickerItem> lists = [];
    typeItem['Child'].forEach((item) {
      lists.add(PickerItem(name: item['Name'], value: item['Id']));
    });
    return lists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('选择分类'),
          centerTitle: true,
          elevation: 1,
          actions: <Widget>[
            CustomButton(
              text: '发布须知',
              widthPx: 200,
              heightPx: 40,
            )
          ],
        ),
        body: RefreshIndicator(
            onRefresh: loadMenu,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                rowTip(),
                rowDivider(),
                rowShop(),
                rowDivider(),
                rowPlease(),
                rowTablist()
              ],
            )));
  }

  //ui-提醒
  rowTip() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      color: Color(0xFFeff9ff),
      child: Text('禁止微商、刷单、网络兼职、医疗药品等在此栏目发布，否则一律删除。'),
    );
  }

  //ui-间隔
  rowDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[300],
    );
  }

  //ui-店铺
  rowShop() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.store,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('我是商家，入驻', style: TextStyle(fontSize: 17)),
                          Text(
                            '超低成功，网络宣传，简单有效，方便快捷',
                            style: TextStyle(color: Color(0xFF999999)),
                          )
                        ],
                      ))
                ],
              ),
              Icon(
                Icons.chevron_right,
                color: Color(0xffC8C8CD),
              )
            ]));
  }

  //ui-请选择
  rowPlease() {
    return Center(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 60,
                    child: Divider(
                      height: 1,
                    )),
                Text('请选择你要发布的栏目'),
                Container(
                    width: 60,
                    child: Divider(
                      height: 1,
                    )),
              ],
            )));
  }

  //ui-gridview
  rowTablist() {
    return typeList == null
        ? CupertinoActivityIndicator()
        : Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
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
                   
                return typeList[index]['Father']
                    ? Picker(
                        target: tabIcon,
                        onConfirm: (PickerItem item) {
                          _tabNavClick(typeId,typeName);
                        },
                        items: _getPickItems(typeList[index]))
                    : InkWell(
                      onTap: (){_tabNavClick(typeId,typeName);},
                      child: Container(margin: EdgeInsets.only(top:14), child: tabIcon)); 
                    
              },
            ));
  }
}
