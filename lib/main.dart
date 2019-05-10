import 'package:flutter/material.dart';
import 'package:uitest/pages/detail.dart';
import 'package:uitest/pages/home.dart';
import 'package:uitest/pages/share.dart';
import 'package:uitest/pages/thread/list.dart';
import 'package:uitest/pages/thread/detail.dart';
import 'package:uitest/pages/thread/publish.dart';
import 'package:uitest/pages/typeSearch.dart';
import 'package:uitest/widgets/barOption.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:uitest/pages/types.dart';
import 'package:uitest/pages/groupes.dart';
import 'package:uitest/pages/regtm.dart';
import 'package:uitest/pages/drawer.dart';
import 'package:uitest/pages/father.dart';
import 'package:uitest/pages/listorder.dart';
import 'package:uitest/pages/chat.dart';
import 'package:uitest/pages/webview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(        
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      //home: TypesPage(),
      //home: ListOrderPage(),
      //home:DrawerPage()
      //home:ChatPage(),
      //home:ThreadDetailPage(),
      //home:ThreadList(),
      home:ThreadPublishPage(typeId:2,typeName:'成衣供求'),
      //home:SharePage(),
     // home:WebViewPage(title: '测试',url: 'https://www.22.cn'),
      //home:FatherPage(),
      //home: TypeSearchPage(),
      //home: GroupesPage()
      onGenerateRoute: (s){return _getRoute(s);},
      
      routes: <String,WidgetBuilder>{
        '/detail':(_)=>new DetailPage(),
        //'/': (_) => APage(), 
        '/page_b': (_) => BPage(), 
        '/page_c': (_) => CPage()
      },
      
    );
  }
}
Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == '/detail') {
        return _buildRoute(settings, new DetailPage(id:settings.arguments));
    }
    return null;
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
        settings: settings,
        builder: (ctx) => builder,
    );
}
/// Page A，Button 的跳转事件等会进行修改，目前先空着
class APage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page A'),
      ),
      body: Center(child: RaisedButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder:(_){return BPage(); }));
      }, child: Text('To Page B'))),
    );
  }
}

/// Page B
class BPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page B'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        RaisedButton(onPressed: () {
                  //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(_)=>CPage()), ModalRoute.withName('/page_b'));
                  Navigator.of(context).push(MaterialPageRoute(builder:(_)=>CPage()));
        }, child: Text('To Page C')),
        RaisedButton(onPressed: () {}, child: Text('Back Page A'))
      ])),
    );
  }
}

/// Page C
class CPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page C'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[RaisedButton(onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(_)=>DPage()), ModalRoute.withName('/page_b'));
              }, child: Text('To Page D'))])),
    );
  }  
}

/// Page D
class DPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page D'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[RaisedButton(onPressed: () {}, child: Text('Back Last Page'))])),
    );
  }  
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OptionControl optionControl = new OptionControl();
  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      fluwx.register(appId:"wxbdb66154033d3505");
      optionControl.url='https://m.jbiao.cn';
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,      
        automaticallyImplyLeading: true,
        title: Text('UI TEST'),
        actions: <Widget>[
          new BarOptionWidget(optionControl),
        ],
      ),
      body: new Center(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 40.0),
          height: 600.0,
          child: new Card(
            child: new Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                      new Container(
                          height: 20.0,
                          width: 50.0,
                          child: new RaisedButton( color: Colors.blue,
                          child: new Text("立即查看",style: TextStyle(fontSize: 10.0)),    
                          padding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),                      
                          /*
                          child: new Padding(
                            padding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
                            child: new Text("立即查看",style: TextStyle(fontSize: 10.0)),                          
                          ),
                          */
                          highlightColor: Colors.blue[700],
                          colorBrightness: Brightness.dark,
                          splashColor: Colors.grey,                        
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),                        
                          onPressed: () => {},
                          ),
                        ),
                  RaisedButton(                        
                          color: Colors.blue,
                          child: new Text("立即查看",style: TextStyle(fontSize: 10.0)),    
                          padding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),                      
                          /*
                          child: new Padding(
                            padding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
                            child: new Text("立即查看",style: TextStyle(fontSize: 10.0)),                          
                          ),
                          */
                          highlightColor: Colors.blue[700],
                          colorBrightness: Brightness.dark,
                          splashColor: Colors.grey,                        
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),                        
                          onPressed: () => {},
                        ),
                new Text('aaa'),
                new Text('bbb'),
                new FlatButton(
                  child: Text('click me'),
                  onPressed: (){
                    print('click');
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Home()));
                  },
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}


