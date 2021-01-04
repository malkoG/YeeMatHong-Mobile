import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;

import 'package:yeemathongmobile/model/notice.dart';

class NoticeRepository {
  static Future<List<Notice>> getNotices() async {
    List<Notice> list = [];

    String noticesJson = await rootBundle.loadString("assets/data/notices.json");
    final jsonResponse = json.decode(noticesJson);

    for (final noticeJson in jsonResponse) {
      list.add(Notice.fromJson(noticeJson));
    }

    return list;
  }
}
