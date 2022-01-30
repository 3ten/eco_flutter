import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';

import 'custom_exception.dart';

// import 'package:connectivity/connectivity.dart';
class ResponseType {
  static const String text = 'text';
  static const String array = 'array';
  static const String json = 'array';
}

class APIManager {
  final String _defaultUrl = "http://188.225.18.212/";
  final LocalStorage storage = LocalStorage('user-eco');

  Future<dynamic> post(
      {required String url,
      Map? param,
      List? arrayParams,
      String responseType = ResponseType.json}) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    dynamic responseJson;
    try {
      await storage.ready;
      var accessToken = await storage.getItem('access_token');
      var uri = Uri.parse(_defaultUrl + url);
      print('Bearer ' + accessToken.toString());
      final response = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ' + accessToken.toString()
          },
          body: json.encode(param));
      responseJson = _response(response, responseType);
    } catch (e) {
      print(e);
      if (e is SocketException) {
        throw FetchDataException('No Internet connection');
      }
      if (e is UnauthorisedException) {
        print('lol');
        responseJson = {'error': 'WRONG_PASSWORD'};
      }
    }
    return responseJson;
  }

  Future<dynamic> put(
      {required String url,
      Map? param,
      List? arrayParams,
      String responseType = ResponseType.json}) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    dynamic responseJson;
    try {
      await storage.ready;
      var accessToken = await storage.getItem('access_token');
      var uri = Uri.parse(_defaultUrl + url);
      print('Bearer ' + accessToken.toString());
      final response = await http.put(uri,
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ' + accessToken.toString()
          },
          body: json.encode(param));
      responseJson = _response(response, responseType);
    } catch (e) {
      print(e);
      if (e is SocketException) {
        throw FetchDataException('No Internet connection');
      }
      if (e is UnauthorisedException) {
        print('lol');
        responseJson = {'error': 'WRONG_PASSWORD'};
      }
    }
    return responseJson;
  }

  Future<dynamic> get(
      {required String url,
      Map? param,
      String responseType = ResponseType.json}) async {
    print("Calling API: $url");
    print("Calling parameters: $param");
    await storage.ready;
    var accessToken =
        'Bearer ' + (await storage.getItem('access_token')).toString();
    dynamic responseJson;
    try {
      var uri = Uri.parse(_defaultUrl + url);
      final response = await http
          .get(uri, headers: {'authorization': accessToken.toString()});
      responseJson = _response(response, responseType);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(
      {required String url,
      Map? param,
      String responseType = ResponseType.json}) async {
    print("Calling API: $url");
    print("Calling parameters: $param");
    var accessToken = storage.getItem('access_token');
    dynamic responseJson;
    try {
      var uri = Uri.parse(_defaultUrl + url);
      final response = await http
          .post(uri, body: param, headers: {'authorization': accessToken});
      responseJson = _response(response, responseType);
    } catch (e) {
      // if (e is SocketException) {
      //   throw FetchDataException('No Internet connection');
      // }
      if (e is UnauthorisedException) {
        print('lol');
      }
    }
    return responseJson;
  }

  Future<dynamic> postImage(
      {required XFile filename, required String url, String? text}) async {
    // var request = http.MultipartRequest('POST', Uri.parse(_defaultUrl + url));
    await storage.ready;
    var accessToken =
        'Bearer ' + (await storage.getItem('access_token')).toString();
    // request.headers['Authorization'] = accessToken;
    // request.files.add(await http.MultipartFile.fromPath('image', filename));
    // if (text != null) {
    //   request.fields['criteria'] = text;
    // }

    // var res = await request.send();
    print(text);
    var formData = FormData.fromMap({
      'criteria': text,
      'image': MultipartFile.fromBytes(await filename.readAsBytes(),
          filename: filename.name),
    });
    var dio = Dio();
    dio.options.headers["authorization"] = accessToken;
    var response = await dio.post(
      _defaultUrl + url,
      data: formData,
    );

    print(response.data.toString());
    return response.data;
  }

  dynamic _response(http.Response response, String type) {
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      dynamic responseData;
      if (type == ResponseType.json) {
        responseData = json.decode(response.body.toString());
      }
      if (type == ResponseType.text) {
        responseData = response.body.toString();
      }
      if (type == ResponseType.array) {
        responseData = json.decode(response.body.toString());
      }
      return responseData;
    }
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException('Unauthorised');
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}
