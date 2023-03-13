import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_template/common/router_manager.dart';
import 'package:flutter_dev_template/config/constant.dart';
import 'package:flutter_dev_template/db/db_manager.dart';
import 'package:flutter_dev_template/provider/global_provider.dart';
import 'package:flutter_dev_template/utils/device_utils.dart';
import 'package:flutter_dev_template/utils/log_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'common/sp_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesManager.getInstance();
  DbManager.instance;
  // 设置Android透明状态栏，默认半透明
  if (Device.isAndroid) {
    const SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MultiProvider(
    providers: [
      /// 全局provider示例
      /// 尽量控制provider在最小的widget节点范围内使用
      ChangeNotifierProvider<GlobalProvider>(
        create: (_) => GlobalProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

// 全局的路由监听者，可在需要的widget中添加，应该放到一个全局定义的文件中 此配置是为了pop对话框消失的问题
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    Log.init();
    _initAppConfig();
    _initAppVersion();
  }

  /// 初始化编译时配置文件
  _initAppConfig() {
    Constant.currentBuildName = const String.fromEnvironment('channel');
    Constant.exampleApiBaseUrl = const String.fromEnvironment('exampleApiUrl');
    Log.d(
        'currentBuildName: ${Constant.currentBuildName}, exampleApiBaseUrl: ${Constant.exampleApiBaseUrl}',
        tag: '_initAppConfig',
        saveLog: true);
  }

  /// 初始化应用版本描述信息
  _initAppVersion() async {
    String platform =
        Device.isAndroid ? 'Android' : (Device.isIOS ? 'iOS' : 'Other');
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    String buildType = kReleaseMode
        ? 'release'
        : (kProfileMode ? 'profile' : (kDebugMode ? 'debug' : 'other'));
    // String appName = packageInfo.appName;
    // String variants = 'APP';
    // String fullVersionName =
    //     '${appName}_${platform}_${variants}_${buildType}_$appVersion';
    // Log.d('fullVersionName: $fullVersionName');

    // WangHL: 拼装为 Android_debug_1.0.0
    String appVersionName = '${platform}_${buildType}_$appVersion';
    Constant.currentVersionName = appVersionName;
    Log.d('currentVersionName: ${Constant.currentVersionName}');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Log.d("MyApp build");
    // 根据设计稿尺寸进行屏幕适配,单位是px
    return OKToast(
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
      child: MaterialApp(
        onGenerateRoute: RouterManager.generateRoute,
        navigatorObservers: [routeObserver],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('zh', 'CN'),
        ],
      ),
    );
  }
}

/// WangHL：函数防抖
///     防止在一定时间内多次重复点击导致的bug，将用户的点击事件延时指定时间后进行调用，
///     如果延时时间内有重复的事件，则取消上一次事件
/// [func]: 要执行的方法
/// [delay]: 要迟延的时长
///
/// 应用场景：
///   1. 监听输入框内容变化自动查询网络/本地数据库的情况，
///       在指定时间内只接收用户最后一次编辑的输入内容，
///       避免因输入速度过快导致多次无效的查询请求
Function() debounce(
  Function func, {
  Duration delay = const Duration(milliseconds: 500),
}) {
  Timer? timer;
  target() {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(delay, () {
      func.call();
    });
  }

  return target;
}

/// WangHL: 防止重复点击，执行传入函数时需等到函数执行完成后才可以再次调用
///
/// 应用场景：
///   1. 按钮点击时触发业务流程操作，避免多次点击导致多次执行相同的业务流程导致bug
///   2. 下拉刷新、上拉加载
Function? throttle(
  Future Function()? func,
) {
  if (func == null) {
    return func;
  }
  bool enable = true;
  target() {
    if (enable == true) {
      enable = false;
      func().then((_) {
        enable = true;
      });
    }
  }

  return target;
}
