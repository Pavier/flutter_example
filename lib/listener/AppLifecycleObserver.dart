import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_example_test/event/EventBus.dart';
import 'package:flutter_example_test/utils/SharedPrefsUtils.dart';
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
    var name = route.settings.name;
    debugPrint("AppLifecycleObserver - onPagePush  --- $name");
    if(route.settings.arguments is Map<String,dynamic>){
      var arg = route.settings.arguments as Map<String,dynamic>;
      debugPrint("$arg  更新语言---> zh");
      var local = arg['local'];

      if(local != null && SharedPrefsUtils.getString("local") != local){
        SharedPrefsUtils.setString('local', local);
        bus.emit('local',local);
      }
    }
  }

  @override
  void onPagePop(Route route) {
    super.onPagePop(route);
    RouterReportManager.reportRouteDispose(route);
    var name = route.settings.name;
    debugPrint("AppLifecycleObserver - onPagePop  --- $name");
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
  }
}