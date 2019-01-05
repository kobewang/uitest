import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_vertical_marquee/flutter_vertical_marquee.dart';
class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  var marqueeController = MarqueeController();
  List staticsList = [
    {
      'title':'总浏览量',
      'num':'26.4w',
      'color':0xFFFFA500
    },
    {
      'title':'总发布量',
      'num':'26.4w',
      'color':0xFFDB7093
    },
    {
      'title':'总入驻量',
      'num':'26.4w',
      'color':0xFF87CEEB
    },
  ];
  List bannerList = [
    {
    'img':'https://upimg.22.cn/show//ad/20180823/0-20180823163529550.jpg',
    'url':'https://www.22.cn'
    },
    {
    'img':'https://www.22.cn/UserFiles2014/image/zixun/20181010vip_am.jpg',
    'url':'https://www.22.cn'
    },
    {
    'img':'https://yun.22.cn/Yun2016/img/banner350.jpg',
    'url':'https://www.22.cn'
    },
  ];
  List tabNavList = [
    {
      'img':'https://github.com/luhenchang/flutter_study/blob/master/images/longnv5.jpeg?raw=true',
      'name':'域名',
      'path':''
    },
    {
      'img':'https://img.yms.cn/tabicon/设计师.png',
      'name':'商标',
      'path':''
    },
    {
      'img':'https://img.yms.cn/tabicon/制作加工.png',
      'name':'专利',
      'path':''
    },
    {
      'img':'https://img.yms.cn/tabicon/染色.png',
      'name':'抢注',
      'path':''
    }
    ,
    {
      'img':'https://img.yms.cn/tabicon/店铺.png',
      'name':'拍卖',
      'path':''
    },
    {
      'img':'https://img.yms.cn/tabicon/店铺.png',
      'name':'拍卖',
      'path':''
    },
    {
      'img':'https://img.yms.cn/tabicon/店铺.png',
      'name':'拍卖',
      'path':''
    },
    {
      'img':'https://img.yms.cn/tabicon/店铺.png',
      'name':'拍卖',
      'path':''
    }
  ] ;
  List<String> marqueeList= ['跑马灯dddd的范德萨范德萨放多少范德萨范德萨范德萨范德萨范德萨发','1月域名促销，注册首年11元起','.com/.cn/.中国/.公司/.网络促销活动结束的通知'];
  @override
    void initState() {      
      super.initState();      
    }

  //列表Item
  Widget listItem(BuildContext context, int index) {
    //作者行
    var authorRow =new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Expanded( //拨打电话按钮之外的尽量填充
          child: 
          new Row(            
            children: <Widget>[
              new Column(                
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: CircleAvatar(backgroundImage: new NetworkImage('https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIbPCemL4J1E6m0ibfsSu36sCWO1ZjmEsAN4Q4jEvaOUkOX7ULahkPETicRr73fiawdiaxDmvQ63t9SOg/0')),
                  )
                  
                ],
              ),
              new Column(                
                crossAxisAlignment: CrossAxisAlignment.start, //纵向靠左对齐             
                children: <Widget>[
                  //昵称行
                  new Container(
                    margin: new EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: new Text('上善若水',style:new TextStyle(color:Color(0xFF1eabf0)))
                  ),
                  //标签行
                  new Container(
                    margin: new EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child:
                      new Row(
                        children: <Widget>[
                          new Container(
                            margin: new EdgeInsets.fromLTRB(0.0, 3.0, 6.0, 3.0),
                            color: Color(0xFF18dba6),
                            child: new Text('出售机器',style: new TextStyle(color: Colors.white,fontSize: 12.0)),
                          ),
                          new Container(
                            margin: new EdgeInsets.fromLTRB(0.0, 3.0, 6.0, 3.0),
                            color: Color(0xFF18dba6),
                            child: new Text('出租转让',style: new TextStyle(color: Colors.white,fontSize: 12.0)),
                          )                        
                        ],
                      )
                  )
                ],
              )
              
            ],
          ),                  
        ), 
        //拨打电话靠右 
        new ClipRRect(
          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),          
          child:         
            new Container(
            color: Color(0xFFed414a), 
            height: 25.0,
            //margin: EdgeInsets.fromLTRB(0.0, 0.0, 3.0, 0.0), 
            padding: EdgeInsets.all(2.0),        
            child:
            new Row(
              children: <Widget>[
                new Icon(Icons.phone,color: Colors.white),
                new Text('立即拨打',style: new TextStyle(color:Colors.white))
              ],
            )           
          ),
        )
    
        
      ],
    );
    var contentRow = new Row(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(5.0),
          height: 80.0,
          width: MediaQuery.of(context).size.width-10,
          child: new Text('提供了多种按钮Widget如RaisedButton、FlatButton、OutlineButton等，它们都是直接或间接对RawMaterialButton的包装定制，所以他们大多数属性都和RawMaterialButton一样。在介绍各个按钮时我们先介绍其默认外观，而按钮的外观大都可以通过属性来自定义，我们在后面统一介绍这些属性。另外，所有Material 库中的按钮都有如下相同点',maxLines: 3,overflow: TextOverflow.ellipsis),
        )
        
      ],
    );
    var picsRow = new Row(
      children: <Widget>[        
        new Container(
          color: Colors.white,
          height: 300.0,          
          width: MediaQuery.of(context).size.width-10,
          child:                                      
            new GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0
              ), 
              itemCount: 6,
              padding: const EdgeInsets.all(3.0),
              itemBuilder: (BuildContext context,int index){
                return picGridItem(context,index);
              }
            )    
                      
        )
      ],
    );
    var timeRow = new Row(children: <Widget>[
      Text('1小时前发布',style: TextStyle(color: Colors.grey,fontSize: 11.0))
    ]);
    var addressRow = new Row(
      children: <Widget>[
        new Icon(Icons.location_on,color: Colors.redAccent,size: 14.0,),
        Text('杭州市紫霞街互联网创新创业园',style: TextStyle(color: Colors.blue,fontSize: 12.0),)
      ],
    );
    var likeRow = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.comment,color: Colors.grey,size: 16.0),
            Text('32',style: TextStyle(color: Colors.grey))
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.thumb_up,color: Colors.grey,size: 16.0),
            Text('32',style: TextStyle(color: Colors.grey))
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.share,color: Colors.grey,size: 16.0),
            Text('32',style: TextStyle(color: Colors.grey))
          ],
        )    
      ],
    );
    return new Container(
      color: Colors.white,
      //height: 500.0,
      padding: new EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 5.0),
      child: new Column(
        children: <Widget>[
          homeSliver(),
          authorRow,
          listItemSliver(),
          contentRow,
          listItemSliver(),
          picsRow,
          listItemSliver(),
          timeRow,
          addressRow,
          listItemSliver(),
          likeRow,
        ],
      ),
    );
  }
  //九宫图item
  Widget picGridItem(BuildContext context, int index) {
    return new Container(
      child: 
      new ClipRRect(
        borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
        //borderRadius: new BorderRadius.circular(50.0),
        child: new Image.network('http://img.yms.cn/UpLoad/Thread/20191/5/7578_201901051001195616.jpg',width: 100.0,height: 100.0,),
        //child: new Image.network('http://img.yms.cn/ad/ad_banner_mahai.jpg')
      )      
    );
  }
  //图标navItem
  gridItem(BuildContext context,int index) {
     return GestureDetector(                               
      onTap: (){},
      child: new Container(                                  
        color: Colors.white,
        child: new Column(                                                                        
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[                                                                            
            new ClipOval(
              //原形裁剪
              child: new SizedBox(
                width: 40.0,
                height: 40.0,
                child: new Image.network(tabNavList[index]['img'],fit:BoxFit.fill),                                          
                )
            ),                                      
            new Text(tabNavList[index]['name'],style: TextStyle(color: Color(0xFF757575),fontSize: 13.0,fontWeight: FontWeight.bold))                                      
          ],
        ),
        margin: new EdgeInsets.only(left: 15.0,right: 15.0),
      ),
    );
  }
  //统计Widgets
  staticsWidgets() {
    List<Widget> listWidgets=new List<Widget>();
    for(var i = 0; i < staticsList.length; i++){
      listWidgets.add(
      new Column(                                                          
        children: <Widget>[                        
              new Row(
                children: <Widget>[
                  new Text(staticsList[i]['title']+':'),
                  new Text(staticsList[i]['num'], style: TextStyle(color:Color(staticsList[i]['color'])))
                ],
              )                                                              
        ],
      ));    
    }
    return listWidgets;
  }
  //首页分割
  homeSliver() {    
    return  new Container(
        width: MediaQuery.of(context).size.width,
        height: 5.0,
        color: Colors.white,
        child: new Container(color: Colors.black12),        
      );    
  }
  //listItem分割
  Widget listItemSliver() {
    return  new Container(
        width: MediaQuery.of(context).size.width,
        height: 1.0,
        color: Colors.white,
        child: new Container(color: Colors.black12),        
      );    
  }
  //跑马灯ADItem
  marqueeAdItem() {
    return new Expanded(
      child:new Container(
        padding: new EdgeInsets.all(5.0), 
        child:new ClipRRect(
          borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
          child: new Image.network('http://img.yms.cn/ad/ad_banner_mahai.jpg')
          )
      )
    );
  }
  //跑马灯widgets
  marqueeWidgets() {
    List<Widget> listWidget=new List<Widget>();
    listWidget.add(new Icon(Icons.speaker,color: Colors.red));
    listWidget.add(
      new Expanded(
      child:new GestureDetector(
        child: Container(                                                                        
        child: Marquee(
          textList: marqueeList,                                       
          fontSize: 14.0, // text size
          scrollDuration: Duration(seconds: 1), // every scroll duration
          stopDuration: Duration(seconds: 3), //every stop duration
          tapToNext: false, // tap to next
          textColor: Colors.red, // text color
          controller: marqueeController, // the controller can get the position
        ),
      ),
      onTap: () {
        print(marqueeController.position); // get the position
      })
      )
    );
    return listWidget;
  }
  @override
  Widget build(BuildContext context) {            
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        automaticallyImplyLeading: false, //是否带返回leading箭头
      ) ,
      body:  new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, //头部折叠
        children: <Widget>[
          new Expanded(
            child: new Container(
              child:new GestureDetector(
                  onTap: (){},
                  child: new ListView(
                    physics: AlwaysScrollableScrollPhysics(),//保持ListView任何情况都能滚动
                    padding: new EdgeInsets.all(1.0),
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      new SizedBox(                        
                        height: 150.0,
                        //flutter_swiper
                        child: new Swiper(
                          itemBuilder: (BuildContext context, int index) {                            
                            return new Image.network(bannerList[index]['img'],fit: BoxFit.fill,);
                          },
                          pagination: new SwiperPagination(),
                          control: new SwiperControl(), 
                          itemCount: 3,
                        ),
                      ),
                      new Container(
                        color: Colors.white,
                        height: 20,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: staticsWidgets()
                          
                        ),
                      ),
                                     
                      homeSliver(),                          
                      //grid tab导航
                      new SizedBox(                        
                        height: 100.0,
                        child: Container(
                          color: Colors.white,
                          child: new ListView.builder(
                            itemCount: tabNavList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {                              
                              return gridItem(context, index);
                            },
                          ),
                        ),
                      ),                                            
                      homeSliver(),                                                           
                      new Container(
                        color: Colors.white,
                        height: 180,
                        width: MediaQuery.of(context).size.width,                                                                        
                        child: new GridView.builder(
                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 11.0,
                            mainAxisSpacing: 11.0
                            //childAspectRatio: 2.0 //宽高比
                          ),
                          //primary: false,
                          itemCount: tabNavList.length,                          
                          padding: const EdgeInsets.all(10.0),
                          itemBuilder: (BuildContext context,int index) {                                                        
                            return gridItem(context,index);                            
                          },                          
                        ),
                      ),                                           
                      homeSliver(),
                      new Container(
                        color: Colors.white,
                        height: 120.0,
                        width: MediaQuery.of(context).size.width,
                        child:
                        new Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 20.0,
                              child:new Row(                              
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:marqueeWidgets()
                              ),
                            ),                            
                            Expanded(                                                         
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,                                                                
                                children: <Widget>[                                  
                                  marqueeAdItem(),
                                  marqueeAdItem()
                                ],
                              )

                            )
                          ],
                        )                         
                      ),  
                       homeSliver(),                      
                      //listitem列表展示                                        
                      new SizedBox(    
                        height: 3000.0,
                        width: MediaQuery.of(context).size.width,                      
                        child:new Container(
                          color: Colors.white,
                          child: 
                          //new Text('dd')
                          
                          new ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {                              
                              //return new Text('ddd');
                              return listItem(context,index);                              
                            },
                          )
                          
                        )
                      )
                                                                
                    ],
                  )
              )
            ),
          )
        ],
      ),
      );
  }
}