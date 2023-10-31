import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_example_test/PlatFormMethod.dart';

class ApiService {
  static const _base_url = "https://oversea.pre.en-plus.cn/EuChargeApp/";
  static const brands_url = "app/v1/global/brands";

  static final dio = Dio();

  static void configureDio() {
    // Update default configs.
    var timezone = "";
    _getLocalTimeZone().then((value) => timezone = value);
    var options =  BaseOptions(
      baseUrl: _base_url,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),

      // 10s
      headers: {
        "fromApp": 'Evchargo',
        'Accept-Language': 'en',
        'timeZoneStr': timezone,
        'clientType': 'ANDROID',
        'clientVersion': '2.1.1',
      },
      contentType: Headers.jsonContentType,
      // Transform the response data to a String encoded with UTF8.
      // The default value is [ResponseType.JSON].
      responseType: ResponseType.plain,
    );
    dio.options = options;
  }

  static Future<String> _getLocalTimeZone() async {
    var zoneId = await callNativeMethod("getLocalTimezone");
    return zoneId;
  }
}