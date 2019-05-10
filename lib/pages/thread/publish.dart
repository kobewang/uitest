import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/config/constants.dart';
import 'package:uitest/utils/myDialog.dart';
import 'package:uitest/utils/utils.dart';
import 'package:uitest/widgets/CustomButton.dart';
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
  int _areaId;
  List imageList = [];

  ///图片上传点击
  _pickImageClickEvent(BuildContext context) async{
    if(imageList.length>=9) {
      MyDialog.showToast('上传图片不能超过9张');
      return;
    }
    var img = await Utils.selectImage(context);
    setState(() {
      imageList.add(img);
    });
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
  _submitClickEvent() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('发布${widget.typeName}信息'),
            centerTitle: true,
            elevation: 1),
        body: Column(
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
        padding: EdgeInsets.only(left: 10, right: 10),
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
      var imgWidth = 80.0;
      return GridView.count(
          crossAxisCount: 3, //分3列显示
          children: List.generate(imageList.length + 1, (index) {
            print(index);
            var imgChild;
            if (imageList.length < 9 && index == imageList.length) {
              //最末尾+
              imgChild = InkWell(
                  onTap: (){
                  _pickImageClickEvent(ctx);
                  },
                  child: Image.asset('images/image_add_btn.png',
                      height: imgWidth, width: imgWidth));
            } else {
              imgChild = Image.file(imageList[index - 1]);
            }
            return Container(
                margin: EdgeInsets.all(2.0),
                width: imgWidth,
                height: imgWidth,
                color: Color(0xffececec),
                child: imgChild);
          }));
    });

    return Container(height: 120, child: gridView);
  }

  //ui-协议
  rowRule() {
    return Container(
        height: Utils.getPXSize(context, 100), child: Text('同意协议'));
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

  ///菜单选择
  buildModalBottomSheet() {
    /*
return ListView.separated(
      itemBuilder: (_, i) {
        if (i == _appealTypes.length) {
          return ListTile(
            title: Center(child: Text("取消")),
            onTap: () {
              appealTypeSelectEvent(null);
              Navigator.of(context).pop();
            },
          );
        }
        var type = _appealTypes[i];
        return ListTile(
          title: Center(child: Text(type)),
          onTap: () {
            appealTypeSelectEvent(type);
            Navigator.of(context).pop();
          },
        );
      },
      itemCount: Constants.areaList.length + 1,
      shrinkWrap: true,
      separatorBuilder: (_, i) {
        return Divider(
          height: Utils.getPXSize(context, 1),
        );
      },
    );
    
  }*/
  }
}
