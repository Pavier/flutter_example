
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_example_test/view/error_view.dart';
import 'package:flutter_example_test/view/loading_view.dart';
import 'package:flutter_example_test/view/success_view.dart';

void configEasyLoading(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black.withOpacity(0.6)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.transparent
    ..userInteractions = false
    ..indicatorWidget = const LoadingView()
    ..errorWidget = const ErrorView()
    ..successWidget = const SuccessView()
    ..boxShadow = []
    ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();
}