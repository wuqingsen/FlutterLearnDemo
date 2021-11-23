import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const MyWebView({
    required this.url,
    required this.statusBarColor,
    required this.title,
    required this.hideAppBar,
    required this.backForbid,
  });

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor;
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: _appBar(
              Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
        ),
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onProgress: (int progress) {
                  print("WebView is loading (progress : $progress%)");
                },
                javascriptChannels: <JavascriptChannel>{
                  _toasterJavascriptChannel(context),
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith(widget.url)) {
                    print('blocking navigation to $request}');
                    return NavigationDecision.prevent;
                  }
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                },
                gestureNavigationEnabled: true,
              );
            }, // ],
          ),
        ));
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    // return AppBar(
    //   title: Text(widget.title),
    //   backgroundColor: backgroundColor,
    // );
    return Container(
      //撑满屏幕宽度
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            // GestureDetector(
            //   child: Container(
            //     margin: EdgeInsets.only(left: 10),
            //     child: Icon(
            //       Icons.close,
            //       color: backButtonColor,
            //       size: 26,
            //     ),
            //   ),
            // ),
            Positioned(
              // left: 0,
              // right: 0,
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
