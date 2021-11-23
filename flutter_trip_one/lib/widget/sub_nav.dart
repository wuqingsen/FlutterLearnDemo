import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/model/main/common_model.dart';
import 'package:flutter_app_new/widget/webview.dart';

///十个小按钮入口
class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({Key? key, required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6), //设置圆角
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((model) {
      items.add(_item(context, model));
    });
    //计算第一行显示数量
    int separate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: [
        //第一行
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //sublist取0-separate的数据
          children: items.sublist(0, separate),
        ),
        //第二行
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, subNavList.length),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    //设置权重，让其平分大小
    return Expanded(
      flex: 1,
      child: GestureDetector(
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
                  builder: (context) => WebView(
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
              width: 17,
              height: 17,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                model.title,
                style: TextStyle(fontSize: 10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
