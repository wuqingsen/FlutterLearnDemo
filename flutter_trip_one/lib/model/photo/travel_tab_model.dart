class TravelTabPhotoModel {
  late final String url;
  late final Params params;
  late final List<Tabs> tabs;

  TravelTabPhotoModel({required this.url, required this.params, required this.tabs});

  TravelTabPhotoModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    params =
        (json['params'] != null ? new Params.fromJson(json['params']) : null)!;
    if (json['tabs'] != null) {
      tabs = new List<Tabs>.empty(growable: true);
      json['tabs'].forEach((v) {
        tabs.add(new Tabs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.params != null) {
      data['params'] = this.params.toJson();
    }
    if (this.tabs != null) {
      data['tabs'] = this.tabs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Params {
  int districtId = 0;
  String groupChannelCode = '';
  String type = '';
  int lat = 0;
  int lon = 0;
  int locatedDistrictId = 0;
  late final PagePara pagePara;
  int imageCutType = 0;
  late final Head head;
  String contentType = '';

  Params(
      {required this.districtId,
      required this.groupChannelCode,
      required this.type,
      required this.lat,
      required this.lon,
      required this.locatedDistrictId,
      required this.pagePara,
      required this.imageCutType,
      required this.head,
      required this.contentType});

  Params.fromJson(Map<String, dynamic> json) {
    districtId = json['districtId'];
    groupChannelCode = json['groupChannelCode'];
    type = json['type'];
    lat = json['lat'];
    lon = json['lon'];
    locatedDistrictId = json['locatedDistrictId'];
    pagePara = (json['pagePara'] != null
        ? new PagePara.fromJson(json['pagePara'])
        : null)!;
    imageCutType = json['imageCutType'];
    head = (json['head'] != null ? new Head.fromJson(json['head']) : null)!;
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districtId'] = this.districtId;
    data['groupChannelCode'] = this.groupChannelCode;
    data['type'] = this.type;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['locatedDistrictId'] = this.locatedDistrictId;
    if (this.pagePara != null) {
      data['pagePara'] = this.pagePara.toJson();
    }
    data['imageCutType'] = this.imageCutType;
    if (this.head != null) {
      data['head'] = this.head.toJson();
    }
    data['contentType'] = this.contentType;
    return data;
  }
}

class PagePara {
  int pageIndex = 0;
  int pageSize = 0;
  int sortType = 0;
  int sortDirection = 0;

  PagePara(
      {required this.pageIndex,
      required this.pageSize,
      required this.sortType,
      required this.sortDirection});

  PagePara.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    sortType = json['sortType'];
    sortDirection = json['sortDirection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['sortType'] = this.sortType;
    data['sortDirection'] = this.sortDirection;
    return data;
  }
}

class Head {
  String cid = '';
  String ctok = '';
  String cver = '';
  String lang = '';
  String sid = '';
  String syscode = '';
  String auth = '';
  List<Extension> extension = new List<Extension>.empty(growable: true);

  Head(
      {required this.cid,
      required this.ctok,
      required this.cver,
      required this.lang,
      required this.sid,
      required this.syscode,
      required this.auth,
      required this.extension});

  Head.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    ctok = json['ctok'];
    cver = json['cver'];
    lang = json['lang'];
    sid = json['sid'];
    syscode = json['syscode'];
    auth = json['auth'];
    if (json['extension'] != null) {
      extension = new List<Extension>.empty(growable: true);
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['ctok'] = this.ctok;
    data['cver'] = this.cver;
    data['lang'] = this.lang;
    data['sid'] = this.sid;
    data['syscode'] = this.syscode;
    data['auth'] = this.auth;
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Extension {
  String name = '';
  String value = '';

  Extension({this.name = '', this.value = ''});

  Extension.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class Tabs {
  String labelName = '';
  String groupChannelCode = '';

  Tabs({this.labelName = '', this.groupChannelCode = ''});

  Tabs.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}
