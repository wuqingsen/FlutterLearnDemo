import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blbl/utils/fontsize.dart';

/**
 * 标题，右侧标题，右侧点击回调
 */
appBar(String title, String rightTitle, VoidCallback rightButtonClick) {
  return AppBar(
    //标题不居中
    centerTitle: false,
    //标题边距
    titleSpacing: 0,
    leading: BackButton(),
    title: Text(
      title,
      style: TextStyle(fontSize: fontSizeTitle),
    ),
    actions: [
      //右侧按钮点击事件和样式
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(
              fontSize: fontSizeTitle,
              color: Colors.grey[500],
            ),
            //文字居中显示
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}
