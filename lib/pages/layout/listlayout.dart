import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uitest/config/constants.dart';
import 'package:uitest/pages/layout/loadFailedOrNo.dart';
import 'package:uitest/pages/layout/refreshlist.dart';

/// auth:yyb
/// desc:列表布局
/// date:
class ListLayout extends StatefulWidget {
  ///刷新
  final Future<List> Function() refresh;
  ///上拉加载
  final Future<List> Function() more;
  ///构建内容
  final ScrollView Function(BuildContext context,List data) builder;
  ///是否加载失败
  final bool loadFailded;
  ///控制器
  final RefreshController controller;
  ///是否显示更多
  final bool noMore;
  ///每页显示数量
  final int limit;
  final ScrollView nullView;
  const ListLayout({
    Key key,
    this.refresh,
    this.more,
    @required this.builder,
    this.loadFailded:false,
    this.controller,
    this.noMore:false,
    this.limit:Constants.PAGE_SIZE,
    this.nullView
  }):super(key:key);

  @override
  createState()=> ListLayoutState();
}
class ListLayoutState extends State<ListLayout> {
  List _data;  
  var _firstLoad = true;
  var _hidderPullUp = false;
  RefreshController _controller;
  @override
  void initState() {
    _controller = widget.controller??new RefreshController();
    if(_firstLoad){
      //延迟加载刷新
      if(widget.refresh!=null) {
        _onPullDown();
      }else  {
        setState(() {
         _firstLoad=false; 
        });
      }
    }
    super.initState();
  }


  ///下拉
  Future<bool> _onPullDown() async {
    var data = await widget.refresh();
    _data =data ??[];
    _firstLoad = false;
    _hidderPullUp = false;
    //data<limit 不显示上拉
    if(widget.limit>0&&(data==null||data.length<widget.limit)){
      _hidderPullUp=true;//隐藏上拉
    } 
    setState((){});
    return true;
  }

  ///上拉
  Future<bool> _onPullUp() async {
    var  moreData = await widget.more();
    _firstLoad=false;
    if(moreData!=null) {
      _data= _data??[];
      _data.addAll(moreData);
    }
        //data<limit 不显示上拉
    if(widget.limit>0&&(moreData==null||moreData.length<widget.limit)){
      _hidderPullUp=true;//隐藏上拉
    } 
    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return _firstLoad?
    Center(child: Text('加载中')):
    RefreshList(
      isNoMore: widget.noMore,
      controller: _controller,
      onPullDown: widget.refresh==null?null:_onPullDown,
      onPullUp: (widget.more==null||
      _data==null ||
      _data.length == 0 ||
      _hidderPullUp)?null:_onPullUp
      ,
      scrollViewChild: _buildList(_controller),
    );
  }

  ScrollView _buildList (RefreshController contrller) {
    //初始加载
    if(_firstLoad) {
      return ListView(children: <Widget>[Container()]);
    }
    //失败加载
    if(widget.loadFailded) {
      return ListView(children: <Widget>[
        LoadFailedOrNo(
          isFailed: true,
          padding:EdgeInsets.only(top: 180),
          onReload:(){
            setState(() {
             _firstLoad=true; 
            });
            _onPullDown();
          }
        )
      ]);
    }
    //内容空
    if(_data == null || _data.length ==0 ) {
      if(widget.nullView!= null){
        return widget.nullView;
      }
      return ListView(children: <Widget>[
        LoadFailedOrNo(
          isFailed: false,
          padding:EdgeInsets.only(top: 180)
        )
      ]);
    }
    return widget.builder(context,_data);
  }
}
