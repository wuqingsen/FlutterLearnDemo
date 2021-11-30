import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blbl/utils/string_util.dart';
import 'package:flutter_blbl/utils/toast.dart';
import 'package:flutter_blbl/widget/appbar.dart';
import 'package:flutter_blbl/widget/login_button.dart';
import 'package:flutter_blbl/widget/login_effect.dart';
import 'package:flutter_blbl/widget/login_input.dart';
import 'package:permission_handler/permission_handler.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback onJumpToLogin;

  const RegistrationPage({Key key, this.onJumpToLogin}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;

  //注册按钮是否可以点击
  bool loginEnable = false;
  String userName;
  String password;
  String rePassword;

  @override
  void initState() {
    setPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        widget.onJumpToLogin;
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              "用户名",
              "请输入用户名",
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focusChanged) {
                this.setState(() {
                  protect = focusChanged;
                });
              },
            ),
            LoginInput(
              "确认密码",
              "请再次输入密码",
              obscureText: true,
              onChanged: (text) {
                rePassword = text;
                checkInput();
              },
              focusChanged: (focusChanged) {
                this.setState(() {
                  protect = focusChanged;
                });
              },
            ),
            //注册按钮
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton(
                '注册',
                enable: loginEnable,
                onPressed: _register,
              ),
            )
          ],
        ),
      ),
    );
  }

  //控制注册按钮是否可以点击
  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  ///用户名密码注册
  _register() {
    if (password != rePassword) {
      showToast('两次密码不一致');
      return;
    }
    BmobUser bmobUserRegister = BmobUser();
    bmobUserRegister.username = userName;
    bmobUserRegister.password = password;
    bmobUserRegister.register().then((BmobRegistered data) {
      print("注册成功");
      showToast('注册成功：' + data.objectId);
      if (widget.onJumpToLogin != null) {
        widget.onJumpToLogin();
      }
    }).catchError((e) {
      print("注册失败" + BmobError.convert(e).error);
      showToast('注册失败：' + BmobError.convert(e).error);
    });
  }

  setPermission() async {
    if (await Permission.storage.request().isGranted) {
      //判断是否授权,没有授权会发起授权
      print("获得了授权");
    } else {
      print("没有获得授权");
    }
  }
}
