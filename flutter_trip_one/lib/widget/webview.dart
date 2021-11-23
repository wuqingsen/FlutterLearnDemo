import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebView extends StatefulWidget {
  final String url;

  // final String statusBarColor;
  final String title;
  final bool backForbid;

  const WebView({
    required this.url,
    // required this.statusBarColor,
    required this.title,
    this.backForbid = false,
  });

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webViewReference = FlutterWebviewPlugin();
  late StreamSubscription<String> _onUrlChange;
  late StreamSubscription<WebViewStateChanged> _onStateChanged;
  late StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    webViewReference.close(); //防止重新打开
    //页面发生变化监听
    _onUrlChange = webViewReference.onUrlChanged.listen((String url) {});
    //状态发生变化
    _onStateChanged =
        webViewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          //防止webview返回到上一个页面
          if (_isToMain(state.url) && !exiting) {
            if (widget.backForbid) {
              //重新加载页面
              webViewReference.launch(widget.url);
            } else {
              //返回到上一页
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
    //错误
    _onHttpError =
        webViewReference.onHttpError.listen((WebViewHttpError error) {
      print("webView加载错误: " + error.toString());
    });
  }

  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url.endsWith(value)) {
        contain = true;
        break;
      }
      // if (url?.endsWith(value) ?? false) {
      //   contain = true;
      //   break;
      // }
    }
    return contain;
  }

  @override
  void dispose() {
    _onUrlChange.cancel(); //监听取消
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webViewReference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar(Colors.blue, Colors.white),
          Expanded(
              //全屏
              child: WebviewScaffold(
            url: widget.url,
            //缩放
            withZoom: true,
            //本地存储
            withLocalStorage: true,
            //没完全加载出来之前可以隐藏
            hidden: true,
            //未加载完显示加载中
            initialChild: Container(
              color: Colors.white,
              child: Center(child: Text('加载中...')),
            ),
          ))
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    // return Container(
    //   color: backgroundColor,
    //   height: 30,
    // );
    return Container(
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      color: Colors.blue,
      //撑满屏幕宽度
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(color: backButtonColor, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
