import 'package:flutter/material.dart';
import 'package:flutter_app_new/pages/home_page.dart';
import 'package:flutter_app_new/pages/my_page.dart';
import 'package:flutter_app_new/pages/search_page.dart';
import 'package:flutter_app_new/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() {
    return _TabNavigatorState();
  }
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey; //未选中
  final _activeColor = Colors.blue; //选中
  int _currentIndex = 0; //默认选中第一个
  final PageController _controller = PageController(
    initialPage: 0, //默认显示第0个tab
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        //禁止左右滑动
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          SearchPage(hideLeft: true,),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //默认显示第几个页面
        currentIndex: _currentIndex,
        onTap: (index) {
          //点击跳转指定页面
          _controller.jumpToPage(index);
          //改变当前页面
          setState(() {
            _currentIndex = index;
          });
        },
        //fixed永远显示底部lab(文字)，shifting只有被选中才会显示底部文字
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              //设置默认图标和颜色
              icon: Icon(
                Icons.home,
                color: _defaultColor,
              ),
              //设置选中图标和颜色
              activeIcon: Icon(
                Icons.home,
                color: _activeColor,
              ),
              title: Text(
                '首页',
                style: TextStyle(
                  color: _currentIndex != 0 ? _defaultColor : _activeColor,
                ),
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.search,
              color: _activeColor,
            ),
            title: Text('搜索',
                style: TextStyle(
                  color: _currentIndex != 1 ? _defaultColor : _activeColor,
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.camera_alt,
              color: _activeColor,
            ),
            title: Text('发现',
                style: TextStyle(
                  color: _currentIndex != 2 ? _defaultColor : _activeColor,
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.account_circle,
              color: _activeColor,
            ),
            title: Text('我的',
                style: TextStyle(
                  color: _currentIndex != 3 ? _defaultColor : _activeColor,
                )),
          )
        ],
      ),
    );
  }
}
