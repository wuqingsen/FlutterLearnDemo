import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/model/main/common_model.dart';
import 'package:flutter_app_new/model/main/sales_box_model.dart';
import 'package:flutter_app_new/widget/webview.dart';

///底部卡片入口
class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBox;

  const SalesBox({Key? key, required this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if (salesBox == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(
        context, salesBox.bigCard1, salesBox.bigCard2, true, false));
    items.add(_doubleItem(
        context, salesBox.smallCard1, salesBox.smallCard2, false, false));
    items.add(_doubleItem(
        context, salesBox.smallCard3, salesBox.smallCard4, false, true));

    return Column(
      children: [
        Container(
          height: 44,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.red))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                salesBox.icon,
                height: 15,
                fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        //设置渐变
                        colors: [Color(0xffff4e63), Color(0xffff6cc9)],
                        //渐变从左边开始
                        begin: Alignment.centerLeft,
                        //右边结束
                        end: Alignment.centerRight)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebView(
                                url: salesBox.url,
                                // statusBarColor: model.statusBarColor,
                                title: '更多活动',
                                // hideAppBar: model.hideAppBar,
                                backForbid: false)));
                  },
                  child: Text(
                    '获取更多福利 >',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        )
      ],
    );
  }

  //isBig是否为大卡片，isLast是否为最后一个卡片
  _doubleItem(BuildContext context, CommonModel leftCard, CommonModel rightCard,
      bool isBig, bool isLast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _item(context, leftCard, isBig, true, isLast),
        _item(context, rightCard, isBig, false, isLast),
      ],
    );
  }

  //left是否在左侧，，isLast是否为最后一个卡片
  Widget _item(BuildContext context, CommonModel model, bool big, bool left,
      bool isLast) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfff2f2f2));
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
                builder: (context) => WebView(
                    url: model.url,
                    // statusBarColor: model.statusBarColor,
                    title: model.title,
                    // hideAppBar: model.hideAppBar,
                    backForbid: false)));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                right: left ? borderSide : BorderSide.none,
                bottom: isLast ? BorderSide.none : borderSide)),
        child: Image.network(
          model.icon,
          fit: BoxFit.fill,
          //获取屏幕宽度
          width: MediaQuery.of(context).size.width / 2 - 10,
          //大图显示129，小图显示80
          height: big ? 129 : 80,
        ),
      ),
    );
  }
}
