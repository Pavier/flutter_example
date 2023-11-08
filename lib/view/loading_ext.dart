
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// easy_loading 扩展工具类


/// 显示loading 弹窗
/// [status] 提示文案
/// [dismissOnTap] 是否可点击
showLoading({String? status,bool? dismissOnTap,}){
  EasyLoading.show(status: status,dismissOnTap: dismissOnTap);
}

/// 显示错误 弹窗
/// [status] 提示文案
/// [duration] 显示时长
/// [dismissOnTap] 是否可点击
showError(String status, {
  Duration? duration,
  bool? dismissOnTap,
}){
  EasyLoading.showError(status,duration: duration,dismissOnTap: dismissOnTap);
}

/// 显示成功 弹窗
/// [status] 提示文案
/// [duration] 显示时长
/// [dismissOnTap] 是否可点击
showSuccess(String status, {
  Duration? duration,
  bool? dismissOnTap,
}){
  EasyLoading.showSuccess(status,duration: duration,dismissOnTap: dismissOnTap);
}

dismiss({bool animation = true,}){
  EasyLoading.dismiss(animation: animation);
}

Map<String,EasyLoadingStatusCallback> _loadingStatusCallbackMap =  {};

/// 添加状态监听器
addStatusCallback(String key,void Function(EasyLoadingStatus status)? callback){
  if(callback == null) {
    return ;
  }
  _loadingStatusCallbackMap.putIfAbsent(key, () => callback);
  EasyLoading.addStatusCallback(callback);
}

/// 移除状态监听器
removeStatusCallback({String? key,void Function(EasyLoadingStatus status)? callback}){
  if(key != null && _loadingStatusCallbackMap[key] != null){
    EasyLoading.removeCallback(_loadingStatusCallbackMap[key]!);
    _loadingStatusCallbackMap.remove(key);
  }else if(callback != null){
    EasyLoading.removeCallback(callback);
    _loadingStatusCallbackMap.removeWhere((key, value) => value == callback);
  }else {
    _loadingStatusCallbackMap.clear();
    EasyLoading.removeAllCallbacks();
  }

}
