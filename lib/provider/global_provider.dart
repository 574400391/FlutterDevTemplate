import 'package:flutter/widgets.dart';

/// 全局状态管理者示例
class GlobalProvider extends ChangeNotifier {

  bool _isLogin = false; // 是否已登录
  bool get isLogin => _isLogin;

  String? _userAccount = ""; // 登录账号
  String? get userAccount => _userAccount;

  void login(String? userAccount) {
    _isLogin = true;
    _userAccount = userAccount;
    notifyListeners();
  }

  /// 退出登录
  void logout() {
    if (_isLogin) {
      _isLogin = false;
      _userAccount = "";
      notifyListeners();
    }
  }
}
