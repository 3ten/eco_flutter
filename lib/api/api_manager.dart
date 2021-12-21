import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'custom_exception.dart';

// import 'package:connectivity/connectivity.dart';
class ResponseType {
  static const String text = 'text';
  static const String array = 'array';
  static const String json = 'array';
}

class APIManager {
  final String _defaultUrl = "http://188.225.18.212";

  Future<dynamic> post(
      {required String url,
      Map? param,
        List? arrayParams,
      String responseType = ResponseType.json}) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    dynamic responseJson;
    try {
      var uri = Uri.parse(_defaultUrl + url);
      final response = await http.post(uri, body: param??arrayParams);
      responseJson = _response(response, responseType);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get( {required String url,
    Map? param,
    String responseType = ResponseType.json}) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    dynamic responseJson;
    try {
      var uri = Uri.parse(_defaultUrl + url);
      final response = await http.get(uri);
      responseJson = _response(response,responseType);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete( {required String url,
    Map? param,
    String responseType = ResponseType.json}) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    dynamic responseJson;
    try {
      var uri = Uri.parse(_defaultUrl + url);
      final response = await http.post(uri, body: param);
      responseJson = _response(response,responseType);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response, String type) {
    switch (response.statusCode) {
      case 200:
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
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}
