import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_new/widget/webview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const int PAGE_SIZE = 10;
const _TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final String groupChannelCode;

  const TravelTabPage(
      {Key? key, required this.travelUrl, required this.groupChannelCode})
      : super(key: key);

  @override
  _TravelTabPageState createState() {
    return _TravelTabPageState();
  }
}

//AutomaticKeepAliveClientMixin防止tab切换页面重新绘制
class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  int pageIndex = 1;
  List<String> listData = [];

  //加载更多
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScaffold(),
    );
  }

  _getScaffold() {
    return Scaffold(
      //移除页面上边距
      body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: RefreshIndicator(
              onRefresh: _refresh,
              child: StaggeredGridView.countBuilder(
                controller: _scrollController,
                crossAxisCount: 4,
                //横轴单元格数量
                itemCount: listData.length,
                //元素数量
                itemBuilder: (context, index) {
                  return _TraveItem(
                    index: index,
                    imageURL: listData,
                  );
                },
                staggeredTileBuilder: (index) {
                  return StaggeredTile.fit(2); //第一个参数是横轴所占的单元数，第二个参数是主轴所占的单元数
                },
              ))),
    );
  }

  @override
  bool get wantKeepAlive => true; //不用重新绘制当前页面

  void _loadData() {
    setState(() {
      for (int i = 0; i < 30; i++) {
        listData.add(_getImageUrl());
      }
      print("加载数据:" + listData.length.toString());
    });
  }

  //下拉刷新
  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    listData.clear();
    _loadData();
    return null;
  }

  _getImageUrl() {
    final List<String> listImage = [];
    listImage.add(
        "https://youimg1.c-ctrip.com/target/0101l120008dpyjwqDD40_R_640_10000_Q90.jpg");
    listImage
        .add("https://youimg1.c-ctrip.com/target/01A4z120008eoiga2C447.jpg");
    listImage.add(
        "https://youimg1.c-ctrip.com/target/01A6t22341thgto343142_R_800_10000_Q50.jpg?proc=source/tripcommunity");
    listImage.add(
        "https://youimg1.tripcdn.com/target/0105g120008e2txwsF56B_R_640_10000_Q90.jpg");
    listImage
        .add("https://youimg1.c-ctrip.com/target/0105w120008ehpl9iDA65.jpg");
    listImage
        .add("https://youimg1.c-ctrip.com/target/100p0z000000nkmclB359.jpg");
    listImage
        .add("https://youimg1.c-ctrip.com/target/100l0z000000nlnj4DB62.jpg");
    listImage
        .add("https://youimg1.c-ctrip.com/target/100e0z000000no8l6C4D6.jpg");
    listImage
        .add("https://youimg1.c-ctrip.com/target/100r0z000000njwrj2803.jpg");
    listImage
        .add("https://youimg1.c-ctrip.com/target/100o0z000000nkbvo0B55.jpg");
    listImage
        .add("https://youimg1.c-ctrip.com/target/100g0z000000nm6hi2586.jpg");
    listImage.add(
        "https://youimg1.c-ctrip.com/target/01A6q120008eoboc53212_R_640_10000_Q90.jpg?proc=source/tripcommunity");
    listImage
        .add("https://youimg1.c-ctrip.com/target/01A2o120008eocsgu0379.jpg");
    listImage
        .add("https://youimg1.c-ctrip.com/target/01A0n120008eohfeu9EE5.jpg");
    listImage
        .add("https://youimg1.c-ctrip.com/target/01A1b120008eod7mz9E97.jpg");
    listImage
        .add("https://youimg1.c-ctrip.com/target/0103d120008zk4vsdED29.png");
    var rng = new Random();
    int a = rng.nextInt(listImage.length - 1);
    return listImage[a];
  }
}

class _TraveItem extends StatelessWidget {
  final int index;
  final List<String> imageURL;

  const _TraveItem({Key? key, required this.index, required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                    url:
                        "https://m.ctrip.com/webapp/you/article/detail/9185659.html",
                    // statusBarColor: model.statusBarColor,
                    title: "详情",
                    // hideAppBar: model.hideAppBar,
                    backForbid: false)));
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //图片部分
              _itemImage(),
              //下面文字部分
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  _getTextTitle(),
                  maxLines: 2,
                  //超出使用省略号
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              //底部文字
              _infoText(),
            ],
          ),
        ),
      ),
    );
  }

  _itemImage() {
    return Stack(
      children: <Widget>[
        Image.network(imageURL[index]),
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 3),
                    //位置
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  //限制最大高度和宽度
                  LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      _getTextLocation(),
                      maxLines: 1,
                      //显示不下显示省略号
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  _infoText() {
    return Container(
        padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
        child: Row(
          //平分
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //头像昵称
            Row(
              children: [
                //裁剪成一个形状
                PhysicalModel(
                  color: Colors.transparent,
                  //锯齿
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    _getImageIcon(),
                    width: 24,
                    height: 24,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    _getTextName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
            //点赞图标文字
            Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  size: 14,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    _getTextNum(),
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  _getTextLocation() {
    final List<String> listImage = [];
    listImage.add("稻城亚丁");
    listImage.add("成都");
    listImage.add("仰光大金塔");
    listImage.add("文县天池国家森林公园");
    listImage.add("陇南");
    listImage.add("安嫚达里度假村");
    listImage.add("印度尼西亚巴厘岛");
    listImage.add("蜀大侠火锅(春熙店)");
    listImage.add("泰姬陵阿格拉");
    listImage.add("黑龙江哈尔滨冰雪大世界");
    var rng = new Random();
    int a = rng.nextInt(listImage.length - 1);
    return listImage[a];
  }

  _getTextTitle() {
    final List<String> listImage = [];
    listImage.add("去横店过大年，不得不去秦王宫走");
    listImage.add("「稻城亚丁」有些风景只能喜欢却不能收藏");
    listImage.add("详细地址：川师附近，好停车哦，");
    listImage.add("来一场美酒与美景皆不可辜负的不期而遇");
    listImage.add("#向往的生活# 泰姬陵的日落");
    listImage.add("厦门探店｜叶太开在戏台旁旧楼里的甜品店");
    listImage.add("仰光大金塔");
    listImage.add("自驾甘肃陇南，寻觅小众秘境");
    var rng = new Random();
    int a = rng.nextInt(listImage.length - 1);
    return listImage[a];
  }

  _getTextNum() {
    var rng = new Random();
    int a = rng.nextInt(9999);
    return a.toString();
  }

  _getTextName() {
    final List<String> listImage = [];
    listImage.add("帽帽moer1");
    listImage.add("莫文辰");
    listImage.add("布丁吃耍成都");
    listImage.add("序说幸福");
    listImage.add("兩兩先生");
    listImage.add("背包客的笔记");
    listImage.add("文彬Ricky");
    listImage.add("遇见狮城");
    var rng = new Random();
    int a = rng.nextInt(listImage.length - 1);
    return listImage[a];
  }

  _getImageIcon() {
    final List<String> listImage = [];
    listImage.add(
        "https://dimg04.c-ctrip.com/images/0Z86h120008n2ld4r9A6D_C_180_180.jpg");
    listImage.add(
        "https://youimg1.c-ctrip.com/target/1A0uhk114z0s4ban493AE_R_640_10000_Q90.jpg?proc=source/tripcommunity");
    listImage.add(
        "https://dimg04.c-ctrip.com/images/1h63q120008vr9e3jE298_C_180_180.jpg");
    listImage.add(
        "https://dimg04.c-ctrip.com/images/0Z8243224k6xh0uyo8A6D_C_180_180.jpg");
    listImage.add(
        "https://dimg04.c-ctrip.com/images/headphoto/126/763/414/70506fcb82dd4725af8cccd5d67023a4_C_180_180.jpg");
    listImage.add(
        "https://dimg04.c-ctrip.com/images/0Z83p120008c7uvpp3695_C_180_180.jpg");
    listImage.add(
        "https://dimg04.c-ctrip.com/images/0Z80n1200091oku3071E4_C_180_180.jpg");
    listImage.add(
        "https://dimg04.c-ctrip.com/images/0Z834120008w7xsuzDC92_C_180_180.jpg");
    var rng = new Random();
    int a = rng.nextInt(listImage.length - 1);
    return listImage[a];
  }
}
