import 'package:flutter/material.dart';
import 'package:flutter_dev_template/provider/global_provider.dart';
import 'package:flutter_dev_template/ui/page/home/main_page.dart';
import 'package:flutter_dev_template/ui/page/login/login_page.dart';
import 'package:flutter_dev_template/utils/log_utils.dart';
import 'package:provider/provider.dart';

/// 全局路由管理,新增页面需要在这里进行注册,使用RouteName.xxx进行调用
class RouteName {
  /// 启动页
  static const String main = '/'; // 主页

  /// 登录/注册相关
  static const String login = '/login'; // 登录页面
}

class RouterManager {
  static const String _tag = "RouterManager";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map? args = settings.arguments as Map<dynamic, dynamic>?;
    Log.d(
        "navigate to ${settings.name} page${args == null ? '' : ', arguments is ${args.toString()}'}",
        tag: _tag);
    Log.saveLog(
        "navigate to ${settings.name} page${args == null ? '' : ', arguments is ${args.toString()}'}",
        tag: _tag);
    switch (settings.name) {
      case RouteName.main:
        return MaterialPageRoute(builder: (_) => MainPage());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      default:
        // 未定义路由时暂时跳转首页
        return MaterialPageRoute(builder: (_) => MainPage());
    }
  }

  /// WangHL: 路由跳转前增加判断，如果未登录，则跳转登录页面
  static Route<dynamic> judgeLoginStateRoute(Widget widget) {
    return MaterialPageRoute(builder: (context) {
      return (context.read<GlobalProvider>().isLogin) ? widget : LoginPage();
    });
  }

  static popSaveLog(String page) {
    Log.saveLog('pop to $page', tag: _tag);
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = const Duration(milliseconds: 300);
  Widget child;

  PopRoute({required this.child});

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
