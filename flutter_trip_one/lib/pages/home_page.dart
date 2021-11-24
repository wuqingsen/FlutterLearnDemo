import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_new/dao/home_dao.dart';
import 'package:flutter_app_new/model/main/common_model.dart';
import 'package:flutter_app_new/model/main/grid_nav_model.dart';
import 'package:flutter_app_new/model/main/home_model.dart';
import 'package:flutter_app_new/model/main/sales_box_model.dart';
import 'package:flutter_app_new/pages/search_page.dart';
import 'package:flutter_app_new/widget/grid_nav.dart';
import 'package:flutter_app_new/widget/loading_container.dart';
import 'package:flutter_app_new/widget/local_nav.dart';
import 'package:flutter_app_new/widget/sales_box.dart';
import 'package:flutter_app_new/widget/search_nav.dart';
import 'package:flutter_app_new/widget/sub_nav.dart';
import 'package:flutter_app_new/widget/webview.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String resultString = '初始';
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  List<CommonModel> bannerList = [];
  late SalesBoxModel salesBoxModel;
  late GridNavModel gridNavModel;
  bool isSuccess = false;
  bool _loading = true;

  _onScroll(offset) {
    //offset滚动距离
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    // print('透明度' + appBarAlpha.toString());
  }

  double appBarAlpha = 0;

  @override
  void initState() {
    super.initState();
    onLoadData();
    Future.delayed(Duration(milliseconds: 600), () {
      FlutterSplashScreen.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getScaffold();
  }

  _getScaffold() {
    if (isSuccess) {
      return Scaffold(
        backgroundColor: Color(0xfff2f2fa),
        //Stack相对布局
        body: Stack(
          children: [
            //移除上部的距离
            MediaQuery.removePadding(
              removeTop: true, //移除上部
              context: context,
              //监听滚动
              child: RefreshIndicator(
                onRefresh: onLoadData,
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      //发生滚动并且是第0个元素
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return false;
                  },
                  //主要内容
                  child: _listView(),
                ),
              ),
            ),
            _appBar()
          ],
        ),
      );
    } else {
      return Scaffold(
        body: LoadingContainer(
          isLoading: _loading,
          child: Text(''),
        ),
      );
    }
  }

  //加载数据
  Future<Null> onLoadData() async {
    await Future.delayed(Duration(seconds: 1));
    // HomeDao.fetch().then((result){
    //   setState(() {
    //    resultString = json.encode(result);
    //   });
    // }).catchError((e){
    //   setState(() {
    //     resultString = e.toString();
    //   });
    // });
    //另一种
    try {
      TravelTabModel model = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(model.config);
        print('搜索地址:'+resultString);
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList;
        _loading = false;
        isSuccess = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  _listView() {
    return ListView(
      children: [
        //广告循环
        _banner(),
        //五个入口
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        //酒店机票旅游卡片
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        //十个入口
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        //底部卡片入口
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: salesBoxModel),
        ),
      ],
    );
  }

  _banner() {
    return Container(
      height: 200, //高度
      //item1
      child: Swiper(
        itemCount: bannerList.length, //广告图片长度
        autoplay: true, //自动播放
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                          url: bannerList[index].url,
                          // statusBarColor: model.statusBarColor,
                          title: bannerList[index].title,
                          // hideAppBar: model.hideAppBar,
                          backForbid: false)));
            },
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill, //图片适配方式
            ),
          );
        },
        //设置指示器
        pagination: SwiperPagination(),
      ),
    );
  }

  _appBar() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            //渐变色
            colors: [Color(0x66000000), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
                color:
                    Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
            child: SearchBar(
                enabled: false,
                hideLeft: false,
                defaultText: '试试搜索',
                searchBarType: appBarAlpha > 0.2
                    ? SearchBarType.homeLight
                    : SearchBarType.home,
                leftButtonClick: () {},
                rightButtonClick: () {},
                speakClick: _jumpToSearch,
                inputBoxClick: _jumpToSpeak,
                onChanged: (String s) {}),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 0.5)]
          ),
        )
      ],
    );
  }

  _jumpToSearch() {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return SearchPage(
        hint: "提示文字",
      );
    }));
  }

  _jumpToSpeak() {}
}
