import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/config/constants.dart';
import 'package:uitest/dao/threadDao.dart';
import 'package:uitest/model/addThreadInfo.dart';
import 'package:uitest/pages/layout/result.dart';
import 'package:uitest/utils/myDialog.dart';
import 'package:uitest/utils/myDialog.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/CustomButton.dart';
import 'package:uitest/widgets/customCheckBox.dart';
import 'package:uitest/widgets/picker.dart';

/// auth:wyj
/// desc:帖子发布页
/// date:20190509

class ThreadPublishPage extends StatefulWidget {
  int typeId;
  String typeName;
  ThreadPublishPage({Key key, this.typeId, this.typeName}) : super(key: key);
  @override
  createState() => ThreadPublishPageState();
}

class ThreadPublishPageState extends State<ThreadPublishPage> {
  String _contentStr = '';
  String _city;
  int _areaId = 0;
  var imgHgt = 120.0;
  var imgGridHeight = 120.0;
  int gridLen = 1;
  var isAgree = false;
  List<File> imageList = [];

  ///图片上传点击
  _pickImageClickEvent(BuildContext context) async {
    if (imageList.length >= 9) {
      MyDialog.showToast('上传图片不能超过9张');
      return;
    }
    var img = await Utils.selectImage(context);
    if (img != null) {
      setState(() {
        imageList.add(img);
        //控制GridView的九宫图的自动高度
        var imgLen = imageList.length;
        gridLen = imgLen < 9 ? imgLen + 1 : imgLen;
        if (imgLen < 3) {
          imgGridHeight = imgHgt;
        } else if (imgLen >= 3 && imgLen < 6) {
          imgGridHeight = imgHgt * 2;
        } else {
          imgGridHeight = imgHgt * 3;
        }
        print(imgGridHeight);
      });
    }
  }

  ///获取商圈列表
  _getPickItems() {
    List<PickerItem> listItems = [];
    Constants.areaList.forEach((item) {
      listItems.add(new PickerItem(name: item['City'], value: item['Id']));
    });
    return listItems;
  }

  ///商圈选中
  _pickItemClickEvent(PickerItem item) {
    setState(() {
      _city = item.name;
      _areaId = item.value;
    });
  }

  ///提交发布
  _submitClickEvent() async {
    if (!isAgree) {
      MyDialog.showToast('请先同意发布条款');
      return;
    }
    if (_areaId == 0) {
      MyDialog.showToast('请选择商圈');
      return;
    }
    if (_contentStr.isEmpty) {
      MyDialog.showToast('请输入发布内容');
      return;
    }

    AddThreadInfo addInfo =
        new AddThreadInfo(type: widget.typeId, content: _contentStr);
    MyDialog.showLoading(context, '正在提交中..');
    var res = await ThreadDao.add(addInfo);
    if (res == null) {
      MyDialog.showToast('提交失败');
      return;
    }
    if (res.data['Code'] != 0) {
      Navigator.of(context).pop();
      MyDialog.showAlert(context, res.data['Header']['ErrorMessage']);
      return;
    }
    var threadId = res.data['Data']['Tid'];
    if (imageList.length > 0) {
      for (int i = 0; i < imageList.length; i++) {
        await _uploadImg(threadId, i, imageList[i]);
      }
    } else {
      Navigator.of(context).pop();
      MyDialog.showToast('提交成功');
      Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
        return ResultPage(resultState: true, tipStr: '提交成功，请等待审核处理');
      }));
    }
  }

  _uploadImg(int threadId, int index, File imgFile) async {
    var res =
        await ThreadDao.uploadImg(threadId, index, imgFile, imgType: 'thread');
    print(res.data);
    if (index == imageList.length - 1) {
      Navigator.of(context).pop();
      MyDialog.showToast('图片上传完成');
      Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
        return ResultPage(resultState: true, tipStr: '提交成功，请等待审核处理');
      }));
    }
  }

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
            rowDividerBlock(),
            rowContent(),
            rowDividerBlock(),
            rowPic(),
            rowDividerBlock(),
            rowRule(),
            rowDividerBlock(),
            rowButton()
          ],
        ));
  }

  //ui-行-间隔
  rowDividerBlock() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 10,
        decoration:
            BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey[300]));
  }

  //ui-行-商圈
  rowArea() {
    var title = '请选择商圈';
    var rowWidget = Container(
        padding: EdgeInsets.only(
            left: Utils.getPXSize(context, 40),
            right: Utils.getPXSize(context, 40)),
        height: Utils.getPXSize(context, 100),
        width: MediaQuery.of(context).size.width,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Text(
                _city ?? title,
                style: TextStyle(
                    fontSize: Utils.getPXSize(context, 30),
                    color: Color(0xff333333)),
              )),
              Container(
                child: Icon(Icons.chevron_right, color: Color(0xff333333)),
              )
            ]));
    return Picker(
        target: rowWidget,
        onConfirm: (PickerItem item) {
          _pickItemClickEvent(item);
        },
        items: _getPickItems());
  }

  //ui-内容
  rowContent() {
    return Container(
        padding: EdgeInsets.only(
          left: Utils.getPXSize(context, 40),
          right: Utils.getPXSize(context, 40),
        ),
        height: Utils.getPXSize(context, 400),
        //color: Colors.white,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xffd3d3d3), width: 1)),
        child: TextField(
          keyboardType: TextInputType.text,
          maxLines: 8,
          maxLength: 100,
          obscureText: false, //是否隐藏输入
          textInputAction: TextInputAction.newline,
          onChanged: (val) {
            _contentStr = val;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "请输入发布内容(100字以内)",
            hintStyle: TextStyle(
              fontSize: Utils.getPXSize(context, 28.0),
              color: Color(0xff999999),
            ),
            counterStyle: TextStyle(
              fontSize: Utils.getPXSize(context, 28.0),
              color: Color(0xff999999),
            ),
          ),
        ));
  }

  //ui-图片
  rowPic() {
    return Container(
      padding: EdgeInsets.only(
        left: Utils.getPXSize(context, 40),
        right: Utils.getPXSize(context, 40),
      ),
      //height: Utils.getPXSize(context, 560),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text.rich(
            TextSpan(text: "上传图片", children: [
              TextSpan(
                text: "（九张以内）",
                style: TextStyle(
                  color: Color(0xff999999),
                ),
              )
            ]),
            style: TextStyle(
              fontSize: Utils.getPXSize(context, 30),
              color: Color(0xff333333),
            ),
          ),
          imageGridView()
        ],
      ),
    );
  }

  imageGridView() {
    //最大3*3 9宫图
    var gridView = new Builder(builder: (ctx) {
      var imgWidth = 60.0;
      return GridView.count(
          crossAxisCount: 3, //分3列显示
          physics: new NeverScrollableScrollPhysics(),
          children: List.generate(gridLen, (index) {
            //print('imageList.length：${imageList.length} index: ${index}');
            var imgChild;

            if (imageList.length < 9 && index == imageList.length ||
                imageList.length == 0) {
              //最末尾+
              imgChild = InkWell(
                  onTap: () {
                    _pickImageClickEvent(ctx);
                  },
                  child: Image.asset('images/image_add_btn.png',
                      height: imgWidth, width: imgWidth));
            } else {
              imgChild = Image.file(imageList[index],
                  width: imgWidth, height: imgWidth, fit: BoxFit.cover);
            }
            return Container(
                margin: EdgeInsets.all(2.0),
                width: imgWidth,
                height: imgWidth,
                color: Color(0xffececec),
                child: imgChild);
          }));
    });
    return Container(height: imgGridHeight, child: gridView);
  }

  //ui-协议
  rowRule() {
    var fontSize=15.0;
    return Container(
        padding: EdgeInsets.all(
          Utils.getPXSize(context, 40),
        ),
        child: Row(children: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 10),
              child: CustomCheckBox(
                value: !isAgree,
                onTap: () {
                  setState(() {
                    isAgree = !isAgree;
                  });
                },
              )),
          InkWell(
              onTap: () {
                setState(() {
                  isAgree = !isAgree;
                });
              },
              child: Text(
                "我同意条款，保证合法合规",
                style: TextStyle(fontSize: fontSize)
              )),
          Container(
              margin: EdgeInsets.only(left: 10),
              child: InkWell(
                  onTap: () {
                    Utils.gotoWebView('信息发布协议', Constants.URL_PUBLISH_RULE);
                  },
                  child:
                      Text('《信息发布协议》', style: TextStyle(color: Colors.blue,fontSize: fontSize))))
        ]));
  }

  //ui-按钮
  rowButton() {
    var marginLeft = 20.0;
    return Container(
      height: Utils.getPXSize(context, 70),
      width: MediaQuery.of(context).size.width - 2 * marginLeft,
      margin: EdgeInsets.only(top: 20, left: marginLeft, right: marginLeft),
      child: CustomButton(
        text: '确定',
        heightPx: 70,
        widthPx: 100.0,
        isOutLine: true,
        onPressed: () {
          _submitClickEvent();
        },
      ),
    );
  }
}
