// 创建平台通道
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const platform = MethodChannel('com.example.myChannel');

// 调用Android原生方法
Future<dynamic> callNativeMethod(String methodName,[Map<String, dynamic>? arguments]) async {
  try {
    // 调用Android原生方法，并传递参数（如果有）
    return await platform.invokeMethod(methodName, arguments);

  } catch (e) {
    // 处理错误
    debugPrint('调用原生方法时出错：$e');
  }
}