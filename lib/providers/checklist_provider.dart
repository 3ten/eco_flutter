import 'dart:convert';

import 'package:eco/api/api_manager.dart';
import 'package:eco/models/checklist_model.dart';
import 'package:eco/models/super_model.dart';
import 'package:flutter/material.dart';

class CheckListProvider extends ChangeNotifier {
  final APIManager _apiManager = APIManager();
  final List<Checklist> _checklist = [];
  String _title = "";

  List<Checklist> get checklist => _checklist;

  String get title => _title;

  getTitle() async {
    _title = await _apiManager.get(
        url: 'checklist/title', param: {}, responseType: ResponseType.text);
    notifyListeners();
  }

  sendEmail(email) async {
    SuperModel superModel = SuperModel(checklist: _checklist);

    _apiManager.post(url: 'checklist/email',param:{"email": email, "checks":superModel.toJson()['checklist'] });
  }

  getChecklist() async {
    var data = await _apiManager.get(
        url: 'checklist', param: {}, responseType: ResponseType.array);

    for (var item in data) {
      print('получаем тут-->');
      print(item['title']);
      _checklist.add(Checklist.fromJson(item));
      print('<=---');
    }
    print(_checklist.length);
    notifyListeners();
  }

  void select({required int i, int? j, required bool value}) {
    if (j != null) {
      _checklist[i].boxes[j].isSelected = value;
    } else {
      for (var index = 0; index < _checklist[i].boxes.length; index++) {
        _checklist[i].boxes[index].isSelected = value;
      }
    }
    _checklist[i].isSelected = _checkSelectedGroup(i);
    notifyListeners();
  }

  bool _checkSelectedGroup(int i) {
    for (var j = 0; j < _checklist[i].boxes.length; j++) {
      if (!_checklist[i].boxes[j].isSelected) return false;
    }
    return true;
  }
}
