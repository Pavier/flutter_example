
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_test/entity/base_response.dart';
import 'package:flutter_example_test/network/DioRequest.dart';

void get<T>(String url,
    {Map<String, dynamic>? params,
    CancelToken? cancelToken,
    BuildContext? context,
    T? Function(dynamic)? fromJsonFun,
    Function? successCallBack,
    Function? errorCallBack}) async{
  Response response;
  try{
    response = await DioRequest.getInstance().dio.get(url,queryParameters: params,cancelToken: cancelToken);
    _parseResult(response,fromJsonFun,successCallBack,errorCallBack);
  }on DioException catch(e){
    handlerError(e);
    errorCallBack?.call();
  }on Exception {
    errorCallBack?.call();
  }
}

void post<T>(String url,
    {Map<String, dynamic>? params,
      CancelToken? cancelToken,
      BuildContext? context,
      T? Function(dynamic)? fromJsonFun,
      Function? successCallBack,
      Function? errorCallBack}) async{
  Response response;
  try{
    response = await DioRequest.getInstance().dio.post(url,queryParameters: params,cancelToken: cancelToken);
    _parseResult(response,fromJsonFun,successCallBack,errorCallBack);
  }on DioException catch(e){
    handlerError(e);
    errorCallBack?.call();
  }on Exception {
    errorCallBack?.call();
  }
}

void put<T>(String url,
    {Map<String, dynamic>? params,
      CancelToken? cancelToken,
      BuildContext? context,
      T? Function(dynamic)? fromJsonFun,
      Function? successCallBack,
      Function? errorCallBack}) async{
  Response response;
  try{
    response = await DioRequest.getInstance().dio.put(url,queryParameters: params,cancelToken: cancelToken);
    _parseResult(response,fromJsonFun,successCallBack,errorCallBack);
  }on DioException catch(e){
    handlerError(e);
    errorCallBack?.call();
  }on Exception {
    errorCallBack?.call();
  }
}

_parseResult<T>(Response response,T? Function(dynamic)? fromJsonFun,Function? successCallBack,
    Function? errorCallBack){
  if(response.data != null){
    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    switch(baseResponse.code){
      case 2000 : {
        if(fromJsonFun != null){
          var data = fromJsonFun(baseResponse.data) as T;
          successCallBack?.call(data);
        }else {
          successCallBack?.call(baseResponse.data);
        }
      }
      default : {
        errorCallBack?.call();
      }
    }
  }else {
    errorCallBack?.call("网络出错啦，请稍后重试");
  }
}

downloadFile(urlPath, savePath,Function? successCallBack,
    Function? errorCallBack) async {
  Response response;
  try {
    response = await DioRequest.getInstance().dio.download(urlPath, savePath,onReceiveProgress: (int count, int total){
      //进度
      print("$count $total");
    });
    print('downloadFile success---------${response.data}');
    successCallBack?.call(response.data);
  } on DioException catch (e) {
    print('downloadFile error---------$e');
    handlerError(e);
    errorCallBack?.call();
  }
}

handlerError(DioException e) {
  if (e.type == DioExceptionType.connectionTimeout) {
    print("连接超时");
  } else if (e.type == DioExceptionType.sendTimeout) {
    print("请求超时");
  } else if (e.type == DioExceptionType.receiveTimeout) {
    print("响应超时");
  } else if (e.type == DioExceptionType.badResponse) {
    print("响应异常");
  } else if (e.type == DioExceptionType.cancel) {
    print("请求取消");
  } else {
    print("未知错误");
  }
}