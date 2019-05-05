import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

/// auth:wyj
/// desc:图片相册
/// date:20190505

class GalleryPage extends StatefulWidget {
  List<String> galleryList;
  int initialIndex;
  GalleryPage({Key key, this.galleryList, this.initialIndex}) : super(key: key);
  @override
  createState() => GalleryPageState();
}

class GalleryPageState extends State<GalleryPage> {
  int currentIndex;
  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          constraints:
              BoxConstraints.expand(height: MediaQuery.of(context).size.height),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions.customChild(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();//单击关闭图片
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Image.network(widget.galleryList[index]
                                  .replaceAll('-thumb', '')),
                            )),
                        childSize: Size(MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height),
                        initialScale: PhotoViewComputedScale.contained,
                        heroTag: index.toString());
                  },
                  onPageChanged: onPageChanged,
                  itemCount: widget.galleryList.length),
              Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      '${currentIndex + 1}/${widget.galleryList.length}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          decoration: null)))
            ],
          )),
    );
  }
}
