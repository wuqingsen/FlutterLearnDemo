import 'package:flutter/material.dart';
import 'package:flutter_blbl/utils/color.dart';
import 'package:flutter_blbl/utils/fontsize.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable; //是否可以点击
  final VoidCallback onPressed; //点击回调

  const LoginButton(this.title, {Key key, this.enable = true, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("---" + enable.toString());
    //填满宽度
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        height: 45,
        onPressed: enable ? onPressed : null,
        disabledColor: primary[50],
        color: primary,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: fontSizeTitle),
        ),
      ),
    );
  }
}
