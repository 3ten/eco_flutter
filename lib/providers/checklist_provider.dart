import 'dart:convert';

import 'package:eco/api/api_manager.dart';
import 'package:eco/models/checklist_model.dart';
import 'package:eco/models/report_model.dart';
import 'package:eco/models/super_model.dart';
import 'package:flutter/material.dart';

class CheckListProvider extends ChangeNotifier {
  final APIManager _apiManager = APIManager();
  final List<Checklist> _checklist = [];
  List<Checklist> _oldChecklist = [];
  List<Checklist> _checklistCriteria = [];
  String _title = "";

  List<Checklist> get checklistCriteria => _checklistCriteria;

  List<Checklist> get checklist => _checklist;

  String get title => _title;

  getTitle() async {
    _title = await _apiManager.get(
        url: 'checklist/title', param: {}, responseType: ResponseType.text);
    notifyListeners();
  }

  sendEmail(email) async {
    SuperModel superModel = SuperModel(checklist: _checklist);

    _apiManager.post(
        url: 'checklist/email',
        param: {"email": email, "checks": superModel.toJson()['checklist']});
  }

  getChecklist() async {
    var data = await _apiManager.get(
        url: 'checklist', param: {}, responseType: ResponseType.array);
    if (_checklist.isNotEmpty) return;
    _checklist.clear();
    for (var item in data) {
      _checklist.add(Checklist.fromJson(item));
    }

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

  reset() {
    _checklistCriteria = List.from(_oldChecklist);
    notifyListeners();
  }

  getChecklistCriteria() async {
    var data = await _apiManager.get(
        url: 'checklist', param: {}, responseType: ResponseType.array);
    _checklistCriteria.clear();
    for (var item in data) {
      _checklistCriteria.add(Checklist.fromJson(item));
    }
    notifyListeners();
  }

  void selectCriteria({required int i, int? j, required bool value}) {
    if (j != null) {
      _checklistCriteria[i].boxes[j].isSelected = value;
    } else {
      for (var index = 0; index < _checklistCriteria[i].boxes.length; index++) {
        _checklistCriteria[i].boxes[index].isSelected = value;
      }
    }
    _checklistCriteria[i].isSelected = _checkSelectedCriteriaGroup(i);
    notifyListeners();
  }

  bool _checkSelectedCriteriaGroup(int i) {
    for (var j = 0; j < _checklist[i].boxes.length; j++) {
      if (!_checklistCriteria[i].boxes[j].isSelected) return false;
    }
    return true;
  }

  void setOldAndCheck(ReportModel report) async {
    await getChecklistCriteria();
    report.criteria?.forEach((element) {
      for (var i = 0; i < _checklistCriteria.length; i++) {
        for (var j = 0; j < _checklistCriteria[i].boxes.length; j++) {
          if (_checklistCriteria[i].boxes[j].label == element.name) {
            selectCriteria(i: i, j: j, value: true);
          } else {
            // selectCriteria(i: i, j: j, value: false);
          }
        }
      }
    });
    _oldChecklist = List.from(_checklistCriteria);
    notifyListeners();
  }
}
