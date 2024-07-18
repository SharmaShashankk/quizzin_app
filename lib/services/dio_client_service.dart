// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizzin_app/utils/base_url.dart';
import 'package:quizzin_app/utils/globals.dart';


class DioClientServices {
  DioClientServices._();
  static final DioClientServices instance = DioClientServices._();

  factory DioClientServices() => instance;

  final Dio _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30)));

  Future dioPostCall(
    BuildContext context, {
    bool headerData = true,
    required dynamic bodyTag,
    required String url,
    required bool? isLoading,
    bool isImageUpload =  false,
  }) async {
    try {
      isLoading = true;
      FormData formData = FormData.fromMap(bodyTag);
      Response response = await _dio.post(
        (commonBaseUrl + url),
        data: formData,
        options: Options(
            headers: headerData
                ? {
                    "Accept": "application/json",
                    "Authorization": "Bearer $token"
                  }
                : null),
      );
      isLoading = false;
      return response.data;
    } on DioError catch (e) {
      isLoading = true;
      log("${e.response?.statusCode}", name: "Exception response null");
      if (e.response?.statusCode == 401) {
        if (e.response != null && e.response?.data['status'] == 3) {
          // dataClear(context);
          // showCustomFlushbar(context, message: "Multiple Login Found");
        }
      }

      if (e.response == null) {
        log("$e", name: "Exception response null");
        if (e.type == DioErrorType.connectionError ||
            e.type == DioErrorType.connectionTimeout) {
          // showCustomFlushbar(context,
          //     message: AppLocalizations.of(context)!.internet_check);
        }
      } else if (e.response != null) {
        log('Dio error!', name: "dioGetCall");
        log('STATUS: ${e.response?.statusCode}', name: "dioGetCall");
        log('DATA: ${e.response?.data}', name: "dioGetCall");
        log('HEADERS: ${e.response?.headers}', name: "dioGetCall");
      } else if (e.type == DioErrorType.receiveTimeout) {
      } else {
        log('Error sending request!', name: "dioGetCall");
        log("${e.message}", name: "dioGetCall");
      }
    }
  }

  Future dioGetCall(
    BuildContext context, {
    required String url,
    bool headerData = true,
  }) async {
    try {
      Response response = await _dio.get(
        (commonBaseUrl + url),
        options: Options(
            headers: headerData
                ? {
                    "Accept": "application/json",
                    "Authorization": "Bearer $token"
                  }
                : null),
      );
      return response.data;
    } on DioError catch (e) {
      log("${e.response?.statusCode}", name: "Exception response null");
      if (e.response?.statusCode == 401) {
        if (e.response != null && e.response?.data['status'] == 3) {
          // dataClear(context);
          // showCustomFlushbar(context, message: "Multiple Login Found");
        }
      }
      if (e.response == null) {
        log("$e", name: "Exception response null");
        if (e.type == DioErrorType.connectionError ||
            e.type == DioErrorType.connectionTimeout) {
          // showCustomFlushbar(context,
          //     message: AppLocalizations.of(context)!.internet_check);
        }
      } else if (e.response != null) {
        log('Dio error!', name: "dioGetCall");
        log('STATUS: ${e.response?.statusCode}', name: "dioGetCall");
        log('DATA: ${e.response?.data}', name: "dioGetCall");
        log('HEADERS: ${e.response?.headers}', name: "dioGetCall");
      } else if (e.type == DioErrorType.receiveTimeout) {
      } else {
        log('Error sending request!', name: "dioGetCall");
        log("${e.message}", name: "dioGetCall");
      }
    }
  }
}
