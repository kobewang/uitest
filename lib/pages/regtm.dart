import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:card_settings/card_settings.dart';
import 'package:flutter/services.dart';
import 'package:uitest/dao/tmDao.dart';
import 'package:uitest/model/regtmInfo.dart';
import 'package:uitest/utils/tmtypes.dart';
import 'package:image_picker/image_picker.dart';
/// 商标注册提交页面
///
/// auth:wyj 20190214
class RegtmPage extends StatefulWidget{
  @override
  createState ()=> RegtmPageState();
}
class RegtmPageState extends State<RegtmPage>  with SingleTickerProviderStateMixin {
  TabController _tabController;
  var _regTmInfo = new RegTmInfo();
  List proData=[];
  List<String> listTypes=[];
  List<String> listProvince=[];
  Future<File> _imageFile;
  File _yyzzImage;
  int provinceIndex = 0;
  List<String> listCity=[];
  int cityIndex = 0;
  List<String> listArea=[];
  var isSubmiting=false;
  var _autovalidate = false;//自动验证
  
  final GlobalKey<FormState> _qiyeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _tmNameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _tmTypeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _applyerKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _provinceKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _cityKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _areaKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _addressKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _mobileKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this,length: 3);
    TmTypes.TYPES.forEach((item){
      listTypes.add(item['id'].toString()+'-'+item['title'].toString());
    });
    rootBundle.loadString('data/province.json').then((v) {
      proData = json.decode(v);
      proData.forEach((item){
        listProvince.add(item['name']);
      });
      proData[0]['sub'].forEach((item){
        listCity.add(item['name']);
      });
      proData[0]['sub'][0]['sub'].forEach((item){
        listArea.add(item['name']);
      });
    });    
  }
  //省份索引
  int getProvinceIndex(String province) {
    for(var i=0;i<proData.length;i++){
      if(proData[i]['name'].toString()==province)
        return i;
      i++;
    }
    return 0;
  }
  //省份切换
  void changeProinvce(String province) {
    setState(() {
      listCity=[];
      provinceIndex = getProvinceIndex(province);
      proData[provinceIndex]['sub'].forEach((item){
        listCity.add(item['name']);
      });
      listArea=[];
      proData[provinceIndex]['sub'][0]['sub'].forEach((item){
        listArea.add(item['name']);
      });
    });    
  }
  //城市索引
  int getCityIndex(String city) {
    for(var i=0; i < proData[provinceIndex]['sub'].length; i++) {
      if(proData[provinceIndex]['sub'][i]['name'].toString()==city)
        return i;
    }
    return 0;
  }
  //城市切换
  void changeCity(String city) {
    setState(() {
      listArea=[];
      cityIndex=getCityIndex(city);
      proData[provinceIndex]['sub'][cityIndex]['sub'].forEach((item){
        listArea.add(item['name']);
      });
    });
  }

  Widget qiyeForm(BuildContext context) {
    return 
        CardSettings(children: <Widget>[
          CardSettingsHeader(label: '商标信息',color: Colors.indigo[400],),
          CardSettingsText(
            key: _tmNameKey,
            label: '名称',
            hintText: '申请商标名，必填',
            autovalidate: _autovalidate,
            requiredIndicator: Text('*',style: TextStyle(color: Colors.red)),
            validator: (value) {
              if(value==null ||value.isEmpty) return '商标名称不能为空';
              return null;
            },
            onChanged:  (value)=> _regTmInfo.tmName=value,
            onSaved: (value)=> _regTmInfo.tmName=value,
          ),
         CardSettingsListPicker(
            key: _tmTypeKey,
            label: '类别',
            hintText: '请选择',
            autovalidate: _autovalidate,
            requiredIndicator: Text('*',style: TextStyle(color: Colors.red)),
            options: listTypes,
            validator: (value){
              if(value==null ||value.isEmpty) return '商标类别不能为空';
              return null;
            },
            onChanged: (value)=> _regTmInfo.tmType=value,
            onSaved: (value) => _regTmInfo.tmType=value,
          ),
          CardSettingsParagraph(
            label: '备注',
            initialValue: '填写您的商标注册需求',
            onChanged:  (value)=> _regTmInfo.reMark=value,
            onSaved: (value)=> _regTmInfo.reMark=value,
            numberOfLines: 2,
          ),
          CardSettingsHeader(label: '申请人信息',color: Colors.indigo[400]),
          CardSettingsText(
            key: _applyerKey,
            label: '申请人',
            requiredIndicator: Text('*',style: TextStyle(color: Colors.red)),
            autovalidate: _autovalidate,
            hintText: '申请人姓名，必填',
            validator: (value){
              if(value==null ||value.isEmpty) return '申请人不能为空';
              return null;
            },
            onChanged:  (value)=> _regTmInfo.applyName=value,
            onSaved: (value) => _regTmInfo.applyName=value,
          ),
          CardSettingsListPicker(
            key: _provinceKey,
            label: '省份',
            hintText: '请选择',
            requiredIndicator: Text('*',style: TextStyle(color: Colors.red)),
            autovalidate: _autovalidate,
            options: listProvince,
            validator: (value){
              if(value==null ||value.isEmpty) return '省份不能为空';
              return null;
            },
            onChanged: (value){ changeProinvce(value);_regTmInfo.province=value;},
            onSaved: (value) => _regTmInfo.province=value,
          ),
          CardSettingsListPicker(
            key: _cityKey,
            label: '城市',
            hintText: '请选择',
            requiredIndicator: Text('*',style: TextStyle(color: Colors.red)),
            autovalidate: _autovalidate,
            options: listCity,
            validator: (value){
              if(value==null ||value.isEmpty) return '城市不能为空';
              return null;
            },
            onChanged: (value){ changeCity(value);_regTmInfo.city=value;},
            onSaved: (value) => _regTmInfo.city=value,
          ),
          CardSettingsListPicker(
            key: _areaKey,
            label: '地区',
            hintText: '请选择',
            requiredIndicator: Text('*',style: TextStyle(color: Colors.red)),
            autovalidate: _autovalidate,
            options: listArea,
            validator: (value){
              if(value==null ||value.isEmpty) return '地区不能为空';
              return null;
            },
            onChanged: (value){ _regTmInfo.area=value;},
            onSaved: (value) => _regTmInfo.area=value,
          ),
          CardSettingsText(
            key: _addressKey,
            label: '地址',
            requiredIndicator: Text('*',style: TextStyle(color: Colors.red)),
            autovalidate: _autovalidate,
            hintText: '申请人地址，必填',
            validator: (value){
              if(value==null ||value.isEmpty) return '详细地址不能为空';
              return null;
            },
            onChanged: (value){ _regTmInfo.address=value;},
            onSaved: (value) => _regTmInfo.address=value,
          ),
          CardSettingsText(
            key: _mobileKey,
            label: '手机',
            requiredIndicator: Text('*',style: TextStyle(color: Colors.red)),
            autocorrect: _autovalidate,
            hintText: '手机号码，必填',
            validator: (value){
              if(value==null ||value.isEmpty) return '手机不能为空';
              if(value.length!=11) return '手机格式不正确';
              return null;
            },
            onChanged: (value){ _regTmInfo.mobile=value;},
            onSaved: (value) => _regTmInfo.mobile=value,
          ),
          CardSettingsHeader(label: '上传营业执照',color: Colors.indigo[400]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _imageFile==null?addImage():previewImage(),
              Container(
                margin: EdgeInsets.only(left: 50.0),
                child: Image.network('https://www.jbiao.cn/images/营业执照上传样图.jpg',width: 120.0,height: 150.0,))
            ],
          ),
          isSubmiting?
          new CircularProgressIndicator():
          CardSettingsButton(
            label: '提交申请',
            backgroundColor: Colors.lightBlueAccent[100],
            textColor: Colors.white,
            onPressed: (){_savePressed();},
          )
        ]);
  }
  //选择图片
  pickImage(BuildContext context) {
    setState(() {
     _imageFile =  ImagePicker.pickImage(source: ImageSource.gallery); 
    });
  }
  //上传按钮
  Widget addImage() {
    return
   GestureDetector(
                child: 
                Container(
                  margin: EdgeInsets.only(right: 50.0),
                  child: Image.asset('./images/ic_add_pics.png',width: 120.0,height: 150.0)
                ),
                onTap: (){pickImage(context);},
              );
  }
  //预览图片
  Widget previewImage() {
    return FutureBuilder<File>(
      future:_imageFile,
      builder: (BuildContext context,AsyncSnapshot<File> snapshot) {
        if(snapshot.connectionState ==ConnectionState.done && snapshot.data !=null) {
          _yyzzImage=snapshot.data;
          return 
          GestureDetector(
          child: 
            Container(
              margin: EdgeInsets.only(right: 50.0),
              child: Image.file(snapshot.data,fit:BoxFit.cover,width: 120.0,height: 150.0)
            ),
          onTap: (){pickImage(context);},             
          );
        }
        else 
        {
          return addImage();
        }
      }, 
    );
  }

  Widget getiForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('个体工商户')
      ]);
  }
  //提交表单
  Future _savePressed() async {
    var form = _qiyeFormKey.currentState;
    if(!form.validate()){
      setState(()=> _autovalidate=true);
    } else {
      //setState(()=>isSubmiting=true);
      var res = await TmDao.addRegTm(_regTmInfo, _yyzzImage);
      var result = json.decode(res.data);
      //setState(()=>isSubmiting=false);
      print(result);
      /*
      final snackBar = new SnackBar(content: new Text(result.Code==1?'提交成功':result.Data.toString()));
      Scaffold.of(context).showSnackBar(snackBar);
      */
    }
  }
  @override
  Widget build(BuildContext context) {    
    return new Scaffold(
      appBar: new AppBar(
        title: Text('商标注册'),
        /*
        bottom: new TabBar(
          tabs: <Widget>[
            new Tab(text: '企业单位'),
            new Tab(text: '个体工商户')
          ],
          controller: _tabController,
        ),
        */
      ),
      body:
        Form(
          key: _qiyeFormKey,
          child: qiyeForm(context),
        )
      /*
      new TabBarView(
        controller: _tabController,
        children: <Widget>[
           Center(child: qiyeForm()),
           Center(child: getiForm())
        ],
      ),*/
    );
  }
}