import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:get/get.dart';

class SecondPage extends StatelessWidget {
  final String data;
  const SecondPage({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    Get.put(SecondController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("SecondPage"),

      ),
      body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('页面接收参数 data: $data '),
                ElevatedButton(onPressed: () => {
                  BoostNavigator.instance.pop(context)
                }, child: const Text('关闭'))
              ],
            )
        ),
    );
  }
}

class SecondController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("SecondController onClose");
  }
}
