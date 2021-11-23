
import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_new/model/photo/travel_tab_model.dart';
import 'package:http/http.dart' as http;

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/travel_page.json';

class TravelTabDao {
  static Future<TravelTabPhotoModel> fetch() async {
    final response = await http.get(HOME_URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabPhotoModel.fromJson(result);
    }else{
      throw Exception('Failed to load');
    }
  }
}
