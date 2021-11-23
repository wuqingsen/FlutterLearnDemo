import 'package:flutter/material.dart';
import 'package:flutter_app_new/widget/webview.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() {
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        url: "https://m.ctrip.com/webapp/myctrip/",
        title: "我的",
      ),
    );
  }
}
