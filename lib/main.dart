import 'package:flutter/material.dart';
import 'package:uitest/pages/detail.dart';
import 'package:uitest/pages/home.dart';
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
      home:ChatPage(),
     // home:WebViewPage(title: '测试',url: 'https://www.22.cn'),
      //home:FatherPage(),
      //home: TypeSearchPage(),
      //home: GroupesPage()
      onGenerateRoute: (s){return _getRoute(s);},
      /*
      routes: <String,WidgetBuilder>{
        '/detail':(_)=>new DetailPage()
      },
      */
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

