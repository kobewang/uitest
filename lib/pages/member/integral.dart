import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/dao/financeDao.dart';
import 'package:uitest/model/financeInfo.dart';
import 'package:uitest/pages/layout/listlayout.dart';
import 'package:uitest/pages/layout/titleLayout.dart';
import 'package:uitest/utils/utils.dart';

/// auth:wyj
/// desc:积分列表
/// date:20190514
class IntegralPage extends StatefulWidget {
  @override
  createState() => IntegralPageState();
}

class IntegralPageState extends State<IntegralPage> {
  List<FinanceInfo> listData;
  int _curPage = 1;
  var _loadFailed = true;
  var _isNoMore = false;
  Future<List<FinanceInfo>> _getList() async {
    var res = await FinanceDao.list(page: _curPage);
    if (res == null) {
      setState(() {
        _loadFailed = true;
        return null;
      });
    }
    setState(() {
      _loadFailed = false;
      if (listData == null || _curPage == 1)
        listData = FinanceInfo.getList(res.data['Data']['List']);
      else
        listData.addAll(FinanceInfo.getList(res.data['Data']['List']));
    });
    return listData;
  }

  Future<List<FinanceInfo>> _refresh() async {
    _curPage = 1;
    return _getList();
  }

  Future<List<FinanceInfo>> _getMore() async {
    _curPage = _curPage + 1;
    return _getList();
  }

  @override
  Widget build(BuildContext context) {
    return TitleLayout(
        title: '积分记录',
        body: ListLayout(
          refresh: _refresh,
          loadFailded: _loadFailed,
          more: _getMore,
          noMore: _isNoMore,
          builder: (context, _) {
            return ListView.builder(
              itemCount: listData.length,
              itemBuilder: (_, index) {
                return listItem(_, index);
              },
            );
          },
        ));
  }

  //list item
  Widget listItem(BuildContext context, int index) {
    var item = listData[index];
    return Container(
      //height: Utils.getPXSize(context, 150),
      padding: EdgeInsets.only(
          left: Utils.getPXSize(context, 40),
          right: Utils.getPXSize(context, 40)),
      child: Container(
        padding: EdgeInsets.only(
          bottom: Utils.getPXSize(context, 30),
          top: Utils.getPXSize(context, 30),
        ),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xfff0f0f0)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.remark,
                  style: TextStyle(
                      fontSize: Utils.getPXSize(context, 30),
                      color: Color(0xff555555)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Utils.getPXSize(context, 30)),
                ),
                Text(
                  '${item.addtime}',
                  style: TextStyle(
                      fontSize: Utils.getPXSize(context, 30),
                      color: Color(0xff999999)),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  '${item.isAdd == 1 ? "+" : "-"} ${item.amount}',
                  style: TextStyle(
                      fontSize: Utils.getPXSize(context, 30),
                      color: Color(item.isAdd == 1 ? 0xff555555 : 0xff008000)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Utils.getPXSize(context, 30)),
                ),
                Text(
                  '${item.coin}',
                  style: TextStyle(
                      fontSize: Utils.getPXSize(context, 30),
                      color: Color(0xff999999)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
