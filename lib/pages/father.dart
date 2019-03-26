import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uitest/model/tmsearchInfo.dart';
import 'package:uitest/pages/child.dart';
import 'package:uitest/pages/webview.dart';
import 'package:uitest/widgets/loadingIcon.dart';
class FatherPage extends StatefulWidget {
  @override
  createState()=> FatherPageState();
}
class  FatherPageState extends State<FatherPage> {
  var textStr='';
  TmSearchInfo searchInfo= new TmSearchInfo();
  void onDataChange(val) {
    setState(() {
      searchInfo=val;
    });
  }
  String inputText="dfdd";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return 
    Scaffold(
      appBar: AppBar(
        title: Text('测试'),
      ),
      body: Center(
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
      
          TextField(
              controller: TextEditingController.fromValue(TextEditingValue(
                  // 设置内容
                  text: inputText,
                  // 保持光标在最后
                  selection: TextSelection.fromPosition(TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: inputText.length)))),
         ),
          
          Text(searchInfo.tmNameKey==null?'':searchInfo.tmNameKey),
          Text(searchInfo.cbTypes==null?'':searchInfo.cbTypes),
          LoadingIcon(),
              new CupertinoActivityIndicator(),
          new ChildPage(callback:(val)=>onDataChange(val)),
          FlatButton(child: Text('route param'),onPressed: (){
            //Navigator.pushNamed(context, '/detail',arguments:22);
            //var a=5;
            //var b=6;
            //var c=a~/b;

            Map<String, Object> data={};
            data["timestamp"] = DateTime.now().millisecondsSinceEpoch ~/ 1000;
          }),
          FlatButton(
            child: Text('webview'), onPressed: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (ctx)=> new WebViewPage(title:'webview',url:'https://www8.22.cn')));
            },
          )
        ],
      )
    )
    );
    
  }
  
}