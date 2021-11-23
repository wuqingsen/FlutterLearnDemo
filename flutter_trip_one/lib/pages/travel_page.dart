import 'package:flutter/material.dart';
import 'package:flutter_app_new/dao/travel_dao.dart';
import 'package:flutter_app_new/dao/travel_tab_dao.dart';
import 'package:flutter_app_new/model/photo/travel_tab_model.dart';
import 'package:flutter_app_new/model/photo/travel_tab_model.dart';
import 'package:flutter_app_new/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() {
    return _TravelPageState();
  }
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  late TabController _controller;
  List<Tabs> tabs = [];
  late TravelTabPhotoModel travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabPhotoModel model) {
      //展示空白的问题
      _controller = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
              controller: _controller,
              isScrollable: true,
              //是否可以左右滑动
              labelColor: Colors.black,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
              //底部滑动条
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 3,
                  ),
                  insets: EdgeInsets.only(bottom: 10)),
              tabs: tabs.map<Tab>((Tabs tab) {
                return Tab(
                  text: tab.labelName,
                );
              }).toList(),
            ),
          ),
          Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: tabs.map((Tabs tab) {
                    return TravelTabPage(
                        travelUrl: travelTabModel.url,
                        groupChannelCode: tab.groupChannelCode);
                  }).toList()))
        ],
      ),
    );
  }
}
