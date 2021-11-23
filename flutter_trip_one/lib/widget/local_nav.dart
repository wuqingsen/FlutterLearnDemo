import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/model/main/common_model.dart';
import 'package:flutter_app_new/widget/webview.dart';

///顶部五个按钮入口
class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNav({Key? key, required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)), //设置圆角
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((model) {
      items.add(_item(context, model));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      //点击进入WebView
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              // builder: (context) => MyWebView(
              //     url: model.url,
              //     statusBarColor: model.statusBarColor,
              //     title: model.title,
              //     hideAppBar: model.hideAppBar,
              //     backForbid: false)));
                builder: (context) =>
                    WebView(
                        url: model.url,
                        // statusBarColor: model.statusBarColor,
                        title: model.title,
                        // hideAppBar: model.hideAppBar,
                        backForbid: false)));
      },
      child: Column(
        children: [
          Image.network(
            model.icon,
            width: 32,
            height: 32,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
