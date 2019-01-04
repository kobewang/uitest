import 'package:flutter/material.dart';
class List extends StatefulWidget {
  @override
  ListState createState() => ListState();
}
class ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    return
     new ClipOval(
      child: new SizedBox(
        width: 100.0,
        height:100.0,
        child:  new Image.network("https://sfault-ava",fit: BoxFit.fill,),
      ),
    );
    return       
    new CircleAvatar(
      backgroundImage: new NetworkImage(''),
    );
  }
}