import 'package:data_plugin/bmob/bmob.dart';
import 'package:flutter/material.dart';
import 'package:data_plugin/data_plugin.dart';
import 'package:flutter_blbl/page/login_page.dart';
import 'package:flutter_blbl/page/registration_page.dart';
import 'package:flutter_blbl/utils/color.dart';
import 'package:permission_handler/permission_handler.dart';

import 'utils/toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Bmob.initMasterKey(
        "https://api2.bmob.cn",
        "bdb1a27490a65408db30a862b5023ffa",
        "1ef17ded7609019652b448773b06e1bd",
        "574fb1ffbe28cce59414d678d1817eca");

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: LoginPage(),
    );
  }
}
