import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/config/constants.dart';
import 'package:uitest/widgets/CustomButton.dart';
import 'package:uitest/widgets/picker.dart';

/// auth:wyj
/// desc:帖子发布页
/// date:20190509

class PublishThreadPage extends StatefulWidget {
  int typeId;
  String typeName;
  PublishThreadPage({Key key, this.typeId, this.typeName}) : super(key: key);
  @override
  createState() => PublishThreadPageState();
}

class PublishThreadPageState extends State<PublishThreadPage> {
  _getPickItems() {
    List<PickerItem> listItems = [];
    Constants.areaList.forEach((item) {
      listItems.add(new PickerItem(name: item['Name'], value: item['Id']));
    });
    return listItems;
  }

  _submitClick() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('发布${widget.typeName}信息'),
            centerTitle: true,
            elevation: 1),
        body: ListView(
          children: <Widget>[
            rowArea(),
            rowDivider(),
            rowContent(),
            rowDivider(),
            rowPic(),
            rowDivider(),
            rowRule(),
            rowDivider(),
            rowButton()
          ],
        ));
  }

  //ui-行-间隔
  rowDivider() {
    return Divider(height: 1, color: Color(0xFF858585));
  }

  //ui-行-商圈
  rowArea() {
    var title = '发布商圈';
    var childWidget = Picker(
        target: Text('请选择'),
        onConfirm: (PickerItem item) {
          //_tabNavClick(typeId,typeName);
        },
        items: _getPickItems());
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      Expanded(
          child: Container(
        margin: EdgeInsets.only(left: 10),
        child: childWidget,
      ))
    ]);
  }

  //ui-内容
  rowContent() {
    return Text('');
  }

  //ui-图片
  rowPic() {
    return Text('');
  }

  //ui-协议
  rowRule() {
    return Text('');
  }

  //ui-按钮
  rowButton() {
    var marginLeft = 20.0;
    return Container(
      margin: EdgeInsets.only(top: 20, left: marginLeft, right: marginLeft),
      child: CustomButton(
        text: '确定',
        heightPx: 70,
        widthPx: 100.0,
        isOutLine: true,
        onPressed: () {
          _submitClick();
        },
      ),
    );
  }
}
