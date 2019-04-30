import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// auth:yyb
/// desc:刷新列表组件
///
class RefreshList extends StatelessWidget {
  final ScrollView scrollViewChild;
  final bool isNoMore;
  final Future<bool> Function() onPullUp;
  final Future<bool> Function() onPullDown;
  final RefreshController controller;
  const RefreshList(
      {Key key,
      this.isNoMore: false,
      this.onPullUp,
      this.onPullDown,
      this.controller,
      this.scrollViewChild})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _controller = controller ?? new RefreshController();
    return SmartRefresher(
      controller: _controller,
      onRefresh: (up) async {
        bool completed = true;
        RefreshStatus mode;
        if (!up && onPullUp != null) {
          completed = await onPullUp();
          mode = completed ? RefreshStatus.completed : RefreshStatus.failed;
          if (isNoMore) {
            _controller?.sendBack(false, RefreshStatus.idle);
          }
        }
         if (up && onPullDown != null) {
          //print("onPullDown");
          completed = await onPullDown();
          mode = completed ? RefreshStatus.completed : RefreshStatus.failed;
          if (isNoMore) {
            _controller?.sendBack(false, RefreshStatus.idle);
          }
        }
        _controller?.sendBack(up, mode);
      },
      enablePullDown: onPullDown != null,
      enablePullUp: onPullUp != null,
      headerConfig: RefreshConfig(),
      headerBuilder: (context, mode) {
        return ClassicIndicator(
          idleIcon: Icon(
            Icons.arrow_downward,
            color: Colors.grey,
          ),
          releaseIcon: Icon(
            Icons.arrow_upward,
            color:Colors.grey
          ),
          mode: mode,
          refreshingText: "正在努力加载..",
          releaseText: "释放加载更多",
          completeText: "加载完成",
          idleText: "上拉加载更多",
          failedText: "加载失败",
          refreshingIcon: CupertinoActivityIndicator(),
          noDataText: '我是有底线的',
          noMoreIcon: Container(),
        );
      },
      footerConfig: RefreshConfig(),
      footerBuilder: (context,mode){
         return ClassicIndicator(
          idleIcon: Icon(
            Icons.arrow_upward,
            color: Colors.grey,
          ),
          releaseIcon: Icon(
            Icons.arrow_downward,
            color: Colors.grey,
          ),
          mode: mode,
          refreshingText: "正在努力加载...",
          releaseText: "释放加载更多",
          completeText: "加载完成",
          idleText: "上拉加载更多",
          failedText: "加载失败",
          refreshingIcon: CupertinoActivityIndicator(),
          noDataText: '我是有底线的',
          noMoreIcon: Container(),
        );
      },
      child: scrollViewChild,
    );
  }
}
