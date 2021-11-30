import 'package:flutter/material.dart';
import 'package:flutter_blbl/utils/color.dart';
import 'package:flutter_blbl/utils/fontsize.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String> onChanged; //输入回调
  final ValueChanged<bool> focusChanged; //获取焦点回调
  final bool lineStretch; //底部的线是否占一行
  final bool obscureText; //是否是输入密码
  final TextInputType keyboardType;

  const LoginInput(this.title, this.hint,
      {Key key,
      this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType})
      : super(key: key); //输入框内容的类型，如：数字/字母

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  //输入框是否获取到光标
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //是否获取到光标
    _focusNode.addListener(() {
      print("wqs-是否获取到光标:" + _focusNode.hasFocus.toString());
      if (widget.focusChanged != null) {
        widget.focusChanged(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: fontSizeContent),
              ),
            ),
            _input()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
          //Divider底部线
          child: Divider(
            height: 1,
            //粗细
            thickness: 0.5,
          ),
        ),
      ],
    );
  }

  _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      cursorColor: primary,
      //是否自动获取焦点
      autofocus: !widget.obscureText,
      style: TextStyle(
          fontSize: fontSizeContent,
          color: Colors.black,
          fontWeight: FontWeight.w300),
      //输入框样式
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, right: 20),
          border: InputBorder.none,
          hintText: widget.hint ?? '',
          hintStyle: TextStyle(fontSize: fontSizeHint, color: Colors.grey)),
    ));
  }
}
