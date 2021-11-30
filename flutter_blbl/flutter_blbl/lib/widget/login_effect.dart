import 'package:flutter/material.dart';

/**
 * 睁眼和闭眼，protect=true 闭眼，否则睁眼
 */
class LoginEffect extends StatefulWidget {
  final bool protect;

  const LoginEffect({Key key, @required this.protect}) : super(key: key);

  @override
  _LoginEffectState createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(bottom: BorderSide(color: Colors.grey[300])),
      ),
      child: Row(
        //排列方式,spaceBetween:三个会两端显示，第二个显示到中间
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          Image(height: 90, width: 90, image: AssetImage('images/logo.png')),
          _image(false),
        ],
      ),
    );
  }

  _image(bool left) {
    var headLeft = widget.protect
        ? 'images/head_left_protect.png'
        : 'images/head_left.png';
    var headRight = widget.protect
        ? 'images/head_right_protect.png'
        : 'images/head_right.png';
    return Image(height: 90, image: AssetImage(left ? headLeft : headRight));
  }
}
