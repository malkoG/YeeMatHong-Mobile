import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;

import 'package:http/http.dart' as http;

import 'package:yeemathongmobile/model/notice.dart';

class NoticeRepository {
  static Future<List<Notice>> getNotices() async {
    List<Notice> list = [];

    final baseUrl = "http://192.168.0.14:3000";
    final url = "$baseUrl/api/v1/notices";

    final response = await http.get(url);

    print(response);
    if (response.statusCode == 201) {
      // String noticesJson = await rootBundle.loadString("assets/data/notices.json");
      String noticesJson = response.body;
      final jsonResponse = json.decode(noticesJson);

      for (final noticeJson in jsonResponse) {
        list.add(Notice.fromJson(noticeJson));
      }

      return list;
    } else {
      throw Exception("API 서버에서 정보를 불러오는데 실패했습니다.");
    }
  }
}
