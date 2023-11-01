import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_example_test/utils/SharedPrefsUtils.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/router_report.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var arg = route.settings.arguments as Map<String,dynamic>;
    debugPrint("$arg  更新语言---> zh");
    var local = arg['local'] ?? 'zh';

    // SharedPreferences.getInstance().then((prefs) {
    //   var cacheLocal = prefs.getString("local");
    //   debugPrint("$arg  更新语言---> cacheLocal: $cacheLocal   local $local");
    //   if(local != cacheLocal){
    //     debugPrint("-------开始更新-----");
    //     prefs.setString('local', local);
    //     Get.updateLocale(Locale(local));
    //   }
    // });
    if(SharedPrefsUtils.getString("local") != local){
      SharedPrefsUtils.setString('local', local);
      Get.updateLocale(Locale(local));
    }

  }
}