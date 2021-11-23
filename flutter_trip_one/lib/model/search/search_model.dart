///搜索实体类
class SearchModel {
  final List<SearchItem>? data;

  SearchModel({ this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'] as List;
    List<SearchItem> data =
        dataJson.map((e) => SearchItem.fromJson(e)).toList();
    return SearchModel(data: data);
  }
}

class SearchItem {
  final String code;
  final String word;
  final String type;
  final String districtname;
  final String url;
  final bool isBigIcon;
  final String imageUrl;
  final String subImageUrl;

  SearchItem(
      {this.code = '',
      this.word = '',
      this.type = '',
      this.districtname = '',
      this.url = '',
      this.isBigIcon = false,
      this.imageUrl = '',
      this.subImageUrl = ''});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      code: json['code'],
      word: json['word'],
      type: json['type'],
      districtname: json['districtname'],
      url: json['url'],
      isBigIcon: json['isBigIcon'],
      imageUrl: json['imageUrl'],
      subImageUrl: json['subImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['word'] = this.word;
    data['type'] = this.type;
    data['districtname'] = this.districtname;
    data['url'] = this.url;
    data['isBigIcon'] = this.isBigIcon;
    data['imageUrl'] = this.imageUrl;
    data['subImageUrl'] = this.subImageUrl;
    return data;
  }
}
