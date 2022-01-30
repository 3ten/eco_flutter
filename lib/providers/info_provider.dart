import 'dart:convert';

import 'package:eco/api/api_manager.dart';
import 'package:eco/models/checklist_model.dart';
import 'package:eco/models/info.dart';
import 'package:eco/models/report_model.dart';
import 'package:eco/models/super_model.dart';
import 'package:flutter/material.dart';

class InfoProvider extends ChangeNotifier {
  final APIManager _apiManager = APIManager();
  String title = "";
  String text = "";
  List<String> images = [];
  Info info = Info();

  getInfo() async {
    var response = await _apiManager.get(
        url: 'info', param: {}, responseType: ResponseType.json);
    var data = response[0] ?? {};
    print(data);
    info = Info.fromJson(data);

    notifyListeners();
  }
}
