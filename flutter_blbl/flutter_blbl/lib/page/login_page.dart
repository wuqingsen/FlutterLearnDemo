import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blbl/utils/string_util.dart';
import 'package:flutter_blbl/utils/toast.dart';
import 'package:flutter_blbl/widget/appbar.dart';
import 'package:flutter_blbl/widget/login_button.dart';
import 'package:flutter_blbl/widget/login_effect.dart';
import 'package:flutter_blbl/widget/login_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;

  //注册按钮是否可以点击
  bool loginEnable = false;
  String userName;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('密码登录', '注册', () {}),
      body: Container(
        child: ListView(children: [
          LoginEffect(protect: protect),
          LoginInput(
            "用户名",
            '请输入用户名',
            onChanged: (text) {
              userName = text;
              checkInput();
            },
          ),
          LoginInput(
            "密码",
            '请输入密码',
            obscureText: true,
            onChanged: (text) {
              password = text;
              checkInput();
            },
            focusChanged: (focus) {
              this.setState(() {
                protect = focus;
              });
            },
          ),
          //注册按钮
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: LoginButton(
              '登录',
              enable: loginEnable,
              onPressed: _login,
            ),
          ),
        ]),
      ),
    );
  }

  //控制注册按钮是否可以点击
  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      print("设置loginEnable" + loginEnable.toString());
      loginEnable = enable;
    });
  }

  //登录
  _login() {
    BmobUser bmobUserRegister = BmobUser();
    bmobUserRegister.username = userName;
    bmobUserRegister.password = password;
    bmobUserRegister.login().then((BmobUser bmobUser) {
      showToast('登录成功');
    }).catchError((e) {
      showToast('登录失败' + BmobError.convert(e).error);
    });
  }
}
