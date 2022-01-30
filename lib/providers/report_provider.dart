import 'dart:convert';

import 'package:eco/api/api_manager.dart';
import 'package:eco/models/city_model.dart';
import 'package:eco/models/criteria.dart';
import 'package:eco/models/description.dart';
import 'package:eco/models/report_model.dart';
import 'package:eco/models/super_model.dart';
import 'package:eco/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';

class ReportProvider extends ChangeNotifier {
  final APIManager _apiManager = APIManager();
  ReportModel _reportModel = ReportModel();
  ReportModel _project = ReportModel();
  List<ReportModel> _reports = [];
  List<ReportModel> _projects = [];

  List<ReportModel> get reports => _reports;

  ReportModel get project => _project;

  ReportModel get report => _reportModel;

  List<ReportModel> get projects => _projects;

  setReportModel(ReportModel reportModel) {
    _reportModel = reportModel;
    notifyListeners();
  }

  setProject(ReportModel reportModel) {
    _project = reportModel;
    notifyListeners();
  }

  setName(String? name) {
    _reportModel.name = name;
  }

  setDateStart(DateTime? dateStart) {
    _reportModel.dateStart = dateStart;
  }

  setDateEnd(DateTime? dateEnd) {
    _reportModel.dateEnd = dateEnd;
  }

  setCity(String? city) {
    _reportModel.city = city;
  }

  setAddress(String? address) {
    _reportModel.address = address;
  }

  setDescription(Description? description) {
    _reportModel.description = description;
  }

  setStatus(String? status) {
    _reportModel.status = status;
  }

  setCriteria(List<Criteria>? criteria) {
    _reportModel.criteria = criteria;
  }

  setDescriptionTitle(String title) {
    if (_reportModel.description != null) {
      _reportModel.description?.title = title;
    }
  }

  setDescriptionImage(XFile image) async {
    if (_reportModel.id == null) {
      updateReport();
    }
    var data = await _apiManager.postImage(
        filename: image, url: 'event/${_reportModel.id}/description/img');

    _reportModel.description = ReportModel.fromJson(data).description;
    notifyListeners();
  }

  setCriteriaImage(XFile image, String criteria) async {
    if (_reportModel.id == null) {
      updateReport();
    }
    var data = await _apiManager.postImage(
        filename: image,
        text: criteria,
        url: 'event/${_reportModel.id}/criteria/img');

    print(data);

    var index = _reportModel.criteria
        ?.indexWhere((element) => element.name == criteria);
    if (index != null) {
      Criteria? _criteria = ReportModel.fromJson(data)
          .criteria
          ?.where((element) => element.name == criteria)
          .toList()[0];
      if (_criteria != null) {
        _reportModel.criteria?[index] = _criteria;
      }
    }

    notifyListeners();
  }

  void getReports() async {
    var data = await _apiManager.get(url: 'event');
    _reports = SuperModel.fromJson({'reports': data}).reports ?? [];
    notifyListeners();
  }

  void getProjects() async {
    var data = await _apiManager.get(url: 'projects');
    _projects = SuperModel.fromJson({'reports': data}).reports ?? [];
    notifyListeners();
  }

  void updateReport() async {
    if (_reportModel.id == null) {
      var data =
          await _apiManager.post(url: 'event', param: _reportModel.toJson());
      _reportModel = ReportModel.fromJson(data);
    } else {
      var data = await _apiManager.put(
          url: 'event/' + _reportModel.id.toString(),
          param: _reportModel.toJson());
      _reportModel = ReportModel.fromJson(data);
    }
  }

  void addCriteria(String label) {
    var isExist =
        _reportModel.criteria?.where((element) => element.name == label);
    print(isExist?.length);
    if (isExist != null && isExist.isEmpty) {
      var criteria = Criteria(name: label);
      _reportModel.criteria?.add(criteria);
      notifyListeners();
    }
  }

  void removeCriteria(String label) {
    _reportModel.criteria?.removeWhere((element) => element.name == label);
    notifyListeners();
  }

  void updateStatus() async {
    if (_reportModel.id == null) {
      updateReport();
    }

    var data = await _apiManager
        .post(url: 'event/' + (_reportModel.id ?? "") + '/status', param: {});
    _reportModel.status = data['status'];
    notifyListeners();
  }
}
