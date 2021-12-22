import 'dart:convert';

import 'package:eco/api/api_manager.dart';
import 'package:eco/models/city_model.dart';
import 'package:eco/models/super_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final APIManager _apiManager = APIManager();
  String _city = '';

  List<CityModel> _cities = [];

  bool _isAuth = false;

  String get city => _city;

  List<CityModel> get cities => _cities;

  bool get isAuth => _isAuth;

  void login() {
    print('lol');
    _isAuth = true;
    notifyListeners();
  }

  void logout() {
    _isAuth = false;
    notifyListeners();
  }

  void getToken() {
    _isAuth = true;
    notifyListeners();
  }

  void getCity(city) async {
    print(city);
    var cities = await _apiManager.get(url: 'city?q=$city');
    // print();
    print('1');
    _cities = SuperModel.fromJson({"cities": cities}).cities ?? [];
    _city = city;
    notifyListeners();
  }
}
