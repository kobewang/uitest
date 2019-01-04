import 'package:flutter/material.dart';
import 'package:uitest/pages/home.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,      
        automaticallyImplyLeading: true,
        title: Text('UI TEST'),
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
