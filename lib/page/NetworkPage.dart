import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_test/PlatFormMethod.dart';
import 'package:get/get.dart';
import '../network/ApiService.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {

  final _response = "".obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("网络请求示例"),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Obx(() => Text(_response.value)),
                ),
                ElevatedButton(onPressed: () => {
                  // 网络请求
                  callNativeMethod("showLoading", {"msg":"请求中..."}),
                  requestBrands()
                }, child: const Text('调用'))

              ]
            )
          ),
        )
    );
  }

  void requestBrands() async{
    String url = ApiService.brands_url;
    var requestStr = ApiService.dio.options.headers.toString();

    final response = await ApiService.dio.get(url);
    _response.value = "$requestStr\n$response";
    callNativeMethod("dismissLoading");
  }
}
