import 'package:flutter/foundation.dart';

/// 运行时参数配置
class Constant {

  /// 是否打印日志，此处根据构建模式区分，debug/profile版本打印日志，release版本屏蔽日志
  static const bool showLog = kReleaseMode;

  /// 是否存储日志，默认为false，自行修改
  static const bool saveLog = false;

  /// 存储日志时是否加密日志，默认为false，自行修改
  static const bool encryptLog = false;

  /// aes对称加密key
  /// TODO：需修改
  static const String aesEncryptKey = "eENuAKZDTF+rasrMePeguLoIEifVIb9P";

  /// 当前app版本和名称，程序初始化时获取
  static String currentVersionName = 'APP_V1.0.0';

}