import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_new/dao/search_dao.dart';
import 'package:flutter_app_new/model/search/search_model.dart';
import 'package:flutter_app_new/widget/search_nav.dart';
import 'package:flutter_app_new/widget/webview.dart';

const URL =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword; //搜索内容
  final String hint; //提示

  const SearchPage(
      {Key? key,
      this.hideLeft = false,
      this.searchUrl = URL,
      this.keyword = '',
      this.hint = ''})
      : super(key: key);

  @override
  _SearchPageState createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  late SearchModel searchModel = new SearchModel(data: null);
  String keyword = '';

  @override
  void initState() {
    super.initState();
    _onTextChange('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          MediaQuery.removePadding(
            removeTop: true, //移除上部空白
            context: context,
            child: Expanded(
                flex: 1,
                child: ListView.builder(
                    //如果searchModel为空，或者data为空，长度设置为0
                    itemCount: searchModel.data?.length,
                    itemBuilder: (BuildContext context, int position) {
                      return _item(position);
                    })),
          ),
        ],
      ),
    );
  }

  _appBar() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              //设置渐变
              gradient: LinearGradient(
            colors: [Color(0x66000000), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Container(
            padding: EdgeInsets.only(top: 40, bottom: 5),
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
                enabled: true,
                hideLeft: widget.hideLeft,
                searchBarType: SearchBarType.normal,
                hint: widget.hint,
                defaultText: widget.keyword,
                leftButtonClick: () {
                  Navigator.pop(context);
                },
                rightButtonClick: () {},
                speakClick: () {},
                inputBoxClick: () {},
                onChanged: _onTextChange),
          ),
        )
      ],
    );
  }

  _onTextChange(String text) {
    if (text.isNotEmpty) {
      keyword = text;
      // if (text.length == 0) {
      //   setState(() {
      //     searchModel = null;
      //     return;
      //   });
      // }
      String url = widget.searchUrl + text;
      SearchDao.fetch(url).then((SearchModel model) {
        setState(() {
          searchModel = model;
        });
      }).catchError((e) {
        print(e);
      });
    }
  }

  //ListView中item
  Widget _item(int position) {
    print('序号' + position.toString());
    if (searchModel.data != null) {
      SearchItem item = searchModel.data![position];
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(url: item.url, title: '详情')));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey)),
          ),
          child: Row(
            children: [
              _getImage(item.type),
              Column(
                children: [
                  Container(
                    width: 300,
                    child: _getText(item),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    width: 300,
                    child: Text(
                      'lable:' + '${item.type}',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return Text('');
    }
  }

  _getImage(String type) {
    if (type == "food") {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          Icons.fastfood,
          size: 22,
          color: Colors.blue,
        ),
      );
    } else if (type == "district") {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          Icons.gpp_good,
          size: 22,
          color: Colors.blue,
        ),
      );
    } else if (type == "sight") {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          Icons.insights,
          size: 22,
          color: Colors.blue,
        ),
      );
    } else if (type == "hotelist" || type == "inn") {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          Icons.hotel,
          size: 22,
          color: Colors.blue,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          Icons.hot_tub,
          size: 22,
          color: Colors.blue,
        ),
      );
    }
  }

  //获取内容
  _getText(SearchItem item) {
    List<TextSpan> spans = [];
    spans = _keywordTextSpans(item.word, widget.keyword);
    if (item.districtname == null || item.districtname.isEmpty) {
    } else {
      spans.add(TextSpan(
          text: '  ' + item.districtname,
          style: TextStyle(fontSize: 15, color: Colors.grey)));
    }
    return RichText(text: TextSpan(children: spans));
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    List<String> arr = word.split(keyword); //根据keyword把word拆分成两部分
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(text: keyword, style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
