import 'dart:convert';

import 'package:eco/api/api_manager.dart';
import 'package:eco/models/city_model.dart';
import 'package:eco/models/super_model.dart';
import 'package:eco/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class UserProvider extends ChangeNotifier {
  final APIManager _apiManager = APIManager();
  final LocalStorage storage = LocalStorage('user-eco');
  UserProvider(){
    getToken();
  }

  String _city = '';
  String? _error;

  User? _user;

  List<CityModel> _cities = [];

  bool _isAuth = false;

  String get city => _city;

  String? get error => _error;

  User? get user => _user;

  List<CityModel> get cities => _cities;

  bool get isAuth => _isAuth;

  Future login({required String username, required String password}) async {
    print('lol');
    var data = await _apiManager.post(
        url: 'auth/login', param: {"username": username, "password": password});
    if (data != null && data['error'] != null) {
      if (data['error'] == 'WRONG_PASSWORD') {
        _error = 'WRONG_PASSWORD';
      }
      notifyListeners();
      return;
    }
    await storage.ready;
    await storage.setItem('access_token', data['access_token']);
    _isAuth = true;
    getProfile();
    notifyListeners();
  }

  void logout() async {
    await storage.ready;
    await storage.deleteItem('access_token');
    _isAuth = false;
    notifyListeners();
  }

  void getToken() async {
    await storage.ready;
    print(await storage.getItem('access_token'));
    if ((await storage.getItem('access_token')) != null) {
      _isAuth = true;
    }

    notifyListeners();
  }

  void getProfile() async {
    var profile = await _apiManager.get(url: 'users/profile');
    _user = User.fromJson(profile);
    print(profile);
    // _isAuth = true;
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

  void setUser(
      {String? id,
      String? name,
      String? email,
      String? password,
      String? busyness,
      String? city}) {
    if (id != null) {
      _user?.id = id;
    }
    if (name != null) {
      _user?.name = name;
    }
    if (email != null) {
      _user?.email = email;
    }
    if (password != null) {
      _user?.password = password;
    }
    if (city != null) {
      _user?.password = city;
    }

    if (busyness != null) {
      _user?.busyness = busyness;
    }

    notifyListeners();
  }

  void register(
      {required String username,
      required String password,
      String? busyness,
      required String name,
      String? city}) async {
    var data = await _apiManager.post(url: 'auth/register', param: {
      "email": username,
      "password": password,
      "busyness": busyness,
      "name": name,
      "city": city
    });
    await storage.ready;
    await storage.setItem('access_token', data['access_token']);
    _isAuth = true;
    getProfile();
  }
}
