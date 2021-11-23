import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/model/main/common_model.dart';
import 'package:flutter_app_new/model/main/grid_nav_model.dart';
import 'package:flutter_app_new/widget/webview.dart';

///酒店机票旅游卡片入口
class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key? key, required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //PhysicalModel添加圆角
    return PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: _gridNavItems(context),
        ));
  }

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    //酒店
    items.add(_mainItem(context, gridNavItem.mainItem));
    //海外酒店，特价酒店
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    //团购，民宿
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));

    //水平排列充满布局
    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(
        child: item,
        flex: 1,
      ));
    });

    Color startColor = Color(int.parse('0xff' + gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff' + gridNavItem.endColor));
    return Container(
      height: 88,
      //不是第一个设置上边距
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //背景颜色线性渐变
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      //横向排列
      child: Row(
        children: expandItems,
      ),
    );
  }

  //酒店，机票，旅游
  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.network(
              model.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd, //图片在下面
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Text(
                model.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        ),
        model);
  }

  //上下2个小item
  _doubleItem(
      BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: [
        //垂直占满空间
        Expanded(child: _item(context, topItem, true)),
        Expanded(child: _item(context, bottomItem, false)),
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      //水平宽度充满布局
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          //左边白线
          left: borderSide,
          //底部白线，第一个设置，其它不设置
          bottom: first ? borderSide : BorderSide.none,
        )),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            item),
      ),
    );
  }

  //点击进入详情页
  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                    url: model.url,
                    // statusBarColor: model.statusBarColor,
                    title: model.title,
                    // hideAppBar: model.hideAppBar,
                    backForbid: false)));
      },
      child: widget,
    );
  }
}
