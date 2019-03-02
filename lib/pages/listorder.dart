import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uitest/widgets/triangle.dart';

class ListOrderPage extends StatefulWidget {
  @override
  createState() => ListOrderPageState();
}

class ListOrderPageState extends State<ListOrderPage> {
  List listData = [
    {
      'domain': 'zzh.com',
      'price': '7000',
      'month': '1',
      'chajia': '500',
      'state': 0,
      'recomd': 1,
      'package': 0,
      'fanli': 0,
      'fanmoney': '0'
    },
    {
      'domain': 'dfds.com',
      'price': '7000',
      'month': '1',
      'chajia': '500',
      'state': 1,
      'recomd': 0,
      'package': 1,
      'fanli': 0,
      'fanmoney': '0'
    },
    {
      'domain': 'zzfsadfads.com',
      'price': '7000',
      'month': '1',
      'chajia': '500',
      'state': 2,
      'recomd': 0,
      'package': 0,
      'fanli': 1,
      'fanmoney': '100.0'
    },
    {
      'domain': 'zfdsaf.com',
      'price': '7000',
      'month': '1',
      'chajia': '500',
      'state': 3,
      'recomd': 0,
      'package': 0,
      'fanli': 0,
      'fanmoney': '0'
    },
    {
      'domain': 'zfdsfdsads.com',
      'price': '7000',
      'month': '1',
      'chajia': '500',
      'state': 1,
      'recomd': 0,
      'package': 0,
      'fanli': 0,
      'fanmoney': '0'
    },
  ];
  List headItemList = [
    {'id': 0, 'title': '默认', 'issort': false, 'state': 0}, //0：默认 1:正序 -1:倒序
    {'id': 1, 'title': '预期差价', 'issort': true, 'state': 0},
    {'id': 2, 'title': '回购期', 'issort': true, 'state': 0},
    {'id': 3, 'title': '售价', 'issort': true, 'state': 0}
  ];
  //表头
  Widget rowHead() {
    List<Widget> headList = [];
    headItemList.forEach((item) {
      headList.add(rowHeadItem(item['id'], item['title'], item['issort']));
    });
    return Container(
        height: 40,
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: headList));
  }

  sortHeadList(int sortNum) {
    List<Widget> listWidget = [];
    switch (sortNum) {
      case -1: //降序
        listWidget.add(Triangle(myColor: Colors.grey, orientation: 1));
        listWidget.add(Triangle(myColor: Colors.blue, orientation: 0));
        break;
      case 0:
        listWidget.add(Triangle(myColor: Colors.grey, orientation: 1));
        listWidget.add(Triangle(myColor: Colors.grey, orientation: 0));
        break;
      case 1: //升序
        listWidget.add(Triangle(myColor: Colors.blue, orientation: 1));
        listWidget.add(Triangle(myColor: Colors.grey, orientation: 0));
        break;
      default:
    }
    return listWidget;
  }

  //表头item
  Widget rowHeadItem(id, title, isSort) {
    var textColor = Color(0xFF555555);
    var textOnColor = Color(0xFF388ced);
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontSize: 20,
                  color: headItemList[id]['state'] == 0
                      ? textColor
                      : textOnColor)),
          InkWell(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: sortHeadList(headItemList[id]['state'])),
            onTap: () {
              setState(() {
                switch (headItemList[id]['state']) {
                  case -1:
                    headItemList[id]['state'] = 0;
                    break;
                  case 0:
                    headItemList[id]['state'] = 1;
                    break;
                  case 1:
                    headItemList[id]['state'] = -1;
                    break;
                }
              });
            },
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('交易列表'),
          actions: <Widget>[Icon(Icons.share)],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            rowHead(),
            Expanded(
                child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: listData.length,
              itemBuilder: (context, index) {
                return Text(listData[index]['domain']);
              },
            ))
          ],
        ));
  }
}
