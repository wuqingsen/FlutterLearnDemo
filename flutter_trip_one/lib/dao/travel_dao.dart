import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_new/model/photo/travel_model.dart';
import 'package:http/http.dart' as http;

var Paramss = {
  "districtId": -1,
  "groupChannelCode": "TX-OMF",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": -0,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0,
  },
  "imageCutType": 1,
  "head": {},
  "contentType": "json"
};

class TravelDao {
  static Future<TravelModel> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    Map? paramesMap = Paramss['pagePara'] as Map?;
    paramesMap!['pageIndex'] = pageIndex;
    paramesMap['pageSize'] = pageSize;
    Paramss['groupChannelCode'] = groupChannelCode;
    var response = null;
    try {
      response = await http.post(url, body: jsonEncode(Paramss));
    } catch (e) {
      print(e);
    }
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //修复中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelModel.fromJson(result);
    } else {
      throw Exception('Failed to load');
    }
  }
}
