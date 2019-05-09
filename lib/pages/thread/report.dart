import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uitest/dao/threadDao.dart';
import 'package:uitest/model/reportInfo.dart';
import 'package:uitest/pages/layout/result.dart';
import 'package:uitest/utils/myDialog.dart';
import 'package:uitest/widgets/CustomButton.dart';

/// auth:wyj
/// desc:举报页面
/// date:20190507
class ReportPage extends StatefulWidget {
  int threadId;
  ReportPage({Key key, this.threadId}) : super(key: key);
  @override
  createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  var marginLeft = 10.0;
  String _memoStr = "";
  String _nameStr = "";
  String _mobileStr = "";
  List reasonList = [
    {'title': '电话虚假', 'on': false},
    {'title': '信息虚假', 'on': false},
    {'title': '涉黄违法', 'on': false},
    {'title': '恶意营销', 'on': false},
    {'title': '赌博违法', 'on': false},
    {'title': '其它违法', 'on': false}
  ];

_submitClick() async{
  var isSel=false;
  var tag='';
  reasonList.forEach((item){
    if(item['on']){
      isSel=true;
      tag=item['title'];
    }
  });
  if(!isSel) {
    MyDialog.showToast('请选择原因');
    return;
  }
  if(_memoStr.isEmpty) {
    MyDialog.showToast('请填写备注说明');
    return;
  }
  if(_nameStr.isEmpty) {
    MyDialog.showToast('请填写姓名');
    return;
  }
  if(_mobileStr.isEmpty) {
    MyDialog.showToast('请填写手机号');
    return;
  }
  MyDialog.showLoading(context, '提交中');
  ReportInfo rInfo=new ReportInfo(linkId:widget.threadId,name:_nameStr,mobile:_mobileStr,tag:tag,content:_memoStr);
  var res =  await ThreadDao.report(rInfo);
  if(res!=null) {
    Navigator.of(context).pop();
    if(res.data['Code']==0) {
      Navigator.of(context).push(new MaterialPageRoute(builder: (_){return ResultPage(resultState: true,tipStr:'提交成功，请等待审核处理');}));
    } else {
      MyDialog.showAlert(context, res.data['Data']);
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('举报信息'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
            color: Colors.grey[300],
            child: ListView(
              shrinkWrap: false,
              children: <Widget>[
                Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[rowTitle('请选择原因'),        dividerTitle(),rowReason()],
                    )),
                dividerBlock(),
                Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[rowTitle('备注说明(0-100字)'), rowMemo()],
                    )),
                dividerBlock(),
                Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        rowTitle('联系方式'),
                        dividerTitle(),
                        rowInput('联系人', '请输入您的姓名'),
                        dividerRow(),
                        rowInput('手机号', '请输入您的手机号'),
                        dividerTitle(),
                      ],
                    )),
                rowButton()
              ],
            )));
  }

  //ui-间隔
  dividerBlock() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 10,
        decoration:
            BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey[300]));
  }

  //ui-间隔
  dividerTitle() {
    return Divider(height: 1, color: Color(0xFF858585));
  }

  //ui-间隔
  dividerRow() {
    return Divider(height: 1, color: Colors.grey[300]);
  }

  //ui-标题行
  rowTitle(String title) {
    return Container(
        margin: EdgeInsets.only(left: marginLeft),
        height: 25,
        child: Text(title,
            style: TextStyle(
                fontSize: 20, color: Theme.of(context).primaryColor)));
  }

  var isSelect = false;
  //ui-原因行
  rowReason() {
    List<Widget> listBtn0 = [];
    List<Widget> listBtn1 = [];
    for (var i = 0; i < reasonList.length; i++) {}
    var index = 0;
    reasonList.forEach((item) {
      var child = GestureDetector(
          onTap: () {
            setState(() {
              reasonList.forEach((rItem){
                if(item['title']==rItem['title'])
                rItem['on']=true;
                else rItem['on']=false;
              });
              //item['on'] = !item['on'];
            });
          },
          child: Container(
              height: 25,
              width: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Theme.of(context).primaryColor, width: 1),
                  color: item['on'] ? Theme.of(context).primaryColor : Colors.white),
              child: Center(
                  child: Text(item['title'],
                      style: TextStyle(fontSize: 15,
                           color: item['on'] ? Colors.white : Colors.black)))));
      if (index < 3)
        listBtn0.add(child);
      else
        listBtn1.add(child);
      index++;
    });
    return Container(
      padding: EdgeInsets.all(10),
        child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: listBtn0
        ),
        Container(
          margin: EdgeInsets.only(top:10),
          child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: listBtn1
          )
        )
      ],
    ));
  }

  //ui-备注行
  rowMemo() {
    return Container(
        margin: EdgeInsets.only(
            left: marginLeft, right: marginLeft, top: 5, bottom: 10),
        decoration: BoxDecoration(
            color: Color(0xffe5e5e5),
            border: Border.all(color: Color(0xffd3d3d3), width: 1)),
        child: TextField(
          keyboardType: TextInputType.text,
          maxLines: 3,
          onChanged: (val) {
            _memoStr = val;
          },
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '请简明扼要的阐述您的理由，以便工作人员更好的判断',
              hintStyle: TextStyle(fontSize: 15, color: Color(0xff858585))),
        ));
  }

  //ui-输入行
  rowInput(String title, String hintText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: marginLeft),
            child: Text(
              title,
              style: TextStyle(fontSize: 18),
            )),
        Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 10),
                child: TextField(

                  keyboardType: title == '手机号'
                      ? TextInputType.number
                      : TextInputType.text,
                  textInputAction: TextInputAction.newline,
                  maxLength: title == '手机号'?11:4,
                  onChanged: (val) {
                    title == '手机号' ? _mobileStr = val : _nameStr = val;
                  },
                  decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle:
                          TextStyle(fontSize: 15, color: Color(0xff858585))),
                )))
      ],
    );
  }

  //ui-按钮行
  rowButton() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: marginLeft, right: marginLeft),
      child: CustomButton(
        text: '确定',
        heightPx: 70,
        widthPx: 100.0,
        isOutLine: true,
        onPressed: (){
          _submitClick();
        },
      ),
    );
  }
}
