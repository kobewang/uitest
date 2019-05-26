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
      onLoading: () async {
        //上拉加载
        if (onPullUp != null) {
          await onPullUp();
          if (isNoMore) {
            _controller.loadNoData();
            return;
          }
        }
        _controller?.loadComplete();
      },
      onRefresh: () async {
          if (onPullDown != null) {
          bool completed = await onPullDown();
          if (!completed) {
            _controller?.refreshFailed();
            return;
          }
        }
        _controller?.refreshCompleted();
      },
      enablePullDown: onPullDown != null,
      enablePullUp: onPullUp != null,
      header: ClassicHeader(
        refreshingText: "加载中...",
        releaseText: "释放加载",
        completeText: "加载完成",
        idleText: "下拉加载",
        failedText: "加载失败",
        refreshingIcon: CupertinoActivityIndicator(),
        completeIcon: Icon(Icons.arrow_upward),
        releaseIcon: Icon(Icons.arrow_upward),
        idleIcon: Icon(
            Icons.arrow_downward,
            color: Colors.grey,
          ),
      ),
      footer: ClassicFooter(
        idleIcon: Icon(
          Icons.arrow_upward,
          color: Colors.grey,
        ),
        loadingText: "正在努力加载...",
        idleText: "上拉加载更多",
        loadingIcon: CupertinoActivityIndicator(),
        noDataText: '我是有底线的',
        noMoreIcon: Container(),
      ),
      child: scrollViewChild,
    )
      ;
  }
}
