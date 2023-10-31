import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

class ThirdPage extends StatelessWidget {
  final String data;
  const ThirdPage({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      pop();
      return false;
    }, child: Scaffold(
      appBar: AppBar(
        title: const Text("ThirdPage"),

      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('页面接收参数 data: $data '),
              ElevatedButton(onPressed: () => {
                pop()
              }, child: const Text('关闭'))
            ],
          )
      ),
    ));
  }

  void pop(){
    BoostNavigator.instance.pop({'pop':'ThirdPage 回传参数'});
  }
}
