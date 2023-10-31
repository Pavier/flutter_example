import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../PlatFormMethod.dart';
/// dio网络请求配置表 自定义
class DioConfig {
  static const baseURL = 'https://oversea.pre.en-plus.cn/EuChargeApp/'; //域名
  static const timeout = Duration(seconds: 10); //超时时间
}
// 网络请求工具类
class DioRequest {
  late Dio dio;
  static DioRequest? _instance;
  static String? _zoneId;
  /// 构造函数
  DioRequest()  {
    dio = Dio();
    dio.options = _getOptions();
    /// 请求拦截器 and 响应拦截机 and 错误处理
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      debugPrint("\n================== 请求数据 ==========================");
      debugPrint("url = ${options.uri.toString()}");
      debugPrint("headers = ${options.headers}");
      debugPrint("params = ${options.data}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      debugPrint("\n================== 响应数据 ==========================");
      debugPrint("code = ${response.statusCode}");
      debugPrint("data = ${response.data}");
      debugPrint("\n");
      handler.next(response);
    }, onError: (DioError e, handler) {
      debugPrint("\n================== 错误响应数据 ======================");
      debugPrint("type = ${e.type}");
      debugPrint("message = ${e.message}");
      debugPrint("\n");
      return handler.next(e);
    }));
  }

  static _getOptions() {
    return BaseOptions(
        baseUrl: DioConfig.baseURL,
        connectTimeout: DioConfig.timeout,
        sendTimeout: DioConfig.timeout,
        receiveTimeout: DioConfig.timeout,
        contentType: 'application/json; charset=utf-8',
        headers: {
          "fromApp": 'Evchargo',
          'Accept-Language': 'en',
          'timeZoneStr': _zoneId,
          'clientType': 'ANDROID',
          'clientVersion': '2.1.1',
        });
  }

  static DioRequest getInstance() {
    return _instance ??= DioRequest();
  }

  static initLocalTimeZone()  {
    // String zoneId = await callNativeMethod("getLocalTimezone");
    callNativeMethod("getLocalTimezone").then((value) {
      debugPrint("initLocalTimeZone ---->  $value");
      _zoneId = value;
    });
    // debugPrint("zoneId -----> $zoneId");
    // return zoneId;
  }
}