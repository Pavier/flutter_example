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

  ///使用 BoostCacheWidget包裹你的页面时，可以解决push pageA->pageB->pageC 过程中，pageA，pageB 会多次 rebuild 的问题
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
        return BoostCacheWidget(
            uniqueId: uniqueId!,
            builder: (_) => SecondPage(data: data)
        );

      });
    },
    "thirdPage": (settings,uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_){
        Map<String,dynamic> map =settings.arguments as Map<String,dynamic>;
        var data = map["data"];
        return BoostCacheWidget(
            uniqueId: uniqueId!,
            builder: (_) => ThirdPage(data: data)
        );
      });
    },
    "listPage": (settings,uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_){
        return BoostCacheWidget(
            uniqueId: uniqueId!,
            builder: (_) => const ListPage()
        );
      });
    },
    "networkPage": (settings,uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_){
        return BoostCacheWidget(
            uniqueId: uniqueId!,
            builder: (_) => const NetworkPage()
        );
      });
    },
    "screenAdaptPage": (settings,uniqueId){
      return CupertinoPageRoute(settings:settings,builder: (_){
        return BoostCacheWidget(
            uniqueId: uniqueId!,
            builder: (_) => const ScreenAdapterPage()
        );
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
                  'result:${HomeController.to.result}',
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
                        '${HomeController.to.sum}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        '${HomeController.to.sub}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  )
              ),
              onTap: () => HomeController.to.navigateToThirdPage()
            ),
            ElevatedButton(onPressed: () => HomeController.to.navigateToSecondPage(), child: const Text('第二个页面')),
            ElevatedButton(onPressed: () => HomeController.to.callMethod(), child: const Text('调用native中的方法')),
            ElevatedButton(onPressed: () => HomeController.to.openListPage(), child: const Text('打开列表页面')),
            ElevatedButton(onPressed: () => HomeController.to.changeLocal('en'), child: const Text('切换英文')),
            ElevatedButton(onPressed: () => HomeController.to.changeLocal('zh'), child: const Text('切换中文')),
            ElevatedButton(onPressed: () => HomeController.to.openScreenAdaptPage(), child: const Text('打开屏幕适配页面'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => HomeController.to.incrementCounter(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final sum = 0.obs;
  final sub = 0.obs;
  final result = "".obs;

  void incrementCounter() {
    sum.value++;
    sub.value--;
  }

  void navigateToSecondPage() {
    BoostNavigator.instance.push("secondPage",arguments: {"data":"flutter 内部跳转"});
  }

  void navigateToThirdPage() {
    BoostNavigator.instance.push("thirdPage", arguments: {"data": "flutter 内部跳转,等待参数回传"},
        withContainer: true, opaque: false).then((value) {
      var map = value as Map;
      String data = map['pop'];
      debugPrint("result = pop = $data");
      result.value = data;
    });
  }

  void callMethod() {
    callNativeMethod("showLoading", {"msg" : "加载中"});
    Future.delayed(const Duration(seconds: 5)).then((v){
      callNativeMethod("dismissLoading");
    });
  }

  void changeLocal(String localName){
    SharedPrefsUtils.setString('local', localName);
    _MyAppState.setting.changeLocale!(Locale(localName));
  }

  void openListPage() {
    BoostNavigator.instance.push("listPage");
  }

  void openScreenAdaptPage() {
    BoostNavigator.instance.push("screenAdaptPage");
  }

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