import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///自定义搜索
//home:首页未滑动；normal:搜索页面；homeLight首页滑动之后
enum SearchBarType { home, normal, homeLight }

class SearchBar extends StatefulWidget {
  final bool enabled; //是否启动搜索功能
  final bool hideLeft; //左边按钮是否隐藏
  final SearchBarType searchBarType; //未滑动首页，已上滑首页，搜索页面
  final String hint; //默认提示
  final String defaultText; //默认显示的文字
  final void Function() leftButtonClick; //左边按钮回调
  final void Function() rightButtonClick; //右边按钮回调
  final void Function() speakClick; //语音回调
  final void Function() inputBoxClick; //首页输入框点击回调
  final ValueChanged<String> onChanged; //内容变化回调

  const SearchBar(
      {Key? key,
      required this.enabled,
      required this.hideLeft,
      required this.searchBarType,
      this.hint = '',
      this.defaultText = '',
      required this.leftButtonClick,
      required this.rightButtonClick,
      required this.speakClick,
      required this.inputBoxClick,
      required this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  //是否显示清除按钮
  bool showClear = false;

  //文字变化
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    //不是空显示默认文字
    if (widget.defaultText.isNotEmpty) {
      setState(() {
        _controller.text = widget.defaultText;
        widget.searchBarType == SearchBarType.normal
            ? _onChanged(widget.defaultText)
            : null;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _genNormalSearch()
        : _genHomeSearch();
  }

  //搜索页面输入框
  _genNormalSearch() {
    return Container(
      height: 30,
      child: Row(
        children: [
          //左边按钮
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: widget.hideLeft
                    ? null
                    : Icon(Icons.arrow_back_ios, color: Colors.grey, size: 20),
              ),
              widget.leftButtonClick),
          //输入框
          Expanded(flex: 1, child: _inputBox()),
          //右边按钮
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 5),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ),
              widget.rightButtonClick),
        ],
      ),
    );
  }

  //首页中的输入框
  _genHomeSearch() {
    return Container(
      child: Row(
        children: [
          //左边按钮
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
                child: Row(children: [
                  Text('北京',
                      style: TextStyle(color: _homeFontColor(), fontSize: 14)),
                  Icon(
                    Icons.expand_more,
                    color: _homeFontColor(),
                    size: 22,
                  )
                ]),
              ),
              widget.leftButtonClick),
          //输入框
          Expanded(flex: 1, child: _inputBox()),
          //右边按钮
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.comment,
                  color: _homeFontColor(),
                  size: 26,
                ),
              ),
              widget.rightButtonClick),
        ],
      ),
    );
  }

  //输入框
  _inputBox() {
    //设置输入框颜色
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      //首页设置为白色
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      height: widget.searchBarType == SearchBarType.normal ? 30 : 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputBoxColor,
          //设置圆角
          borderRadius: BorderRadius.circular(
              widget.searchBarType == SearchBarType.normal ? 5 : 15)),
      child: Row(
        children: [
          Icon(Icons.search,
              size: 20,
              color: widget.searchBarType == SearchBarType.normal
                  ? Colors.blue
                  : Colors.blue),
          Expanded(
              flex: 1,
              child: widget.searchBarType == SearchBarType.normal
                  ? TextField(
                      //展示输入框文本框
                      controller: _controller,
                      onChanged: _onChanged,
                      //自动对焦
                      autofocus: false,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                      //输入框样式
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 15),
                        border: InputBorder.none,
                        hintText: widget.hint,
                        hintStyle: TextStyle(fontSize: 12),
                      ),
                    )
                  : _wrapTap(
                      //首页显示假输入框
                      Container(
                        child: Text(
                          widget.defaultText,
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      widget.inputBoxClick)),
          !showClear
              ? _wrapTap(
                  Icon(
                    Icons.mic,
                    size: 22,
                    color: widget.searchBarType == SearchBarType.normal
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  widget.speakClick)
              : _wrapTap(
                  Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ), () {
                  setState(() {
                    //清空内容
                    _controller.clear();
                  });
                  //清空内容
                  _onChanged('');
                })
        ],
      ),
    );
  }

  //回调
  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  //是否显示清空按钮
  _onChanged(String text) {
    //输入框有内容显示清除按钮，没有内容显示语音按钮
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }

  //首页颜色
  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}
