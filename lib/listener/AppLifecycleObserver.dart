import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/router_report.dart';

class AppLifecycleObserver with GlobalPageVisibilityObserver {
  @override
  void onBackground(Route route) {
    super.onBackground(route);
    debugPrint("AppLifecycleObserver - onBackground");
  }

  @override
  void onForeground(Route route) {
    super.onForeground(route);
    debugPrint("AppLifecycleObserver - onForground");
  }

  @override
  void onPagePush(Route route) {
    super.onPagePush(route);
    RouterReportManager.reportCurrentRoute(route);
    debugPrint("AppLifecycleObserver - onPagePush");
  }

  @override
  void onPagePop(Route route) {
    super.onPagePop(route);
    RouterReportManager.reportRouteDispose(route);
    debugPrint("AppLifecycleObserver - onPagePop");
  }

  @override
  void onPageHide(Route route) {
    super.onPageHide(route);
    debugPrint("AppLifecycleObserver - onPageHide");
  }

  @override
  void onPageShow(Route route) {
    super.onPageShow(route);
    debugPrint("AppLifecycleObserver - onPageShow");
    debugPrint("更新语言---> zh");
    Get.updateLocale(const Locale('zh','CN'));
  }
}