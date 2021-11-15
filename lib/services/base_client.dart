import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import './base_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../services/app_exceptions.dart';
// ignore: library_prefixes
import '../app_url.dart' as appURL;
import 'app_exceptions.dart';

class BaseClient with BaseController {
  // ignore: constant_identifier_names
  static const int TIME_OUT_DURATION = 60;

  dynamic _processResponse(http.Response response) {
    hideLoading();
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 204:
        return "no-content";
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 404:
        throw NotFoundException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 409:
        throw NumberAlreadyExistException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code: ${response.statusCode}',
            response.request.toString());
    }
  }

//GET Request
  Future<dynamic> getRequest({@required String? api, dynamic headers}) async {
    var uri = Uri.parse(appURL.baseUrl + api!);
    if (headers == '') {
      headers = {"Content-Type": "application/json; charset=UTF-8"};
    }
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      log(response.body);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responding in time', uri.toString());
    }
  }

  //POST Request
  Future<dynamic> postRequest(
      {String? api, dynamic payloadObj, dynamic headers}) async {
    // showLoading();
    if (headers == '') {
      headers = {"Content-Type": "application/json; charset=UTF-8"};
    }
    var uri = Uri.parse(appURL.baseUrl + api!);
    var payload = json.encode(payloadObj!);

    try {
      var response = await http
          .post(uri, headers: headers, body: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      // hideLoading();
      print(response.statusCode);
      log(payload);
      log(response.body);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responding in time', uri.toString());
    }
  }

  //PUT Request
  Future<dynamic> putRequest(
      {String? api, dynamic payloadObj, dynamic headers}) async {
    // ignore: prefer_typing_uninitialized_variables
    var payload;
    if (headers == '') {
      headers = {"Content-Type": "application/json; charset=UTF-8"};
    }
    var uri = Uri.parse(appURL.baseUrl + api!);
    if (payloadObj != null) {
      payload = json.encode(payloadObj!);
    }

    try {
      var reponse = await http
          .put(
            uri,
            headers: headers,
            body: payload,
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(reponse);
    } on SocketException {
      throw FetchDataException('No internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responding in time', uri.toString());
    }
  }

  Future<dynamic> deleteRequest(
      {String? api, dynamic payloadObj, dynamic headers}) async {
    // ignore: prefer_typing_uninitialized_variables
    var payload;
    if (headers == '') {
      headers = {"Content-Type": "application/json; charset=UTF-8"};
    }
    var uri = Uri.parse(appURL.baseUrl + api!);
    if (payloadObj != null) {
      payload = json.encode(payloadObj!);
    }

    try {
      var reponse = await http
          .delete(
            uri,
            headers: headers,
            body: payload,
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(reponse);
    } on SocketException {
      throw FetchDataException('No internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responding in time', uri.toString());
    }
  }

  Future<dynamic> postFormData(
      {String? api,
      List<FormDataModel>? payloadObj,
      dynamic headers,
      @required bool? fileExist}) async {
    if (headers == '') {
      headers = {"Content-Type": "application/json; charset=UTF-8"};
    }
    var uri = Uri.parse(appURL.baseUrl + api!);
    try {
      var request = http.MultipartRequest("POST", uri);

      if (!fileExist!) {
        for (var i = 0; i < payloadObj!.length; i++) {
          request.fields[payloadObj[i].fieldTitle!] = payloadObj[i].fieldBody!;
        }
      } else {
        for (var i = 0; i < payloadObj!.length - 1; i++) {
          request.fields[payloadObj[i].fieldTitle!] = payloadObj[i].fieldBody!;
        }
      }
      if (fileExist) {
        request.files.add(await http.MultipartFile.fromPath(
            payloadObj[payloadObj.length - 1].fieldTitle!,
            payloadObj[payloadObj.length - 1].fieldBody!));
      }
      var response = await request.send();
      var streamResponse = await http.Response.fromStream(response);

      return _processResponse(streamResponse);
    } on SocketException {
      throw FetchDataException('No internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responding in time', uri.toString());
    }
  }

  Future<dynamic> putFormData(
      {@required String? api,
      @required List<FormDataModel>? payloadObj,
      @required dynamic headers,
      @required bool? fileExist}) async {
    if (headers == '') {
      headers = {"Content-Type": "application/json; charset=UTF-8"};
    }
    var uri = Uri.parse(appURL.baseUrl + api!);
    try {
      var request = http.MultipartRequest("PUT", uri);
      if (!fileExist!) {
        for (var i = 0; i < payloadObj!.length; i++) {
          request.fields[payloadObj[i].fieldTitle!] = payloadObj[i].fieldBody!;
        }
      } else {
        for (var i = 0; i < payloadObj!.length - 1; i++) {
          request.fields[payloadObj[i].fieldTitle!] = payloadObj[i].fieldBody!;
        }
      }
      if (fileExist) {
        request.files.add(await http.MultipartFile.fromPath(
            payloadObj[payloadObj.length - 1].fieldTitle!,
            payloadObj[payloadObj.length - 1].fieldBody!));
      }
      var response = await request.send();
      var streamResponse = await http.Response.fromStream(response);

      return _processResponse(streamResponse);
    } on SocketException {
      throw FetchDataException('No internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responding in time', uri.toString());
    }
  }
}

class FormDataModel {
  String? fieldTitle;
  dynamic fieldBody;

  FormDataModel({@required this.fieldTitle, @required this.fieldBody});

  FormDataModel.fromJson(Map<String, dynamic> json) {
    fieldTitle = json['field_title'];
    fieldBody = json['field_body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['field_title'] = fieldTitle;
    data['field_body'] = fieldBody;
    return data;
  }
}
