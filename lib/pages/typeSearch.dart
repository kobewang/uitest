import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:flutter_html_textview/flutter_html_textview.dart';
/// 商标类型搜索
///
/// auth:wyj date:201901331
class TypeSearchPage extends StatefulWidget {
  @override
  createState ()=> TypeSearchPageState();
}
class TypeSearchPageState extends State<TypeSearchPage> {
  String searchContent;
  final TextEditingController controller = new TextEditingController();
  ///搜索行
  Widget searchRow() {
    return new
      Container(
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        height: 50.0,
        child: new Card(
          color: Color.fromRGBO(243, 243, 243, 0.6),
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    autofocus: true,
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      border: InputBorder.none,
                      hintText: '输入关键字',
                      prefixIcon: new Icon(Icons.search,size:16.0,color:Colors.grey),
                    ),
                    onChanged: (String content){
                      setState(() {
                        searchContent=content;  
                      });
                    },
                    onSubmitted: (String content){},
                    controller: controller,
                  )                  
                ),
                searchContent==null ? new Container(height: 0.0,width: 0.0): new IconButton(
                  padding: EdgeInsets.all(0.0),
                  iconSize: 16.0,
                  icon: new Icon(Icons.close),
                  onPressed: (){
                    setState(() {
                     searchContent = '';
                     controller.text = ''; 
                    });
                  },
                )
              ],
            ),
          ),
        ),
      );
  }

  //列表行
  Widget listRow() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context,index) {
        //return Text('【0101】 012345687 的飞洒地方的飞洒发斯蒂芬发大水发斯蒂芬的说法是的范德萨');
        /*
        return new Container(
          color: Colors.grey[100],
          padding: EdgeInsets.all(5.0),
          child: 
          index==0? 
          Container(child: Text('第05类 化学化工'), color: Colors.white)
          :
          Container(child: 
            Text('【0101】 012345687 的飞洒地方的飞洒发斯蒂芬发大水发斯蒂芬的说法是的范德萨'),
          )
        );
        */
        return 
        Container(
          color:  Colors.white,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(5.0),
          child: 
        new Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: listDetail(index)
        )
        );
      },
    );
  }

   List<Widget> listDetail(index)  {
     List wigets = new List<Widget>();
     wigets.add(
       Container(
         color: Colors.white,
         width: MediaQuery.of(context).size.width,
         child: new Row(
          children: <Widget>[
            Container(child: 
              Text('第05类',style: TextStyle(color: Colors.blue[300])),
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.blue,width: 0.5),
                borderRadius: new BorderRadius.all(new Radius.circular(3.0))
              ),
             ),
            Container(child: Text('化学化工'),margin: EdgeInsets.only(left: 20.0),)
          ],
        )
       )   
    );
    for(int i=0;i <10; i++) {
       wigets.add( 
         new Row(
             children: <Widget>[
               Expanded(child: 
               Container(
                 //margin: EdgeInsets.only(top: 3.0),
                 //child: Text('【0101】 012345687 的飞洒地方的飞洒发斯蒂芬发大水发斯蒂芬的说法是的范德萨',maxLines: 3,overflow: TextOverflow.ellipsis,), 
                 //child: Html(data: '【0101】 012345687 的飞洒地方的飞洒发斯蒂芬<span color="#FF0000">化学化工</span>斯蒂芬的说法是的范德萨',),
                 child: new Text.rich(
          new TextSpan(
            text: '【0101】 012345687 的飞洒地方的飞洒发斯蒂芬',
            style: new TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              decoration: TextDecoration.none,
            ),
            children: <TextSpan>[
              new TextSpan(
                text: '化学化工',
                style: TextStyle(color: Colors.red)
              ),
         
              new TextSpan(
                text: '拼接3',
              ),
              new TextSpan(
                text: '拼接4',
              ),
              new TextSpan(
                text: '拼接5',
              ),
              new TextSpan(
                text: '拼接6',
              ),
            ])),
            
          
                 /*
                 child:new Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     Text('【0101】 012345687 的飞洒地方的飞洒发'),
                     Text('化学化工',style: TextStyle(color: Colors.red)),
                     Text('dfdsfdsfds的范德萨发'),
                   ],
                 ),
                 */
                 color: Colors.grey[200]
                 )
               )
            ]
       )
       );
    }
    return wigets;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 254, 1.0),
      appBar: new AppBar(
        title: Text('商标搜索')
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          searchRow(),
          Expanded(child: listRow())
        ],
      ) 
    );
  }
}