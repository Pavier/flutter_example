import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_example_test/PlatFormMethod.dart';
import 'package:flutter_example_test/lang/translation_service.dart';
import 'package:flutter_example_test/listener/AppLifecycleObserver.dart';
import 'package:flutter_example_test/network/ApiService.dart';
import 'package:flutter_example_test/network/DioRequest.dart';
import 'package:flutter_example_test/page/ListPage.dart';
import 'package:flutter_example_test/page/NetworkPage.dart';
import 'package:flutter_example_test/page/ThirdPage.dart';
import 'package:flutter_example_test/page/secondPage.dart';
import 'package:flutter_example_test/utils/SharedPrefsUtils.dart';
import 'package:get/get.dart';

void main(){
  PageVisibilityBinding.instance.addGlobalObserver(AppLifecycleObserver());
  CustomFlutterBinding();
  debugPrint("flutter ---  main()");
  // ApiService.configureDio();
  DioRequest.initLocalTimeZone();
  runApp(const MyApp());
}

///创建一个自定义的Binding，继承和with的关系如下，里面什么都不用写
class CustomFlutterBinding extends WidgetsFlutterBinding with BoostFlutterBinding {}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: "Flutter Demo",
//       home:MyHomePage(title: "title")
//     );
//   }
// }


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static Map<String, FlutterBoostRouteFactory> routerMap = {
    "/":(settings, uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_){
        return const MyHomePage(title: "Flutter Demo Home");
      });
    },
    "homePage":(settings, uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_){
        return const MyHomePage(title: "Flutter Demo Home");
      });
    },
    "secondPage": (settings,uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_){
        Map<String,dynamic> map =settings.arguments as Map<String,dynamic>;
        var data = map["data"];
        return SecondPage(data: data);
      });
    },
    "thirdPage": (settings,uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_){
        Map<String,dynamic> map =settings.arguments as Map<String,dynamic>;
        var data = map["data"];
        return ThirdPage(data: data);
      });
    },
    "listPage": (settings,uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_){
        return ListPage();
      });
    },
    "networkPage": (settings,uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_){
        return NetworkPage();
      });
    },

  };

  Route<dynamic>? routeFactory(RouteSettings settings, String? uniqueId) {
    FlutterBoostRouteFactory? func = routerMap[settings.name!];
    if (func == null) {
      return null;
    }
    return func(settings, uniqueId);
  }

  // Widget appBuilder(Widget home) {
  //   return MaterialApp(
  //     home: home,
  //     debugShowCheckedModeBanner: true,
  //
  //     ///必须加上builder参数，否则showDialog等会出问题
  //     builder: (_, __) {
  //       return home;
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(
      routeFactory,
      appBuilder: (child) => GetMaterialApp(
        translations: TranslationService(),
        locale: const Locale('zh','CN'),
        fallbackLocale: const Locale('zh','CN'),
        home: child,
      ),
    );
  }


}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  final _sum = 0.obs;
  final _sub = 0.obs;
  final _result = "".obs;

  void _incrementCounter() {
    _sum.value++;
    _sub.value--;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    debugPrint("测试日志打印");
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Obx(() =>
                Text(
                  'result:$_result',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.red,
                  ),
                ),
            ),
            Text(
              'test'.tr,
            ),
            InkWell(
              child: Obx(() =>
                  Column(
                    children: [
                      Text(
                        '$_sum',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        '$_sub',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  )
              ),
              onTap: () {
                // BoostNavigator.instance.push("thirdPage",arguments: {"data":"flutter 内部跳转,等待参数回传"});
                BoostNavigator.instance.push("thirdPage",arguments: {"data":"flutter 内部跳转,等待参数回传"},
                    withContainer: true, opaque: false).then((value) {
                      var map = value as Map;
                      String data = map['pop'];
                      debugPrint("result = pop = $data");
                      _result.value = data;
                });
              }
            ),
            ElevatedButton(onPressed: () => {
              BoostNavigator.instance.push("secondPage",arguments: {"data":"flutter 内部跳转"})
            }, child: const Text('第二个页面')),
            ElevatedButton(onPressed: () => {
              callNativeMethod("showLoading", {"msg" : "加载中"}),
              Future.delayed(const Duration(seconds: 5)).then((v){
                callNativeMethod("dismissLoading");
            })
            }, child: const Text('调用native中的方法')),
            ElevatedButton(onPressed: () => {
              BoostNavigator.instance.push("listPage")
            }, child: const Text('打开列表页面')),
            ElevatedButton(onPressed: () => {
            SharedPrefsUtils.setString('local', 'en'),
              Get.updateLocale(const Locale('en'))
            }, child: const Text('切换英文'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


