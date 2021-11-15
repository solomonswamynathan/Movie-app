import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/error_model.dart';

import '../helper/dialog_helper.dart';
import '../services/app_exceptions.dart';

class BaseController {
  void handleError(error) {
    hideLoading();
    if (error is BadRequestException) {
      //Show dialog
      var message = ErrorModel.fromJson(json.decode(error.message));
      DialogHelper.showErrorDialog(
          title: "",
          description: message.message,
          dialogType: DialogType.ERROR);
    } else if (error is FetchDataException) {
      //Show dialog
      var message = ErrorModel.fromJson(json.decode(error.message));
      DialogHelper.showErrorDialog(
          title: "",
          description: message.message,
          dialogType: DialogType.ERROR);
    } else if (error is ApiNotRespondingException) {
      //Show dialog
      // var message = error.message;
      var message = ErrorModel.fromJson(json.decode(error.message));
      DialogHelper.showErrorDialog(
          title: "",
          description: message.message,
          dialogType: DialogType.ERROR);
    } else if (error is UnAuthorizedException) {
      //Show dialog
      // var message = error.message;
      var message = ErrorModel.fromJson(json.decode(error.message));
      DialogHelper.showErrorDialog(
          title: "",
          description: message.message,
          dialogType: DialogType.ERROR);
    } else if (error is NumberAlreadyExistException) {
      //Show dialog
      // var message = error.message;
      var message = ErrorModel.fromJson(json.decode(error.message));
      DialogHelper.showErrorDialog(
          title: "",
          description: message.message,
          dialogType: DialogType.ERROR);
    } else if (error is FormatException) {
      //Show dialog
      // var message = error.message;
      var message = ErrorModel.fromJson(json.decode(error.message));
      DialogHelper.showErrorDialog(
          title: "",
          description: message.message,
          dialogType: DialogType.ERROR);
    } else {
      var message = ErrorModel.fromJson(json.decode(error.message));
      DialogHelper.showErrorDialog(
          title: "",
          description: message.message,
          dialogType: DialogType.ERROR);
    }
  }

  showToast({@required String? title, @required String? message}) {
    DialogHelper.showToast(title: title, message: message);
  }

  showLoading() {
    DialogHelper.showLoading();
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }
}
