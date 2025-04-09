import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String? errorMassage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    this.errorMassage = 'Something went wrong',
  });
}

class NetworkClient {
  static final Logger _logger = Logger();

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await get(uri);
      if (response.statusCode == 200) {
        final jsonDecodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: jsonDecodedData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final jsonDecodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: jsonDecodedData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  static void _preRequestLog(String url, {Map<String, dynamic>? body}) {
    _logger.i('url: $url\nbody: $body');
  }

  static void _postRequestLog(
    String url,
    int statusCode, {
    Map<String, dynamic>? headers,
    dynamic responseBody,
    dynamic errorMessage,
  }) {
    if (errorMessage != null) {
      _logger.e('''
                url: $url\n
                statusCode: $statusCode\n
                errorMessage: $errorMessage''');
    } else {
      _logger.i('''
                url: $url\n
                statusCode: $statusCode\n
                body: $responseBody''');
    }
  }
}
