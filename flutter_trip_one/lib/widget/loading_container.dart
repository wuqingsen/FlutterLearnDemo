import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child; //内容
  final bool isLoading; //状态：是否展示加载框
  final bool cover; //是否覆盖整个页面

  const LoadingContainer(
      {Key? key,
      required this.isLoading,
      this.cover = false,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !isLoading
            ? child
            : _loadingView()
        : Stack(
            children: [child, isLoading ? _loadingView() : null],
          );
  }

  _loadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
