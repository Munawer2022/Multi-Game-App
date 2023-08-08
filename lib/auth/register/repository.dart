import 'dart:io';

import 'package:animation/auth/login/base_api_services.dart';
import 'package:animation/auth/register/base_api_services.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class RegisterRepository implements RegisterBaseApiServices {
  @override
  Future<dynamic> registerPostApiResponse(dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse('http://10.0.2.2:8000/api/register'),
        body: data,
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
}

dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 201:
      dynamic responseJson = jsonDecode(response.body);

      return responseJson;
    case 200:
      throw BadRequestException(response.body);
    case 500:
    case 404:
      throw UnauthorisedException(response.body);
    default:
      throw FetchDataException(
          'Error accured while communicating with server ${response.statusCode.toString()}');
  }
}

class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'No Internet Connection');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, 'Unauthorised request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Inpit');
}
