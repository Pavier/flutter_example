import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

class AppLifecycleObserver with GlobalPageVisibilityObserver {
  @override
  void onBackground(Route route) {
    super.onBackground(route);
    print("AppLifecycleObserver - onBackground");
  }

  @override
  void onForeground(Route route) {
    super.onForeground(route);
    print("AppLifecycleObserver - onForground");
  }

  @override
  void onPagePush(Route route) {
    super.onPagePush(route);
    // RouterReportManager.reportCurrentRoute(route);
    print("AppLifecycleObserver - onPagePush");
  }

  @override
  void onPagePop(Route route) {
    super.onPagePop(route);
    // RouterReportManager.reportRouteDispose(route);
    print("AppLifecycleObserver - onPagePop");
  }

  @override
  void onPageHide(Route route) {
    super.onPageHide(route);
    print("AppLifecycleObserver - onPageHide");
  }

  @override
  void onPageShow(Route route) {
    super.onPageShow(route);
    print("AppLifecycleObserver - onPageShow");
  }
}