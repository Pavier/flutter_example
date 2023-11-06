import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_example_test/PlatFormMethod.dart';
import 'package:flutter_example_test/listener/AppLifecycleObserver.dart';
import 'package:flutter_example_test/network/DioRequest.dart';
import 'package:flutter_example_test/page/ListPage.dart';
import 'package:flutter_example_test/page/NetworkPage.dart';
import 'package:flutter_example_test/page/ScreenAdapterPage.dart';
import 'package:flutter_example_test/page/ThirdPage.dart';
import 'package:flutter_example_test/page/secondPage.dart';
import 'package:flutter_example_test/utils/SharedPrefsUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_example_test/event/EventBus.dart';

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

  final Map<String, FlutterBoostRouteFactory> _routerMap = {
    "/":(settings, uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_) {
        return BoostCacheWidget(
            uniqueId: uniqueId!,
            builder: (_) => const MainPage()
        );
      });
    },
    "homePage":(settings, uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_) {
        return BoostCacheWidget(
            uniqueId: uniqueId!,
            builder: (_) => const MyHomePage(title: "Flutter Demo Home")
        );
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
        return const ListPage();
      });
    },
    "networkPage": (settings,uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_){
        return const NetworkPage();
      });
    },
    "screenAdaptPage": (settings,uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_){
        return const ScreenAdapterPage();
      });
    },

  };

  static _AppSetting setting = _AppSetting();


  Route<dynamic>? routeFactory(RouteSettings settings, String? uniqueId) {
    FlutterBoostRouteFactory? func = _routerMap[settings.name!];
    if (func == null) {
      return null;
    }
    return func(settings, uniqueId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bus.on('local', (arg) {
      setting.changeLocale!(Locale(arg));
    });
    setting.changeLocale = (Locale locale) {
      setState(() {
        setting._locale = locale;
      });
    };
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bus.off('local');
    super.dispose();
  }

  Widget appBuilder(Widget home) {
    return MaterialApp(
      home: home,
      debugShowCheckedModeBanner: true,
      localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
        var result = supportedLocales.where((element) => element.languageCode == locale?.languageCode);
        if (result.isNotEmpty) {
          return locale;
        }
        return Locale('zh');
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: setting._locale,
      // routes: {
      //   "/" : (_) => const MainPage(),
      //   "homePage" : (_) => const MyHomePage(title: "Flutter Demo Home")
      // },

      ///必须加上builder参数，否则showDialog等会出问题
      builder: (context, __) {
        ScreenUtil.init(context);
        return Theme(
            data: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(bodySmall: TextStyle(fontSize: 30.sp)),
            ),
            child: home);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //     debugShowCheckedModeBanner: true,
    //     translations: TranslationService(),
    //     locale: const Locale('zh','CN'),
    //     fallbackLocale: const Locale('zh','CN'),
    //     getPages: [
    //       GetPage(name: "/", page: () => const MyHomePage(title: "GetPage home")),
    //       GetPage(name: "/second", page: () => const SecondPage(data: "",)),
    //       GetPage(name: "/third", page: () => const ThirdPage(data: "{data}")),
    //       GetPage(name: "/network", page: () => const NetworkPage()),
    //       GetPage(name: "/screen", page: () => const ScreenAdapterPage()),
    //     ],
    // );
    return FlutterBoostApp(
      routeFactory,
      appBuilder: appBuilder
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
    debugPrint("测试日志打印");
    Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
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
              "${AppLocalizations.of(context)?.helloWorld}",
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
              _MyAppState.setting.changeLocale!(Locale('en'))
            }, child: const Text('切换英文')),
            ElevatedButton(onPressed: () => {
            SharedPrefsUtils.setString('local', 'zh'),
              _MyAppState.setting.changeLocale!(Locale('zh'))
            }, child: const Text('切换中文')),
            ElevatedButton(onPressed: () => {
              BoostNavigator.instance.push("screenAdaptPage")
            }, child: const Text('打开屏幕适配页面'))
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

class HomeController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("HomeController onClose");

  }
}


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter主页面"),
      ),
      body: Center(
        child:  ElevatedButton(onPressed: () => {
          BoostNavigator.instance.push("homePage")
        }, child: const Text('打开主页面')),
      ),
    );
  }
}


class _AppSetting {
  _AppSetting(): _locale = Locale(SharedPrefsUtils.getString('local') ?? 'zh');

  Function(Locale locale)? changeLocale;
  Locale _locale;

}