import 'dart:convert';

import 'package:eco/api/api_manager.dart';
import 'package:eco/models/city_model.dart';
import 'package:eco/models/super_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final APIManager _apiManager = APIManager();
  String _city = '';

  List<CityModel> _cities = [];

  String get city => _city;

  List<CityModel> get cities => _cities;

  void getCity(city) async {
    print(city);
    var cities = await _apiManager.get(url: 'city?q=$city');
    // print();
    print('1');
    _cities = SuperModel.fromJson({"cities":cities}).cities ?? [];
    _city = city;
    notifyListeners();
  }


}
